# What is OryxOS?

**OryxOS is the self-hosted Agent Harness OS for the enterprise.** Its north-star experience is to publish one task in natural language, let the foundation decompose it and assemble an Agent team, then have those Agents collaborate to deliver one result.

> OryxOS is currently in Phase 1: the single-node runtime kernel. The north star describes the product direction, not a claim that distributed Agent teamwork is already complete.

## The short version

A bare model generates text. A production Agent needs a Reason → Act → Observe loop, context assembly, controlled tool execution, memory, sandboxing, and audit. This machinery around the model is the **Agent Harness**.

An enterprise needs more than a runtime for one Agent. It needs a shared layer for many Agents: lifecycle, access channels, common services, policy, multi-tenancy, and eventually reliable cross-node collaboration. That is the **Agent Harness OS**.

| Layer | Scope | Responsibility |
| --- | --- | --- |
| Model | One LLM call | Understanding and generation |
| Agent runtime / Harness | One Agent | Loop, context, tools, memory, sandbox, audit |
| Agent Harness OS | Many Agents | Lifecycle, shared services, governance, communication, scale |

OryxOS is building the third layer, starting with a solid single-node runtime kernel.

## Why it needs to exist

Four barriers keep enterprise Agents in demos:

1. **Defining an Agent requires code.** The people who understand the work cannot directly define the Agent.
2. **Cloud platforms move data out of the domain.** Privacy, compliance, and access to internal systems become blockers.
3. **Execution is a black box.** Without isolation, allowlists, audit, and human approval boundaries, an enterprise cannot trust real actions.
4. **Running one Agent is easy; running many is hard.** There is no common operating layer for lifecycle, shared capabilities, and collaboration.

OryxOS responds with Markdown definitions, private deployment, policy-controlled execution, and an operating foundation designed for an Agent fleet.

## One directory = one Agent

The intended Agent definition is a directory rather than another application:

```text
.oryxos/agents/production-sentinel/
├── AGENT.md        # identity, provider, tools, and instructions
├── MEMORY.md       # Agent-scoped long-term memory
├── skills/         # reusable Skill bindings
└── scripts/        # optional deterministic operations
```

This is the direction of configuration-as-Agent: the directory declares intent and capability requirements; OryxOS supplies the runtime and control boundary.

## North-star formula

```text
Natural language (md) + Memory + Tool + MCP (Connector)
                      + Skill + Knowledge + Notify = one Agent
```

The formula is a product compass. Individual elements become production-ready through the roadmap below.

## Five core capabilities

### LLM integration

A Provider abstraction keeps Agents independent of a specific vendor. Explicit provider-name mapping supports multiple cloud or local inference services without ambiguous routing.

### ReAct loop

OryxOS will own the decision-making loop directly instead of delegating it to an external Agent framework. The model chooses whether and how to use a tool; OryxOS validates and executes the action, returns the observation, and continues until a final response or iteration limit.

### Memory

Session memory and long-term memory let an Agent retain state across conversations. Long-term memory starts as files with keyword retrieval while keeping an interface for future vector retrieval.

### Tool system

The basic tool direction covers files, Shell, and HTTP. Extensions have three levels: configure an Agent directory and reuse an MCP server, build a custom MCP server in any language, or implement a native Java integration.

### External service

REST APIs expose runtime capabilities to business systems written in any language.

## Architecture

![OryxOS Agent Harness OS architecture](/images/architecture.svg)

The design keeps entry points, execution, reusable capabilities, and state behind clear boundaries. Security policy, sandboxing, credential handling, and audit belong in the execution path from the beginning.

## Roadmap

### Phase 1 — single-node runtime kernel (current)

The repository currently contains a Java 21, nine-module Maven scaffold with executable Boot and CLI applications plus a minimal health endpoint. Phase 1 completes the five core capabilities, configuration-as-Agent, multiple Agents in one instance, REST integration, and MCP on one reliable node.

### Phase 2 — distributed foundation (planned)

Runtime nodes become stateless, durable state moves outward, and replicas provide larger-scale and highly available operation.

### Phase 3 — cross-node Agent collaboration (vision)

A communication foundation and A2A integration enable discovery, delegation, and reliable asynchronous collaboration across nodes—leading to the north-star task-to-team experience.

Multi-tenancy, SSO, full audit, tool policy, observability, and web management mature across all three phases.

## Design principles

- Build the foundation before optimizing one particular Agent.
- Implement the decision-making core directly; reuse mature protocol plumbing.
- Treat configuration as the Agent definition.
- Use open standards: MCP for tools, A2A for collaboration, and open Skill formats.
- Keep runtime instances stateless and durable state externalized as the system evolves.
- Make least privilege, sandboxing, credential safety, and audit architectural foundations.
- Earn distributed complexity through real single-node usage.

## Project information

- **Language:** Java 21
- **License:** Apache License 2.0
- **Organization:** [oryx-labs](https://github.com/oryx-labs)
- **Long-term goal:** grow into an Apache top-level project
