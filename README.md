<div align="center">

<img src="images/logo.svg" alt="OryxOS" width="560" />

# OryxOS

### Give intent. Get outcomes.

**The self-hosted Agent Harness OS for the enterprise.**

[Documentation](website/docs/what.md) · [中文文档](website/zh/docs/what.md) · [GitHub](https://github.com/daiworkspaces/OryxOS.git)

[English](#oryxos) · [中文](#中文说明)

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

---

## 中文说明

### 给出意图，交付结果

**面向企业的自托管 Agent Harness OS。**

OryxOS 正在构建企业级 Agent 的运行时底座。它的北极星目标很简单：

```text
用自然语言发布一个任务
          ↓
       拆解工作
          ↓
    组建 Agent 团队
          ↓
       安全协作
          ↓
    交付一个完整结果
```

一个目录定义一个 Agent。一个自托管底座运行和管理多个 Agent，同时将数据、凭证、执行策略与审计证据保留在你的环境中。

> **项目状态：** OryxOS 目前处于第一阶段。仓库已经提供基于 Java 21、包含九个模块、能够构建和运行的工程基础。Provider 集成、ReAct、记忆、工具、MCP、持久化、调度、治理与分布式协作正在逐步实现。评估生产使用前，请先阅读[项目状态](#项目状态)。

## 为什么需要 Agent Harness OS？

模型能够生成文本，而生产级 Agent 还需要推理循环、上下文组装、受控工具执行、记忆、沙箱和审计。这些能力共同组成 **Agent Harness**。

企业需要的不只是单个 Agent 的运行时，还需要管理多个 Agent 的公共层，包括生命周期、接入渠道、共享记忆、策略、多租户，以及最终可靠的跨节点协作。这就是 **Agent Harness OS**。

| 层级 | 范围 | 职责 |
| --- | --- | --- |
| **模型** | 一次 LLM 调用 | 理解与生成 |
| **Agent Runtime / Harness** | 一个 Agent | 推理 → 行动 → 观察、上下文、工具、记忆、沙箱、审计 |
| **Agent Harness OS** | 多个 Agent | 生命周期、共享服务、治理、通信与扩展 |

OryxOS 旨在解决企业 Agent 长期停留在演示阶段的四个障碍：

- **开发 Agent 依赖编码**——逐步转向使用自然语言和 Markdown 定义 Agent。
- **云端数据暴露**——支持私有部署，让数据留在自己的环境中。
- **执行过程是黑盒**——让工具调用可控制、可隔离、可审计。
- **单个 Agent 容易，多个 Agent 很难**——为 Agent 集群提供统一的操作底座。

## 北极星公式

```text
自然语言（md）+ 记忆 + 工具 + MCP（连接器）
                 + 技能 + 知识 + 通知 = 一个 Agent
```

这条公式描述产品方向。各项能力会按照清晰的阶段逐步交付，不会在尚未完成时将其描述为现成功能。

## 架构

<p align="center">
  <img src="docs/images/architecture.svg" alt="OryxOS Agent Harness OS 架构" width="100%" />
</p>

架构将接入层、执行内核、共享能力和自有状态清晰分离。模型和外部工具分别通过明确的 Provider 与 MCP 边界接入；安全与审计属于执行链路的一部分，而不是后期附加功能。

## 五项核心能力

| 能力 | 方向 |
| --- | --- |
| **LLM 集成** | Provider 抽象、明确的多 Provider 映射，以及云端或本地推理服务 |
| **ReAct 循环** | 直接实现、可检查的“推理 → 行动 → 观察”循环 |
| **记忆** | 会话记忆与基于文件的长期记忆，并保留升级向量检索的路径 |
| **工具系统** | 内置文件、Shell 和 HTTP 工具；可通过 Agent 目录、MCP 或原生 Java 扩展 |
| **对外服务** | 提供 REST API，让任何语言编写的系统都能接入 |

## 项目状态

### 第一阶段——单节点运行时内核（当前）

当前仓库已经具备可执行的工程基础：

- Java 21 和 Spring Boot 3
- 包含九个模块的 Maven 父工程
- 可执行的 Spring Boot 入口
- 可输出版本信息的 Picocli 命令行入口
- 最小健康检查接口与核心模块契约

第一阶段的产品目标是在一个可靠的单节点上完成“配置即 Agent”、单实例多 Agent、REST 集成、记忆、工具与 MCP。

### 第二阶段——分布式底座（规划）

实现无状态运行节点、外置状态、多副本、高可用和更大规模的运行能力。

### 第三阶段——跨节点 Agent 协作（愿景）

实现 Agent 发现与委托、A2A 集成，以及跨节点可靠的异步协作。

多租户、SSO、完整审计、工具策略、可观测性和 Web 管理能力将伴随三个阶段横向演进。

## 快速开始

### 环境要求

- JDK 21
- Maven 3.8.6+

### 构建全部模块

```bash
git clone https://github.com/daiworkspaces/OryxOS.git
cd OryxOS
mvn clean package
```

### 运行 Boot 应用

```bash
java -jar oryxos-boot/target/oryxos-boot-0.1.0-SNAPSHOT.jar
```

基础应用默认监听 `8080` 端口，当前健康检查接口为：

```bash
curl http://localhost:8080/health
```

### 运行 CLI

```bash
java -jar oryxos-cli/target/oryxos-cli-0.1.0-SNAPSHOT-executable.jar
```

CLI 当前会打印 OryxOS 版本，并提供标准的帮助和版本选项。

## 模块

| 模块 | 职责 |
| --- | --- |
| `oryxos-core` | 核心契约，以及未来的 Agent 生命周期和 ReAct 内核 |
| `oryxos-provider` | 模型 Provider 抽象与适配器 |
| `oryxos-memory` | 会话记忆和长期记忆契约 |
| `oryxos-tool` | 工具契约、注册中心和未来的 MCP 集成 |
| `oryxos-channel-cli` | CLI 交互渠道 |
| `oryxos-web` | HTTP 入口与健康检查 API |
| `oryxos-storage` | 持久化边界 |
| `oryxos-cli` | 可执行的 Picocli 应用 |
| `oryxos-boot` | 可执行的 Spring Boot 装配模块 |

## 设计原则

- 先构建通用底座，再优化某个特定 Agent。
- 直接实现决策核心，复用成熟的协议管道。
- 将配置视为 Agent 定义。
- 对接开放标准：工具使用 MCP，协作使用 A2A，技能采用开放格式。
- 随系统演进保持运行实例无状态，并将持久状态外置。
- 将安全、最小权限、凭证管理和审计作为架构基础。
- 用真实的单节点使用需求推动每一项分布式能力。

## 文档

- [项目定位与路线图](docs/oryxos.md)
- [需求分析](docs/DemandAnalysis.md)
- [技术方案](docs/TechnicalSolution.md)
- [行业调研](docs/IndustryResearch.md)
- [AI 编程指南](docs/AiProgrammingGuide.md)
- [当前进度](docs/Progress.md)

## 参与贡献

欢迎提交 Issue、参与设计讨论、改进文档或发起聚焦明确的 Pull Request。请确保修改符合上述设计原则，并为行为变化提供测试或其他验证依据。

## 安全说明

本项目面向私有化部署，但应用层白名单不能替代操作系统或容器隔离。请使用企业级凭证系统保存密钥、遵循最小权限原则，并且不要通过公开 Issue 报告安全漏洞。

## 许可证

OryxOS 使用 Apache License 2.0。

---

<div align="center">

**一个目录定义一个 Agent，一个底座运行整个 Agent 集群。**

[GitHub](https://github.com/daiworkspaces/OryxOS.git)

</div>
