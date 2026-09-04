<script setup lang="ts">
import { computed } from 'vue'
import { useData, withBase } from 'vitepress'

const { lang } = useData()
const isZh = computed(() => lang.value === 'zh-CN')
const t = (zh: string, en: string) => (isZh.value ? zh : en)

const layers = computed(() => [
  {
    index: '01',
    name: t('模型', 'MODEL'),
    title: t('生成文字', 'Generates text'),
    copy: t('一次模型调用，理解与生成，但不会独立完成工作。', 'One model call that understands and generates, but cannot finish work alone.'),
    mark: 'λ',
  },
  {
    index: '02',
    name: 'HARNESS',
    title: t('让 Agent 真正工作', 'Makes one agent work'),
    copy: t('循环、上下文、工具执行、记忆、沙箱与审计组成可靠运行骨架。', 'Loop, context, tool execution, memory, sandbox, and audit form a reliable runtime.'),
    mark: '⟳',
  },
  {
    index: '03',
    name: 'OS',
    title: t('运行整支 Agent 队伍', 'Runs the agent fleet'),
    copy: t('统一生命周期、路由、调度、共享能力和企业治理。OryxOS 就在这一层。', 'Unifies lifecycle, routing, scheduling, shared capabilities, and governance. This is OryxOS.'),
    mark: '◉',
    active: true,
  },
])

const capabilities = computed(() => [
  {
    key: 'LLM',
    title: t('统一模型接入', 'Unified LLM access'),
    copy: t('通过 Provider 抽象和显式名称映射接入云端或本地模型，让 Agent 不绑定具体厂商。', 'Provider abstraction and explicit name mapping connect cloud or local models without binding an Agent to one vendor.'),
    meta: 'Provider abstraction / Explicit mapping',
    span: 'wide',
  },
  {
    key: 'REACT',
    title: t('自实现 ReAct', 'Inspectable ReAct'),
    copy: t('核心推理循环直接实现，模型决定动作，OryxOS 校验、执行并回填观察结果。', 'OryxOS directly owns the reasoning loop: the model chooses an action; the runtime validates, executes, and returns the observation.'),
    meta: 'Reason → Act → Observe',
  },
  {
    key: 'MEMORY',
    title: t('跨对话记忆', 'Cross-session memory'),
    copy: t('会话记忆与文件型长期记忆分层，先用关键词检索，并为未来向量检索预留接口。', 'Session and file-based long-term memory start with keyword retrieval and retain a path to future vector search.'),
    meta: 'Session + Long-term / File first',
  },
  {
    key: 'TOOLS',
    title: t('开放工具体系', 'Open tool system'),
    copy: t('基础方向覆盖文件、Shell 与 HTTP；从复用 MCP、自写 MCP 到原生 Java，按门槛逐级扩展。', 'The foundation covers files, Shell, and HTTP, then scales from reused MCP to custom MCP and native Java.'),
    meta: 'Agent directory → MCP → Native Java',
  },
  {
    key: 'API',
    title: t('面向业务的对外服务', 'External service boundary'),
    copy: t('运行能力通过 REST API 对外暴露，让任何开发语言和业务系统都能使用 HTTP 接入。', 'REST APIs expose runtime capabilities so business systems written in any language can integrate over HTTP.'),
    meta: 'REST / Language agnostic',
    span: 'wide',
  },
])

const barriers = computed(() => [
  { index: '01', title: t('定义要写代码', 'Agents require code'), copy: t('最懂业务的人无法直接定义 Agent。', 'The people who know the work cannot define the Agent directly.') },
  { index: '02', title: t('数据必须离域', 'Data leaves your domain'), copy: t('隐私、合规与内部系统访问成为阻碍。', 'Privacy, compliance, and access to internal systems become blockers.') },
  { index: '03', title: t('执行过程黑盒', 'Execution is opaque'), copy: t('没有隔离、白名单和审计，企业不敢执行真实动作。', 'Without isolation, allowlists, and audit, real actions are too risky.') },
  { index: '04', title: t('一群 Agent 难管理', 'A fleet is hard to run'), copy: t('生命周期、共享能力和协作缺少统一操作系统层。', 'Lifecycle, shared capabilities, and collaboration lack a common OS layer.') },
])

const roadmap = computed(() => [
  { phase: t('阶段一 · 当前', 'PHASE 1 · CURRENT'), title: t('单机运行时内核', 'Single-node kernel'), copy: t('先跑通五大核心能力、配置即 Agent、多 Agent 并存、REST 与 MCP。', 'Complete the five core capabilities, configuration-as-Agent, multi-Agent operation, REST, and MCP on one reliable node.'), state: 'current' },
  { phase: t('阶段二 · 规划', 'PHASE 2 · PLANNED'), title: t('分布式底座', 'Distributed foundation'), copy: t('运行节点无状态化，状态外置，通过多副本支撑高可用与规模化。', 'Make runtime nodes stateless, externalize durable state, and add replicas for scale and availability.'), state: 'planned' },
  { phase: t('阶段三 · 愿景', 'PHASE 3 · VISION'), title: t('跨节点协作', 'Cross-node collaboration'), copy: t('对接 A2A，实现 Agent 发现、委托与可靠异步协作。', 'Integrate A2A for Agent discovery, delegation, and reliable asynchronous collaboration.'), state: 'vision' },
])

const terminalSteps = computed(() => [
  t('发布自然语言任务', 'Publish natural-language task'),
  t('拆解工作', 'Decompose the work'),
  t('组织 Agent 团队', 'Assemble an Agent team'),
  t('分工协作', 'Collaborate securely'),
  t('交付一个结果', 'Deliver one outcome'),
])
</script>

<template>
  <main class="site-home">
    <section class="hero">
      <div class="grid-field" aria-hidden="true"></div>
      <div class="horizon" aria-hidden="true"></div>
      <div class="hero-shell">
        <div class="hero-copy">
          <div class="status-chip"><span></span>{{ t('北极星愿景 · 开源 · 私有部署', 'NORTH-STAR VISION · OPEN SOURCE · SELF-HOSTED') }}</div>
          <h1>
            <span>{{ t('说出意图。', 'Give intent.') }}</span>
            <strong>{{ t('交付结果。', 'Get outcomes.') }}</strong>
          </h1>
          <p class="hero-lead">
            {{ t(
              'OryxOS 是企业 Agent Harness OS。北极星体验是：发布一句自然语言任务，由底座拆解并组织 Agent 团队协作，最终交付一个结果。',
              'OryxOS is the enterprise Agent Harness OS. Its north star: publish one task in plain language, let the foundation assemble an Agent team, and deliver one outcome.'
            ) }}
          </p>
          <div class="hero-actions">
            <a class="button primary" :href="isZh ? withBase('/zh/docs/what') : withBase('/docs/what')">
              {{ t('理解 OryxOS', 'Understand OryxOS') }} <span>→</span>
            </a>
            <a class="button secondary" href="https://github.com/oryx-labs/oryxos" target="_blank" rel="noreferrer">
              GitHub <span>↗</span>
            </a>
          </div>
          <div class="hero-proof">
            <div><strong>01</strong><span>{{ t('一个目录定义 Agent', 'directory defines an Agent') }}</span></div>
            <div><strong>05</strong><span>{{ t('五大核心能力', 'core capabilities') }}</span></div>
            <div><strong>21</strong><span>{{ t('Java 运行基线', 'Java runtime baseline') }}</span></div>
          </div>
        </div>

        <div class="hero-console" aria-label="OryxOS agent launch sequence">
          <div class="console-orbit" aria-hidden="true"><i></i><i></i><i></i></div>
          <div class="console-card">
            <div class="console-bar">
              <span class="console-signal"></span>
              <code>ORYX::CONTROL_PLANE</code>
              <span class="console-live">LIVE</span>
            </div>
            <div class="console-command">
              <span class="prompt">›</span>
              <span>{{ t('分析本周客户反馈，制定修复计划并交付报告', 'Analyze customer feedback, plan fixes, and deliver a report') }}</span>
            </div>
            <div class="console-flow">
              <div v-for="(step, index) in terminalSteps" :key="step" class="flow-row">
                <span class="flow-index">0{{ index + 1 }}</span>
                <span class="flow-line"></span>
                <span class="flow-label">{{ step }}</span>
                <span class="flow-state">VISION</span>
              </div>
            </div>
            <div class="console-agent">
              <div class="agent-mark"><span></span></div>
              <div>
                <small>NORTH-STAR OUTCOME</small>
                <strong>verified-delivery.md</strong>
              </div>
              <code>PID 021</code>
            </div>
          </div>
        </div>
      </div>
      <div class="hero-rail" aria-hidden="true">
        <span>MODEL</span><i></i><span>HARNESS</span><i></i><span>OPERATING SYSTEM</span><i></i><span>OUTCOME</span>
      </div>
    </section>

    <section class="manifesto section-pad">
      <div class="section-index">01 / WHY AN OS</div>
      <div class="manifesto-grid">
        <h2>{{ t('瓶颈从来不只是模型。', 'The model was never the whole bottleneck.') }}</h2>
        <div class="manifesto-copy">
          <p>{{ t('裸模型只会生成文本。真正让 Agent 在生产环境可靠工作的，是模型之外的运行骨架。', 'A bare model generates text. What makes an agent reliable in production is the runtime wrapped around it.') }}</p>
          <p>{{ t('企业也不会只运行一个 Agent。OryxOS 建设统一的 Harness 和操作系统层，让一群 Agent 像进程一样被运行、管理并最终协作。', 'An enterprise will not run just one Agent. OryxOS is building the common Harness and OS layer so an Agent fleet can run, be managed, and ultimately collaborate like processes.') }}</p>
        </div>
      </div>
    </section>

    <section class="barrier-section section-pad">
      <div class="section-heading split">
        <div>
          <div class="section-index">02 / FOUR BARRIERS</div>
          <h2>{{ t('从 Demo 到生产，中间隔着四道门。', 'Four gates stand between demo and production.') }}</h2>
        </div>
        <p>{{ t('OryxOS 的价值不在包装另一个模型，而在系统性拆掉定义、数据、执行和规模四类门槛。', 'OryxOS does not wrap yet another model. It systematically addresses definition, data, execution, and fleet-scale barriers.') }}</p>
      </div>
      <div class="barrier-grid">
        <article v-for="barrier in barriers" :key="barrier.index">
          <span>{{ barrier.index }}</span>
          <h3>{{ barrier.title }}</h3>
          <p>{{ barrier.copy }}</p>
        </article>
      </div>
    </section>

    <section class="layer-section section-pad">
      <div class="section-heading">
        <div class="section-index">03 / THE STACK</div>
        <h2>Model → Harness → OS</h2>
      </div>
      <div class="layer-grid">
        <article v-for="layer in layers" :key="layer.name" class="layer-card" :class="{ active: layer.active }">
          <div class="layer-top"><span>{{ layer.index }}</span><b>{{ layer.mark }}</b></div>
          <div class="layer-name">{{ layer.name }}</div>
          <h3>{{ layer.title }}</h3>
          <p>{{ layer.copy }}</p>
          <div v-if="layer.active" class="you-are-here">← ORYXOS / YOU ARE HERE</div>
        </article>
      </div>
    </section>

    <section class="formula-section">
      <div class="formula-shell">
        <div class="section-index light">04 / NORTH-STAR FORMULA</div>
        <div class="formula-copy">
          <h2>{{ t('把定义 Agent 的成本，压到趋近于零。', 'Drive the cost of defining an agent toward zero.') }}</h2>
          <p>{{ t('这条公式描述产品方向。每项能力都会按路线图逐步达到生产可用。', 'This formula is a product compass. Each capability reaches production readiness through the roadmap.') }}</p>
        </div>
        <div class="formula">
          <span class="intent">{{ t('自然语言', 'INTENT') }}</span><b>+</b><span>Memory</span><b>+</b><span>Tools</span><b>+</b><span>MCP</span><b>+</b><span>Skills</span><b>+</b><span>Knowledge</span><b>+</b><span>Notify</span><b>=</b><strong>AGENT</strong>
        </div>
        <div class="agent-file">
          <div class="file-head"><span>AGENT.md</span><em>{{ t('目标形态：配置即 AGENT', 'TARGET FORM: CONFIGURATION IS THE AGENT') }}</em></div>
          <pre><code><span class="muted">---</span>
<span class="orange">name:</span> production-sentinel
<span class="orange">provider:</span> deepseek
<span class="orange">tools:</span> [shell, http_get, notify]
<span class="orange">schedule:</span> "0 0 9 * * *"
<span class="muted">---</span>

{{ t('检查生产环境。发现异常时，先分析影响，再通知负责人。', 'Inspect production. When anomalies appear, assess impact and notify the owner.') }}</code></pre>
        </div>
      </div>
    </section>

    <section class="capability-section section-pad">
      <div class="section-heading split">
        <div>
          <div class="section-index">05 / FIVE CORE CAPABILITIES</div>
          <h2>{{ t('先把单节点内核做扎实。', 'Earn the OS from a solid kernel.') }}</h2>
        </div>
        <p>{{ t('阶段一聚焦模型接入、ReAct、记忆、工具和 REST 五大能力；它们是未来 Agent OS 的可靠地基。', 'Phase 1 focuses on LLM access, ReAct, memory, tools, and REST—the reliable foundation for the future Agent OS.') }}</p>
      </div>
      <div class="capability-grid">
        <article v-for="capability in capabilities" :key="capability.key" class="capability-card" :class="capability.span">
          <div class="capability-key">{{ capability.key }}</div>
          <h3>{{ capability.title }}</h3>
          <p>{{ capability.copy }}</p>
          <code>{{ capability.meta }}</code>
        </article>
      </div>
    </section>

    <section id="architecture" class="architecture-section section-pad">
      <div class="section-heading split">
        <div>
          <div class="section-index">06 / ARCHITECTURE</div>
          <h2>{{ t('边界清楚，控制权在你手里。', 'Clear boundaries. Control stays yours.') }}</h2>
        </div>
        <p>{{ t('触发入口、执行内核、共享能力与持久化分层解耦。外部模型和 MCP 只能通过明确适配边界进入。', 'Entry points, execution kernel, shared capabilities, and persistence remain decoupled. Models and MCP enter only through explicit adapter boundaries.') }}</p>
      </div>
      <div class="architecture-frame">
        <div class="frame-bar"><span>ORYXOS / SYSTEM MAP</span><code>REV. 2026.09</code></div>
        <img :src="withBase('/images/architecture.svg')" alt="OryxOS system architecture" loading="lazy" />
      </div>
    </section>

    <section class="trajectory-section section-pad">
      <div class="section-index">07 / ROADMAP</div>
      <div class="trajectory-grid">
        <article v-for="item in roadmap" :key="item.phase" :class="`trajectory-${item.state}`">
          <span class="phase-state" :class="item.state"><i></i>{{ item.phase }}</span>
          <h2>{{ item.title }}</h2>
          <p>{{ item.copy }}</p>
        </article>
      </div>
      <p class="roadmap-note">{{ t('横向演进：多租户 · SSO · 完整审计 · 工具策略 · 可观测 · Web 管理', 'CROSS-CUTTING: MULTI-TENANCY · SSO · FULL AUDIT · TOOL POLICY · OBSERVABILITY · WEB MANAGEMENT') }}</p>
    </section>

    <section class="launch-section">
      <div class="launch-shell">
        <div class="launch-copy">
          <div class="section-index light">08 / CURRENT BASELINE</div>
          <h2>{{ t('一份二进制。零仪式感。', 'One binary. Zero ceremony.') }}</h2>
          <p>{{ t('当前仓库提供 Java 21、Maven 九模块、可执行 Boot JAR、可执行 CLI 和最小健康接口。Agent 能力正在阶段一逐步实现。', 'The repository currently provides Java 21, nine Maven modules, executable Boot and CLI JARs, and a minimal health endpoint. Agent capabilities are progressing through Phase 1.') }}</p>
          <div class="launch-actions">
            <a class="button primary" href="https://github.com/oryx-labs/oryxos" target="_blank" rel="noreferrer">{{ t('开始构建', 'Start building') }} →</a>
            <a class="text-link" :href="isZh ? withBase('/zh/docs/what') : withBase('/docs/what')">{{ t('阅读设计原则', 'Read the design principles') }}</a>
          </div>
        </div>
        <div class="terminal">
          <div class="terminal-title"><span></span><span></span><span></span><code>oryxos — zsh</code></div>
          <pre><code><span class="dim">$</span> git clone https://github.com/oryx-labs/oryxos.git
<span class="dim">$</span> cd oryxos
<span class="dim">$</span> mvn package -DskipTests

<span class="dim">$</span> java -jar oryxos-boot/target/oryxos-boot-0.1.0-SNAPSHOT.jar
<span class="green">✓</span> boot         <span class="green">ONLINE</span>
<span class="green">✓</span> health       http://localhost:8080/health
<span class="cursor">█</span></code></pre>
        </div>
      </div>
    </section>

    <footer class="site-footer">
      <div><strong>OryxOS</strong><span>{{ t('企业 Agent Harness OS', 'THE AGENT HARNESS OS') }}</span></div>
      <p>Apache License 2.0 · Java 21 · Spring Boot 3</p>
      <a href="https://github.com/oryx-labs/oryxos">github.com/oryx-labs/oryxos ↗</a>
    </footer>
  </main>
</template>

<style scoped>
.site-home {
  --ink: #0a0c10;
  --panel: #11141a;
  --panel-2: #171b22;
  --paper: #f3f1eb;
  --paper-2: #e8e5dc;
  --orange: #ff6b2c;
  --orange-soft: #ff9a69;
  --mint: #78f7d4;
  --muted: #9399a5;
  overflow: hidden;
  background: var(--paper);
  color: var(--ink);
}

.section-pad { padding: 112px max(24px, calc((100vw - 1240px) / 2)); }
.section-index { margin-bottom: 34px; color: #777a80; font: 600 11px/1 'IBM Plex Mono', monospace; letter-spacing: .16em; }
.section-index.light { color: #737986; }
.section-heading { margin-bottom: 52px; }
.section-heading h2 { margin: 0; max-width: 780px; font-size: clamp(38px, 5vw, 68px); line-height: .98; letter-spacing: -.055em; }
.section-heading.split { display: grid; grid-template-columns: 1.5fr .8fr; gap: 80px; align-items: end; }
.section-heading.split p { margin: 0; color: #666a72; font-size: 15px; line-height: 1.8; }

.hero { position: relative; min-height: calc(100vh - 64px); padding: 90px 24px 0; overflow: hidden; background: var(--ink); color: #f8f6f0; isolation: isolate; }
.grid-field { position: absolute; inset: 0; z-index: -3; background-image: linear-gradient(rgba(255,255,255,.035) 1px, transparent 1px), linear-gradient(90deg, rgba(255,255,255,.035) 1px, transparent 1px); background-size: 64px 64px; mask-image: linear-gradient(to bottom, black 20%, transparent 88%); }
.horizon { position: absolute; z-index: -2; left: 53%; top: 45%; width: min(70vw, 900px); aspect-ratio: 1; border: 1px solid rgba(255,107,44,.22); border-radius: 50%; box-shadow: 0 0 100px rgba(255,107,44,.08), inset 0 0 100px rgba(255,107,44,.04); transform: translate(-50%, -50%); }
.horizon::before,.horizon::after { content: ''; position: absolute; inset: 12%; border: 1px solid rgba(120,247,212,.1); border-radius: 50%; }
.horizon::after { inset: 28%; border-color: rgba(255,255,255,.09); }
.hero-shell { display: grid; grid-template-columns: minmax(0, 1.12fr) minmax(410px, .88fr); gap: clamp(54px, 8vw, 120px); align-items: center; width: min(1240px, 100%); min-height: calc(100vh - 210px); margin: 0 auto; }
.hero-copy { position: relative; z-index: 2; }
.status-chip { display: inline-flex; align-items: center; gap: 10px; margin-bottom: 30px; color: #aeb3bd; font: 500 10px/1 'IBM Plex Mono', monospace; letter-spacing: .12em; }
.status-chip span { width: 7px; height: 7px; border-radius: 50%; background: var(--mint); box-shadow: 0 0 16px var(--mint); animation: blink 2.4s ease-in-out infinite; }
@keyframes blink { 50% { opacity: .35; } }
.hero h1 { margin: 0; font-size: clamp(62px, 8.6vw, 126px); line-height: .84; letter-spacing: -.075em; }
.hero h1 span,.hero h1 strong { display: block; }
.hero h1 span { font-weight: 480; }
.hero h1 strong { color: var(--orange); font-weight: 800; }
.hero-lead { max-width: 680px; margin: 36px 0 32px; color: #b6bbc4; font-size: clamp(16px, 1.5vw, 19px); line-height: 1.75; }
.hero-actions,.launch-actions { display: flex; align-items: center; gap: 12px; flex-wrap: wrap; }
.button { display: inline-flex; align-items: center; justify-content: center; gap: 18px; min-height: 48px; padding: 0 22px; border: 1px solid transparent; color: inherit; font-size: 13px; font-weight: 750; text-decoration: none; transition: transform .2s, background .2s, border-color .2s; }
.button:hover { transform: translateY(-2px); }
.button.primary { background: var(--orange); color: #0b0c0f; }
.button.primary:hover { background: #ff8150; }
.button.secondary { border-color: #343943; color: #e7e8ea; background: rgba(255,255,255,.025); }
.button.secondary:hover { border-color: #656c79; }
.hero-proof { display: flex; gap: 0; margin-top: 54px; border-top: 1px solid #272b33; }
.hero-proof div { display: flex; flex-direction: column; gap: 6px; min-width: 130px; padding: 18px 30px 0 0; }
.hero-proof strong { color: #f8f6f0; font: 500 24px/1 'IBM Plex Mono', monospace; }
.hero-proof span { color: #737986; font-size: 10px; text-transform: uppercase; letter-spacing: .08em; }
.hero-console { position: relative; z-index: 1; display: grid; place-items: center; min-height: 530px; }
.console-orbit { position: absolute; width: 520px; aspect-ratio: 1; border: 1px solid rgba(255,255,255,.08); border-radius: 50%; animation: rotate 40s linear infinite; }
.console-orbit::before,.console-orbit::after { content:''; position:absolute; border:1px solid rgba(255,107,44,.16); border-radius:50%; }
.console-orbit::before { inset: 13%; }.console-orbit::after { inset: 29%; border-color: rgba(120,247,212,.12); }
.console-orbit i { position: absolute; width: 8px; height: 8px; border-radius: 50%; background: var(--orange); box-shadow: 0 0 18px var(--orange); }
.console-orbit i:nth-child(1){top:10%;left:20%}.console-orbit i:nth-child(2){right:3%;top:48%;background:var(--mint);box-shadow:0 0 18px var(--mint)}.console-orbit i:nth-child(3){bottom:6%;left:32%;width:5px;height:5px}
@keyframes rotate { to { transform: rotate(360deg); } }
.console-card { position: relative; width: min(100%, 470px); border: 1px solid #333842; background: rgba(14,17,22,.91); box-shadow: 0 35px 90px rgba(0,0,0,.45); backdrop-filter: blur(18px); }
.console-bar { display: flex; align-items: center; gap: 10px; height: 46px; padding: 0 16px; border-bottom: 1px solid #2a2f38; color: #777e8b; }
.console-bar code { font-size: 10px; letter-spacing: .08em; }
.console-signal { width: 8px; height: 8px; border: 1px solid var(--orange); transform: rotate(45deg); }
.console-live { margin-left: auto; color: var(--mint); font: 600 9px/1 'IBM Plex Mono',monospace; }
.console-command { display: flex; gap: 12px; padding: 23px 20px; border-bottom: 1px solid #20242b; color: #eceae4; font: 500 13px/1.6 'IBM Plex Mono',monospace; }
.console-command .prompt { color: var(--orange); }
.console-flow { padding: 16px 20px 18px; }
.flow-row { display: grid; grid-template-columns: 24px 36px 1fr auto; gap: 10px; align-items: center; min-height: 42px; color: #afb4bd; font: 500 11px/1 'IBM Plex Mono',monospace; }
.flow-index { color: #555c68; }.flow-line { height: 1px; background: #343a44; position: relative; }.flow-line::after { content:''; position:absolute; right:0; top:-2px; width:5px; height:5px; border-radius:50%; background:var(--mint); }.flow-state { color: #4e8d7f; font-size: 9px; }
.console-agent { display: grid; grid-template-columns: 42px 1fr auto; align-items: center; gap: 12px; margin: 0 20px 20px; padding: 16px; border: 1px solid rgba(255,107,44,.35); background: rgba(255,107,44,.06); }
.agent-mark { display:grid;place-items:center;width:38px;height:38px;border:1px solid var(--orange);border-radius:50%}.agent-mark span{width:8px;height:8px;background:var(--orange);border-radius:50%;box-shadow:0 0 14px var(--orange)}
.console-agent small { display:block;color:var(--orange);font:600 8px/1 'IBM Plex Mono',monospace;letter-spacing:.12em}.console-agent strong{display:block;margin-top:6px;color:#f4f1eb;font:500 12px/1 'IBM Plex Mono',monospace}.console-agent>code{color:#59606c;font-size:9px}
.hero-rail { display:flex;align-items:center;justify-content:center;gap:22px;width:min(1240px,100%);height:64px;margin:20px auto 0;border-top:1px solid #272b33;color:#5f6571;font:500 9px/1 'IBM Plex Mono',monospace;letter-spacing:.17em}.hero-rail i{width:26px;height:1px;background:#393e47}

.manifesto { background: var(--paper); }
.manifesto-grid { display:grid;grid-template-columns:1.25fr .75fr;gap:110px;align-items:start}.manifesto h2{margin:0;font-size:clamp(48px,7vw,94px);line-height:.96;letter-spacing:-.065em}.manifesto-copy{padding-top:10px}.manifesto-copy p{margin:0 0 22px;color:#62656b;font-size:16px;line-height:1.8}.manifesto-copy p:last-child{color:#15171a;font-weight:650}

.barrier-section{background:var(--orange);color:#111}.barrier-section .section-index,.barrier-section .section-heading.split p{color:#682711}.barrier-grid{display:grid;grid-template-columns:repeat(4,1fr);border-top:1px solid rgba(20,10,5,.42);border-left:1px solid rgba(20,10,5,.42)}.barrier-grid article{min-height:245px;padding:26px;border-right:1px solid rgba(20,10,5,.42);border-bottom:1px solid rgba(20,10,5,.42);background:rgba(255,255,255,.05)}.barrier-grid span{font:600 11px/1 'IBM Plex Mono',monospace}.barrier-grid h3{margin:70px 0 14px;font-size:23px;letter-spacing:-.035em}.barrier-grid p{margin:0;color:#682711;font-size:13px;line-height:1.7}

.layer-section { background: var(--paper-2); border-top:1px solid #d7d3c9;border-bottom:1px solid #d7d3c9}.layer-grid{display:grid;grid-template-columns:repeat(3,1fr);border:1px solid #cac6bc}.layer-card{position:relative;min-height:370px;padding:28px;border-right:1px solid #cac6bc;background:rgba(255,255,255,.16)}.layer-card:last-child{border-right:0}.layer-card.active{background:var(--ink);color:#f7f5ef}.layer-top{display:flex;justify-content:space-between;align-items:center;color:#888b90;font:500 11px/1 'IBM Plex Mono',monospace}.layer-top b{font-size:28px;font-weight:400}.layer-card.active .layer-top b{color:var(--orange)}.layer-name{margin-top:72px;color:#777a80;font:600 11px/1 'IBM Plex Mono',monospace;letter-spacing:.15em}.layer-card h3{margin:18px 0 16px;font-size:27px;letter-spacing:-.04em}.layer-card p{margin:0;color:#696c72;font-size:14px;line-height:1.75}.layer-card.active p{color:#9ca2ad}.you-are-here{position:absolute;right:0;bottom:0;left:0;padding:15px 28px;background:var(--orange);color:#111;font:700 9px/1 'IBM Plex Mono',monospace;letter-spacing:.11em}

.formula-section{padding:112px 24px;background:var(--ink);color:#f7f5ef}.formula-shell{width:min(1240px,100%);margin:0 auto}.formula-copy{display:grid;grid-template-columns:1.3fr .7fr;gap:90px;align-items:end}.formula-copy h2{margin:0;font-size:clamp(40px,5.5vw,76px);line-height:.98;letter-spacing:-.06em}.formula-copy p{margin:0;color:#999faa;line-height:1.75}.formula{display:flex;align-items:center;gap:13px;flex-wrap:wrap;margin:64px 0 28px;padding:26px;border:1px solid #30353e;background:#0d1015;font:500 13px/1 'IBM Plex Mono',monospace}.formula span{padding:9px 12px;border:1px solid #343a44;color:#b8bdc6}.formula .intent{border-color:var(--mint);color:var(--mint)}.formula b{color:#555c68}.formula strong{padding:10px 16px;background:var(--orange);color:#0a0c10;letter-spacing:.08em}.agent-file{display:grid;grid-template-columns:210px 1fr;border:1px solid #30353e;background:#101319}.file-head{display:flex;flex-direction:column;justify-content:space-between;padding:24px;border-right:1px solid #30353e}.file-head span{color:var(--orange);font:600 14px/1 'IBM Plex Mono',monospace}.file-head em{color:#626975;font:500 9px/1.6 'IBM Plex Mono',monospace;letter-spacing:.08em;font-style:normal}.agent-file pre{overflow-x:auto;margin:0;padding:26px 30px;background:transparent;color:#d8d9dc;font:400 12px/1.7 'IBM Plex Mono',monospace}.agent-file code{font:inherit}.agent-file .orange{color:var(--orange-soft)}.agent-file .muted{color:#5a616d}

.capability-section{background:var(--paper)}.capability-grid{display:grid;grid-template-columns:repeat(3,1fr);border-top:1px solid #cbc7bd;border-left:1px solid #cbc7bd}.capability-card{display:flex;flex-direction:column;min-height:300px;padding:28px;border-right:1px solid #cbc7bd;border-bottom:1px solid #cbc7bd;background:rgba(255,255,255,.22);transition:background .25s,transform .25s}.capability-card:hover{background:#fff;transform:translateY(-4px)}.capability-card.wide{grid-column:span 2}.capability-key{color:var(--orange);font:600 10px/1 'IBM Plex Mono',monospace;letter-spacing:.13em}.capability-card h3{margin:52px 0 15px;font-size:25px;letter-spacing:-.04em}.capability-card p{max-width:520px;margin:0 0 30px;color:#666a71;font-size:14px;line-height:1.72}.capability-card code{margin-top:auto;color:#7b7e84;font-size:10px;letter-spacing:.03em}

.architecture-section{background:#dedbd2}.architecture-frame{border:1px solid #aaa69d;background:#0a0c10;box-shadow:0 35px 80px rgba(25,22,17,.18)}.frame-bar{display:flex;justify-content:space-between;align-items:center;height:45px;padding:0 18px;border-bottom:1px solid #292e37;color:#737a86;font:500 9px/1 'IBM Plex Mono',monospace;letter-spacing:.12em}.frame-bar span::before{content:'';display:inline-block;width:7px;height:7px;margin-right:10px;background:var(--mint);border-radius:50%;box-shadow:0 0 12px var(--mint)}.architecture-frame img{display:block;width:100%;height:auto}

.trajectory-section{background:var(--paper)}.trajectory-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:1px;background:#c9c5bb;border:1px solid #c9c5bb}.trajectory-grid article{min-height:390px;padding:36px;background:var(--paper)}.trajectory-planned{background:#e6e2d9!important}.trajectory-vision{background:#15181e!important;color:#f7f5ef}.phase-state{display:flex;align-items:center;gap:10px;color:#4e695f;font:600 9px/1 'IBM Plex Mono',monospace;letter-spacing:.14em}.phase-state i{width:7px;height:7px;border-radius:50%;background:#38b989;box-shadow:0 0 12px #38b989}.phase-state.planned{color:#7c5b4c}.phase-state.planned i{background:#b6876f;box-shadow:none}.phase-state.vision{color:var(--orange-soft)}.phase-state.vision i{background:var(--orange);box-shadow:0 0 12px var(--orange)}.trajectory-grid h2{max-width:480px;margin:86px 0 20px;font-size:clamp(29px,3.5vw,46px);line-height:1.02;letter-spacing:-.055em}.trajectory-grid p{max-width:520px;margin:0;color:#686b71;line-height:1.75}.trajectory-vision p{color:#969ca7}.roadmap-note{margin:18px 0 0;color:#777a80;font:600 9px/1.6 'IBM Plex Mono',monospace;letter-spacing:.09em}

.launch-section{padding:100px 24px;background:var(--orange);color:#0a0c10}.launch-shell{display:grid;grid-template-columns:1fr 1fr;gap:90px;align-items:center;width:min(1240px,100%);margin:0 auto}.launch-copy .section-index{color:#7e3015}.launch-copy h2{margin:0;font-size:clamp(48px,6vw,82px);line-height:.94;letter-spacing:-.065em}.launch-copy p{max-width:580px;margin:26px 0 34px;color:#57210f;line-height:1.72}.launch-section .button.primary{background:#0a0c10;color:#fff}.text-link{color:#381508;font-size:13px;font-weight:700}.terminal{border:1px solid rgba(0,0,0,.65);background:#0b0d11;color:#d6d8dc;box-shadow:18px 18px 0 rgba(0,0,0,.16)}.terminal-title{display:flex;align-items:center;gap:7px;height:42px;padding:0 15px;border-bottom:1px solid #2a2e36}.terminal-title span{width:7px;height:7px;border:1px solid #575e69;border-radius:50%}.terminal-title code{margin-left:auto;color:#5f6672;font-size:9px}.terminal pre{overflow-x:auto;margin:0;padding:28px;font:400 11px/1.85 'IBM Plex Mono',monospace}.terminal code{font:inherit}.terminal .dim{color:#656c77}.terminal .green{color:var(--mint)}.cursor{color:var(--orange);animation:blink 1s steps(1) infinite}

.site-footer{display:grid;grid-template-columns:1fr auto auto;gap:40px;align-items:center;padding:34px max(24px,calc((100vw - 1240px)/2));background:#080a0d;color:#777e8a;border-top:1px solid #242832;font:500 10px/1.4 'IBM Plex Mono',monospace}.site-footer div{display:flex;align-items:center;gap:16px}.site-footer strong{color:#f4f1eb;font-size:14px}.site-footer a{color:var(--orange);text-decoration:none}

@media (max-width: 980px){
  .section-pad{padding-top:84px;padding-bottom:84px}.hero-shell{grid-template-columns:1fr;min-height:auto}.hero-console{min-height:540px}.hero h1{font-size:clamp(66px,14vw,110px)}.manifesto-grid,.formula-copy,.section-heading.split,.launch-shell{grid-template-columns:1fr;gap:42px}.barrier-grid{grid-template-columns:1fr 1fr}.layer-grid{grid-template-columns:1fr}.layer-card{min-height:280px;border-right:0;border-bottom:1px solid #cac6bc}.capability-grid{grid-template-columns:1fr 1fr}.capability-card.wide{grid-column:span 1}.trajectory-grid{grid-template-columns:1fr}.trajectory-grid article{min-height:320px}.trajectory-grid h2{margin-top:62px}.site-footer{grid-template-columns:1fr 1fr}.site-footer>a{grid-column:1/-1}
}
@media (max-width: 640px){
  .section-pad{padding:70px 20px}.hero{padding:68px 20px 0}.hero h1{font-size:clamp(57px,18vw,84px)}.hero-lead{font-size:15px}.hero-proof{gap:14px}.hero-proof div{min-width:0;padding-right:8px}.hero-proof strong{font-size:20px}.hero-proof span{font-size:8px}.hero-console{min-height:490px}.console-orbit{width:410px}.console-card{width:100%}.flow-row{grid-template-columns:22px 26px 1fr}.flow-state{display:none}.console-agent{grid-template-columns:38px 1fr}.console-agent>code{display:none}.hero-rail{gap:10px;white-space:nowrap}.hero-rail i{width:8px}.hero-rail span{font-size:7px}.manifesto h2{font-size:48px}.barrier-grid{grid-template-columns:1fr}.barrier-grid article{min-height:210px}.barrier-grid h3{margin-top:52px}.layer-card{padding:24px}.formula{gap:8px}.formula span{padding:8px}.agent-file{grid-template-columns:1fr}.file-head{gap:34px;border-right:0;border-bottom:1px solid #30353e}.capability-grid{grid-template-columns:1fr}.capability-card{min-height:270px}.trajectory-grid{grid-template-columns:1fr}.trajectory-grid article{min-height:300px;padding:28px}.trajectory-grid h2{margin-top:58px}.launch-section{padding:76px 20px}.launch-copy h2{font-size:50px}.terminal{box-shadow:10px 10px 0 rgba(0,0,0,.16)}.site-footer{grid-template-columns:1fr;padding:30px 20px}.site-footer>a{grid-column:auto}
}

@media (prefers-reduced-motion: reduce){
  .console-orbit,.status-chip span,.cursor{animation:none}.button,.capability-card{transition:none}
}
</style>
