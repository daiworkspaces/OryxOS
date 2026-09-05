<div align="center">

<img src="images/logo.svg" alt="OryxOS" width="560" />

# OryxOS

### Give intent. Get outcomes.

**The self-hosted Agent Harness OS for the enterprise.**

[Documentation](website/docs/what.md) · [中文文档](website/zh/docs/what.md) · [GitHub](https://github.com/daiworkspaces/OryxOS.git)

Java 21 · Spring Boot 3 · Apache License 2.0

</div>

---

OryxOS is building the runtime foundation for enterprise agents. Its north star is simple:

```text
Publish one task in natural language
                 ↓
          Decompose the work
                 ↓
        Assemble an Agent team
                 ↓
          Collaborate securely
                 ↓
          Deliver one outcome
```

One directory defines one Agent. One self-hosted foundation runs and manages many Agents while keeping data, credentials, execution policy, and audit evidence inside your environment.

> **Project status:** OryxOS is in Phase 1. The repository currently provides a Java 21, nine-module, buildable and runnable foundation. Provider integration, ReAct, memory, tools, MCP, persistence, scheduling, governance, and distributed collaboration are being implemented progressively. See [Project status](#project-status) before evaluating production use.

## Why an Agent Harness OS?

A model generates text. A production Agent also needs a reasoning loop, context assembly, controlled tool execution, memory, sandboxing, and audit. Together, these capabilities form the **Agent Harness**.

An enterprise needs more than a runtime for one Agent. It needs a common layer that manages many Agents: lifecycle, access channels, shared memory, policy, multi-tenancy, and eventually reliable cross-node collaboration. That is the **Agent Harness OS**.

| Layer | Scope | Responsibility |
| --- | --- | --- |
| **Model** | One LLM call | Understanding and generation |
| **Agent runtime / Harness** | One Agent | Reason → Act → Observe, context, tools, memory, sandbox, audit |
| **Agent Harness OS** | Many Agents | Lifecycle, shared services, governance, communication, scale |

OryxOS addresses four barriers that keep enterprise Agents in demos:

- **Agents require code** — move toward natural-language and Markdown definitions.
- **Cloud data exposure** — deploy privately so data stays in your domain.
- **Black-box execution** — make tools controlled, sandboxed, and auditable.
- **One Agent is easy; many are hard** — provide the operating layer for an Agent fleet.

## North-star formula

```text
Natural language (md) + Memory + Tool + MCP (Connector)
                      + Skill + Knowledge + Notify = one Agent
```

This formula describes the product direction. The capabilities are delivered in disciplined phases rather than presented as complete before they exist.

## Architecture

<p align="center">
  <img src="docs/images/architecture.svg" alt="OryxOS Agent Harness OS architecture" width="100%" />
</p>

The architecture separates entry points, the execution kernel, shared capabilities, and owned state. Models and external tools enter through explicit Provider and MCP boundaries; security and audit belong in the execution path rather than being added later.

## Five core capabilities

| Capability | Direction |
| --- | --- |
| **LLM integration** | Provider abstraction, explicit multi-provider mapping, cloud or local inference |
| **ReAct loop** | A directly implemented, inspectable Reason → Act → Observe loop |
| **Memory** | Session memory plus file-based long-term memory, with a path to vector retrieval |
| **Tool system** | Built-in file, Shell, and HTTP tools; extend through Agent directories, MCP, or native Java |
| **External service** | REST APIs so systems written in any language can integrate |

## Project status

### Phase 1 — single-node runtime kernel (current)

The current repository is an executable engineering baseline:

- Java 21 and Spring Boot 3
- Maven parent project with nine modules
- executable Spring Boot entry point
- executable Picocli entry point with version output
- minimal health endpoint and core module contracts

The Phase 1 product goal is to complete configuration-as-Agent, multiple Agents in one instance, REST integration, memory, tools, and MCP on a reliable single node.

### Phase 2 — distributed foundation (planned)

Stateless runtime nodes, externalized state, replicas, high availability, and larger-scale operation.

### Phase 3 — cross-node Agent collaboration (vision)

Agent discovery and delegation, A2A integration, and reliable asynchronous collaboration across nodes.

Multi-tenancy, SSO, full audit, tool policy, observability, and web management evolve horizontally with these phases.

## Quick start

### Prerequisites

- JDK 21
- Maven 3.8.6+

### Build all modules

```bash
git clone https://github.com/daiworkspaces/OryxOS.git
cd OryxOS
mvn clean package
```

### Run the Boot application

```bash
java -jar oryxos-boot/target/oryxos-boot-0.1.0-SNAPSHOT.jar
```

The scaffold starts on port `8080`. Its current health endpoint is:

```bash
curl http://localhost:8080/health
```

### Run the CLI

```bash
java -jar oryxos-cli/target/oryxos-cli-0.1.0-SNAPSHOT-executable.jar
```

The CLI currently prints the OryxOS version and provides standard help/version options.

## Modules

| Module | Responsibility |
| --- | --- |
| `oryxos-core` | Core contracts and future Agent lifecycle/ReAct kernel |
| `oryxos-provider` | Model Provider abstraction and adapters |
| `oryxos-memory` | Session and long-term memory contracts |
| `oryxos-tool` | Tool contracts, registry, and future MCP integration |
| `oryxos-channel-cli` | CLI interaction channel |
| `oryxos-web` | HTTP entry point and health API |
| `oryxos-storage` | Persistence boundary |
| `oryxos-cli` | Executable Picocli application |
| `oryxos-boot` | Executable Spring Boot assembly |

## Design principles

- Build the foundation before optimizing one particular Agent.
- Implement the decision-making core directly; reuse mature protocol plumbing.
- Treat configuration as the Agent definition.
- Integrate open standards: MCP for tools, A2A for collaboration, and open Skill formats.
- Keep runtime instances stateless and move durable state outward as the system evolves.
- Make security, least privilege, credential handling, and audit architectural foundations.
- Earn each distributed capability through real single-node usage.

## Documentation

- [Project positioning and roadmap](docs/oryxos.md)
- [Demand analysis](docs/DemandAnalysis.md)
- [Technical solution](docs/TechnicalSolution.md)
- [Industry research](docs/IndustryResearch.md)
- [AI programming guide](docs/AiProgrammingGuide.md)
- [Current progress](docs/Progress.md)

## Contributing

Issues, design discussion, documentation improvements, and focused pull requests are welcome. Please keep changes aligned with the design principles above and include tests or other evidence for behavioral changes.

## Security

The project is designed for private deployment, but application-level allowlists are not a substitute for operating-system or container isolation. Keep credentials in an enterprise secret system, apply least privilege, and do not report vulnerabilities through a public issue.

## License

OryxOS is released under the Apache License 2.0.

---

<div align="center">

**One directory defines one Agent. One foundation runs the fleet.**

[GitHub](https://github.com/daiworkspaces/OryxOS.git)

</div>
