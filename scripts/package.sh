#!/usr/bin/env bash
# Copyright 2023 RobustMQ Team
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Package changed OryxOS source files into a temporary tar.gz, upload them to
# the remote checkout, and synchronize the Git branch there.
#
# Maven target directories are always excluded, even if a target file was
# accidentally tracked by Git.
#
# Usage:
#   ./scripts/package.sh [output_dir]
#
# Optional environment variables:
#   ORYXOS_REMOTE_HOST  SSH destination (default: root@117.72.92.117)
#   ORYXOS_REMOTE_DIR   Remote checkout (default: /root/oryxos)

set -euo pipefail

REMOTE_HOST="${ORYXOS_REMOTE_HOST:-root@117.72.92.117}"
REMOTE_DIR="${ORYXOS_REMOTE_DIR:-/root/oryxos}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
OUTPUT_DIR="${1:-$PROJECT_ROOT}"

info()  { echo "[INFO]  $*"; }
error() { echo "[ERROR] $*" >&2; }

for command_name in git tar scp ssh; do
  if ! command -v "$command_name" >/dev/null 2>&1; then
    error "Required command not found: ${command_name}"
    exit 1
  fi
done

if [[ ! -d "$OUTPUT_DIR" ]]; then
  error "Output directory does not exist: ${OUTPUT_DIR}"
  exit 1
fi

if [[ "$REMOTE_DIR" != /* || "$REMOTE_DIR" == "/" ]]; then
  error "ORYXOS_REMOTE_DIR must be an absolute path other than /."
  exit 1
fi

VERSION=$(git -C "$PROJECT_ROOT" describe --tags --always --dirty 2>/dev/null || echo "dev")
TIMESTAMP=$(date +%Y%m%d%H%M%S)_$$
ARCHIVE="$OUTPUT_DIR/oryxos-${VERSION}-${TIMESTAMP}.tar.gz"

# The archive is only a transport artifact and is removed on every exit path.
trap 'rm -f "$ARCHIVE"' EXIT

LOCAL_BRANCH=$(git -C "$PROJECT_ROOT" rev-parse --abbrev-ref HEAD)
if [[ "$LOCAL_BRANCH" == "HEAD" ]]; then
  error "Detached HEAD is not supported. Check out a branch first."
  exit 1
fi
info "Local branch: ${LOCAL_BRANCH}"

# Remove empty lines, generated Maven output, and transport archives. Keeping
# this filter in the script protects the transfer even when .gitignore changes.
filter_transfer_paths() {
  awk '
    NF &&
    $0 !~ /(^|\/)target(\/|$)/ &&
    $0 !~ /\.tar\.gz$/
  '
}

# Locally committed but not represented by the current origin branch.
COMMITTED_FILES=$(git -c core.quotePath=false -C "$PROJECT_ROOT" \
  diff --no-renames --name-only --diff-filter=ACM \
  "origin/${LOCAL_BRANCH}" HEAD 2>/dev/null | filter_transfer_paths || true)

# Staged and unstaged working-tree changes relative to HEAD.
WORKDIR_FILES=$(git -c core.quotePath=false -C "$PROJECT_ROOT" \
  diff --no-renames --name-only --diff-filter=ACM HEAD 2>/dev/null \
  | filter_transfer_paths || true)

# Untracked files; Git applies .gitignore before the explicit target filter.
UNTRACKED_FILES=$(git -c core.quotePath=false -C "$PROJECT_ROOT" \
  ls-files --others --exclude-standard 2>/dev/null \
  | filter_transfer_paths || true)

# Deletions are synchronized separately because they cannot be archived.
DELETED_RAW=$(printf '%s\n%s\n%s' \
  "$(git -c core.quotePath=false -C "$PROJECT_ROOT" \
      diff --no-renames --name-only --diff-filter=D \
      "origin/${LOCAL_BRANCH}" HEAD 2>/dev/null || true)" \
  "$(git -c core.quotePath=false -C "$PROJECT_ROOT" \
      diff --no-renames --cached --name-only --diff-filter=D 2>/dev/null || true)" \
  "$(git -c core.quotePath=false -C "$PROJECT_ROOT" \
      diff --no-renames --name-only --diff-filter=D 2>/dev/null || true)" \
  | filter_transfer_paths \
  | sort -u)

DELETED_FILES=""
while IFS= read -r file_path; do
  if [[ -n "$file_path" && ! -e "$PROJECT_ROOT/$file_path" ]]; then
    DELETED_FILES="${DELETED_FILES}${file_path}"$'\n'
  fi
done <<< "$DELETED_RAW"
DELETED_FILES="${DELETED_FILES%$'\n'}"

ALL_FILES=$(printf '%s\n%s\n%s' \
  "$COMMITTED_FILES" "$WORKDIR_FILES" "$UNTRACKED_FILES" \
  | filter_transfer_paths \
  | sort -u || true)

count_lines() {
  echo "$1" | grep -c '[^[:space:]]' 2>/dev/null || echo 0
}

echo "--- File sources ---"
info "[committed vs origin] $(count_lines "$COMMITTED_FILES") file(s)"
echo "$COMMITTED_FILES" | grep '[^[:space:]]' | sed 's/^/  + /' || true
info "[workdir vs HEAD]     $(count_lines "$WORKDIR_FILES") file(s)"
echo "$WORKDIR_FILES" | grep '[^[:space:]]' | sed 's/^/  ~ /' || true
info "[untracked]           $(count_lines "$UNTRACKED_FILES") file(s)"
echo "$UNTRACKED_FILES" | grep '[^[:space:]]' | sed 's/^/  ? /' || true
info "[deleted locally]     $(count_lines "$DELETED_FILES") file(s)"
echo "$DELETED_FILES" | grep '[^[:space:]]' | sed 's/^/  - /' || true
info "[excluded]            every target/ directory"
echo "--------------------"

if [[ -z "$ALL_FILES" ]]; then
  info "No added or modified files to package."
  SKIP_ARCHIVE=1
else
  SKIP_ARCHIVE=0
  FILE_COUNT=$(echo "$ALL_FILES" | grep -c '[^[:space:]]')
  info "Packaging ${FILE_COUNT} file(s):"
  echo "$ALL_FILES" | sed 's/^/  /'
  echo "$ALL_FILES" | tr '\n' '\0' \
    | COPYFILE_DISABLE=1 tar czf "$ARCHIVE" -C "$PROJECT_ROOT" --null -T -
  info "Archive created: $ARCHIVE ($(du -sh "$ARCHIVE" | cut -f1))"
fi

ARCHIVE_NAME="$(basename "$ARCHIVE")"
if [[ "$SKIP_ARCHIVE" -eq 0 ]]; then
  info "Uploading to ${REMOTE_HOST}:${REMOTE_DIR} ..."
  scp "$ARCHIVE" "${REMOTE_HOST}:${REMOTE_DIR}/"
  info "Upload complete: ${REMOTE_HOST}:${REMOTE_DIR}/${ARCHIVE_NAME}"
fi

# Colon separation follows the source RobustMQ script. Git paths containing a
# colon or newline are not supported by this synchronization helper.
DELETED_LIST=$(printf '%s' "$DELETED_FILES" | tr '\n' ':')

info "Synchronizing remote checkout ..."
ssh "$REMOTE_HOST" \
  REMOTE_DIR="$REMOTE_DIR" \
  LOCAL_BRANCH="$LOCAL_BRANCH" \
  ARCHIVE_NAME="$ARCHIVE_NAME" \
  SKIP_ARCHIVE="$SKIP_ARCHIVE" \
  DELETED_LIST="$DELETED_LIST" \
  'bash -s' <<'REMOTE_SCRIPT'
set -euo pipefail

info()  { echo "[INFO]  $*"; }
error() { echo "[ERROR] $*" >&2; }

cd "$REMOTE_DIR"

REMOTE_BRANCH=$(git rev-parse --abbrev-ref HEAD)
info "Remote branch: ${REMOTE_BRANCH}"
if [[ "$REMOTE_BRANCH" != "$LOCAL_BRANCH" ]]; then
  info "Switching to branch ${LOCAL_BRANCH} ..."
  git fetch origin --prune || true
  git fetch upstream --prune 2>/dev/null || true

  if git rev-parse --verify --quiet "refs/heads/${LOCAL_BRANCH}" >/dev/null; then
    git checkout "$LOCAL_BRANCH"
  elif git rev-parse --verify --quiet "refs/remotes/origin/${LOCAL_BRANCH}" >/dev/null; then
    git checkout -b "$LOCAL_BRANCH" "origin/${LOCAL_BRANCH}"
  elif git rev-parse --verify --quiet "refs/remotes/upstream/${LOCAL_BRANCH}" >/dev/null; then
    git checkout -b "$LOCAL_BRANCH" "upstream/${LOCAL_BRANCH}"
  else
    git checkout -b "$LOCAL_BRANCH"
  fi
fi

if git rev-parse --verify --quiet "refs/remotes/origin/${LOCAL_BRANCH}" >/dev/null; then
  info "Pulling origin/${LOCAL_BRANCH} ..."
  git pull --no-rebase origin "$LOCAL_BRANCH"
fi

if [[ "$SKIP_ARCHIVE" -eq 0 && -f "$ARCHIVE_NAME" ]]; then
  info "Extracting ${ARCHIVE_NAME} ..."
  tar xzf "$ARCHIVE_NAME" --warning=no-unknown-keyword
  rm -f "$ARCHIVE_NAME"
fi

find "$REMOTE_DIR" -maxdepth 1 -name 'oryxos-*.tar.gz' -delete

if [[ -n "$DELETED_LIST" ]]; then
  info "Removing locally deleted files on remote ..."
  IFS=':' read -ra deleted_paths <<< "$DELETED_LIST"
  for file_path in "${deleted_paths[@]}"; do
    [[ -z "$file_path" ]] && continue
    rm -f -- "$REMOTE_DIR/$file_path"
    info "  Deleted: ${file_path}"
  done
fi

git add -A
if git diff --cached --quiet; then
  info "Nothing to commit on remote."
else
  git commit -m 'dev'

  max_retries=3
  retry=0
  delay=2
  push_output=$(mktemp)
  trap 'rm -f "$push_output"' EXIT

  until git push origin "$LOCAL_BRANCH" 2>&1 | tee "$push_output"; do
    if grep -qiE 'refusing|403|permission|scope|authentication|not allowed' "$push_output"; then
      error "Push permanently rejected by authentication or permissions."
      exit 1
    fi

    retry=$((retry + 1))
    if [[ "$retry" -ge "$max_retries" ]]; then
      error "Push failed after ${max_retries} retries."
      exit 1
    fi

    info "Push failed; retrying in ${delay}s (${retry}/${max_retries}) ..."
    sleep "$delay"
    delay=$((delay * 2))
  done
fi

info "Remote synchronization complete."
REMOTE_SCRIPT

# Match the source workflow by committing the synchronized paths locally. The
# script intentionally stages only selected files, never target/ output.
if [[ -n "$ALL_FILES" || -n "$DELETED_FILES" ]]; then
  info "Committing synchronized files locally ..."

  while IFS= read -r file_path; do
    [[ -n "$file_path" ]] && git -C "$PROJECT_ROOT" add -- "$file_path" 2>/dev/null || true
  done <<< "$ALL_FILES"

  while IFS= read -r file_path; do
    [[ -n "$file_path" ]] && git -C "$PROJECT_ROOT" rm --cached -- "$file_path" 2>/dev/null || true
  done <<< "$DELETED_FILES"

  if git -C "$PROJECT_ROOT" diff --cached --quiet; then
    info "Nothing to commit locally."
  else
    git -C "$PROJECT_ROOT" commit -m 'dev'
    info "Local commit complete."
  fi
fi

info "All done."
