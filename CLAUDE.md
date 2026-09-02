# OryxOS 开发指南

本文件是 Claude Code 在 OryxOS 仓库中工作的项目级指令。开始设计或修改代码前，先阅读本文件；涉及具体能力时，再阅读 `docs/` 中对应的源文档。

## 1. 项目使命

OryxOS 是一个 Java 原生、可私有部署、可审计的企业 Agent 统一底座。它部署在企业自己的服务器或 K8s 中，为多个业务 Agent 统一提供模型接入、ReAct 执行、记忆、工具、会话、渠道和 Web API。

OryxOS 服务的是“企业需要完全掌控的 Agent 底座”这一长期需求，而不是追逐 Agent OS 概念本身。核心价值是：

- 数据和能力留在企业内部，不绑定云厂商。
- 多个 Agent 共享统一基础设施。
- 业务方通过配置 Agent 和编写 Tool 完成业务接入，不重复开发 Agent 后端。
- 从第一版开始保留可观测、可审计和安全扩展的基础。

OryxOS 做 Agent 运行时和管理底座，不做可视化工作流编排平台。

## 2. 权威文档和冲突处理

实现前按以下顺序理解文档：

1. `docs/TechnicalSolution.md`：最新架构、模块边界和技术决策，发生冲突时优先。
2. `docs/DemandAnalysis.md`：产品范围、功能需求、非功能需求和验收标准。
3. `docs/IndustryResearch.md`：项目定位、用户价值和产品边界。
4. `docs/AiProgrammingGuide.md`：Spec-Kit 使用方法和开发拆解方式。

已知版本差异：

- 内置 Tool 数量以技术方案中的 9 个为准，不采用需求文档早期的 5 个版本。
- 端到端验收以技术方案最新的三个 Demo 为准：每日天气、每日科技日报、每日 GitHub 日报。五个 User Story 仍是主体能力的开发拆分，不等于必须维持五个最终 Demo。
- Maven 当前规划为 9 个基础模块，但模块结构不是不可修改的教条。新增能力确有独立边界时可以新增或调整模块；必须先说明依赖方向、职责边界及为什么现有模块无法承载。

不得凭记忆覆盖文档中的明确决定。发现文档互相矛盾、设计无法实现或需要改变项目边界时，先报告证据和影响，再修改规范或代码。

## 3. 产品模型

### 底座与业务 Agent

Provider、ReAct、Memory、Tool、Sandbox、Session、Channel、Scheduler 和 Web Service 都是共享底座，不是具体业务 Agent。

一个业务 Agent 由一个目录定义：

```text
.oryxos/agents/<name>/
├── AGENT.md       # frontmatter = 运行配置；正文 = Agent 指令
├── skills/        # 指向公共 Skill 的受控相对软连接
├── scripts/       # 可选的 Agent 专属脚本
└── REFERENCE.md   # 可选参考资料
```

`.oryxos/agents/` 是 Agent 定义的唯一真相源。`AgentLoader` 从 `AGENT.md` frontmatter 派生 `Profile`；不得维护另一份需要人工同步的 Profile YAML。

公共 Skill 存放在 `.oryxos/skills/<name>/`。Agent 的 `skills/` 软连接集合是 Skill 绑定的唯一真相源，不在 frontmatter 中重复声明 `skills:`。

### Skill 与 Tool

- Skill 是可读取的知识、步骤和资源，不是可执行 Tool，不进入 `ToolRegistry`。
- `AGENT.md` 正文由 `ContextLoader` 注入 system prompt。
- Prompt 只注入已绑定 Skill 的名称、描述和本地路径；Skill 正文及资源由 Agent 使用 `read_file` 等底座工具按需加载。
- Agent 目录本身不是 Tool。目录中的脚本通过受控 Tool 或管理员明确允许的解释器执行。

## 4. 核心能力和依赖顺序

主体实现按五个 User Story 推进：

```text
US-1 Provider -> US-2 ReAct -> US-3 Memory --\
                              US-4 Tool   ----> US-5 Web Service
```

US-3 与 US-4 在 US-2 完成后可并行。五项能力是：

1. Provider：统一连接 DeepSeek、通义、Kimi、OpenAI 兼容服务及本地模型服务。
2. ReAct：自主完成 LLM 思考、Tool 调用、结果回填和继续推理。
3. Memory：会话记忆、长期记忆，以及为后续情景记忆预留的统一门面。
4. Tool：内置工具、MCP Tool 和 Java Spring Bean Tool。
5. Web Service：通过 REST API 将底座能力暴露给企业系统。

CLI、REST API 和定时任务是三种触发源，最终都应调用同一个 `AgentService.process` 主链路，不得复制 ReAct 业务逻辑。

## 5. 技术基线

- JDK 21。
- Spring Boot 3.x。
- Maven 多模块单体，最终由 `oryxos-boot` 生成可执行 fat JAR。
- Spring AI Alibaba 负责模型协议适配和 Tool schema 生成。
- Spring MVC + Java 21 virtual threads，核心阶段使用同步执行模型。
- SQLite + Spring Data JPA 保存 Session 和审计数据。
- `MEMORY.md` 是核心阶段默认长期记忆存储。
- Picocli 提供 CLI。
- SLF4J + Logback 输出结构化日志。

默认模块职责：

| 模块 | 职责 |
| --- | --- |
| `oryxos-core` | 核心模型、ReAct、Prompt、Agent 加载与服务抽象 |
| `oryxos-provider` | LLM Provider 适配和显式映射 |
| `oryxos-memory` | Memory 门面与长期记忆实现 |
| `oryxos-tool` | 内置 Tool、MCP Client、ToolRegistry |
| `oryxos-channel-cli` | CLI 消息渠道 |
| `oryxos-web` | REST API 和异常处理 |
| `oryxos-storage` | SQLite Repository 和审计持久化 |
| `oryxos-cli` | Picocli 命令入口和配置加载 |
| `oryxos-boot` | Spring Boot 主类、自动配置和打包入口 |

模块依赖应朝核心抽象方向收敛，避免循环依赖。边缘适配器依赖 core，core 不依赖具体 Provider、数据库、Channel 或 Web 实现。

## 6. 不可违反的架构约束

### ReAct 和 Spring AI

- OryxOS 必须自行实现 `ReActLoop`。
- 必须禁用 Spring AI 自动 Tool 执行，否则 Tool 可能被执行两次。
- Tool 的选择结果可以来自模型，但调度、参数校验、执行、审计和结果回填必须由 `ReActLoop + ToolExecutor` 控制。
- 默认最大迭代次数为 10，并允许 Agent Profile 覆盖。
- 核心阶段 Tool 调用顺序执行，不实现并行 Tool 调用。

### Provider

- `ProviderService` 必须维护 provider name 到 `ChatModel` 的显式映射。
- 不得通过扫描同类型 `ChatModel` Bean 猜测 Provider。
- 核心阶段 Provider 失败直接返回清晰错误；fallback、hedge racing 和完整路由属于扩展阶段。

### Memory

- 上层只依赖 `MemoryService`/`LongTermMemoryStore` 抽象，不直接依赖 Markdown、SQLite 或 Mem0 实现。
- 会话历史由 Session 管理，长期记忆与 Session 不能合并成同一个概念。
- 记忆读取默认不缓存，保存后下一轮应立即可见。
- 核心阶段不自动从对话中提炼长期记忆；由 Agent 显式调用 `save_memory`。
- 向量检索、自动总结压缩和情景记忆不得偷偷扩大进核心范围。

### Tool 和 Sandbox

- 所有 Tool 执行统一经过 `ToolExecutor` 和 `Sandbox.enforce(...)`。
- 文件路径必须归一化后检查是否仍位于允许根目录，防止目录穿越和软连接逃逸。
- Shell 使用 argv 直传，不拼接 shell 字符串；只允许明确配置的命令或解释器。
- HTTP 和通知出站必须经过域名或端点白名单。
- 白名单只是应用层策略，不得描述成真正隔离。不可信代码和多租户执行需要未来的容器或 MicroVM Runner。
- Tool 调用无论成功或失败都应产生审计记录，敏感参数必须脱敏。

### 持久化和审计

- `sessions`、`tool_invocations` 和 `llm_calls` 在核心阶段就写入 SQLite。
- 每次 LLM 调用记录 Provider、模型、token 使用量、耗时和结果状态。
- 每次 Tool 调用记录 Tool、参数摘要、耗时、结果状态和错误信息。
- 不得以普通日志替代审计表。查询 API 和报表可以后续实现，但写入不能推迟。
- 密钥只从环境变量或独立本地配置加载，不得写入源码、Agent 文件、日志或提交到 Git。

## 7. 核心阶段与扩展阶段边界

核心阶段目标是可演示的最小完整 Agent OS 运行时内核，而不是治理完备的企业平台。

核心阶段包括：

- 多 Agent 目录加载和运行。
- Provider、ReAct、两层 Memory、Tool/MCP、CLI、REST API、定时触发。
- SQLite Session 与审计写入。
- 应用层 Sandbox 白名单。
- 配置加载、结构化日志、健康检查和基础项目主页。

除非任务明确要求，以下内容留到扩展阶段：

- 多租户、RBAC、SSO 和完整 Tool Policy。
- 容器或 MicroVM 沙箱。
- IM Channel 全量接入。
- Provider fallback、并行或流式 Tool 执行。
- SSE 流式响应。
- 向量 Memory、情景记忆和自动记忆提炼。
- 集群高可用、分布式锁和状态外置。
- 完整审计查询、SIEM 和合规报表。

## 8. 实现工作流

### 修改前

1. 阅读任务涉及的需求、技术方案章节和现有代码。
2. 用搜索确认真实的接口、调用方、测试和模块依赖，不凭文件名猜测。
3. 明确该工作属于核心阶段还是扩展阶段。
4. 若使用 Spec-Kit，依次维护 constitution、spec、plan、tasks，并在实现前确认它们没有漂移。

### 实现中

- 优先完成可独立验证的最小闭环。
- 保持公共接口小而清晰，基础设施细节放在适配器中。
- 不进行与当前任务无关的大规模重构。
- 不覆盖用户已有修改，不提交密钥、`.oryxos/` 运行数据、日志或构建产物。
- 新行为必须有自动化测试；修复缺陷时先增加可复现该缺陷的测试。

### 完成后

至少执行与修改范围对应的检查：

```bash
mvn test
mvn clean package
```

若修改单一模块，可先运行模块测试，再运行全仓测试：

```bash
mvn -pl <module> -am test
```

交付说明必须包含：

- 改了什么以及为什么。
- 影响了哪些模块和公共接口。
- 执行了哪些测试，结果如何。
- 需要重点人工 Review 的风险点。
- 尚未完成或明确留到扩展阶段的内容。

不得声称未实际执行的测试已经通过。

## 9. 测试与验收门禁

每项能力至少覆盖成功路径、边界条件和失败路径。

- Provider：显式路由、未知 Provider、上游错误、超时和审计写入。
- ReAct：无 Tool、单 Tool、多轮 Tool、Tool 失败、达到最大迭代次数，且 Tool 不得重复执行。
- Memory：跨 Session 保存与读取、保存后立即可见、存储失败和路径安全。
- Tool：schema、参数校验、白名单允许与拒绝、异常审计、敏感信息脱敏。
- Web：状态码、统一响应结构、参数错误、资源不存在和异常映射。
- Storage：重启恢复、事务边界、并发追加和审计完整性。
- Scheduler：按时触发、不重叠执行、失败记录和重启恢复。

最终端到端验收覆盖：

1. 每日天气：定时触发，调用天气 Tool，生成建议并通知。
2. 每日科技日报：只注入 Skill 元数据，按需读取 Skill 正文，结合 Memory 生成并推送日报。
3. 每日 GitHub 日报：通过受控 Tool 运行确定性数据脚本，脚本输出进入上下文，脚本源码不进入 Prompt。

三种入口——CLI、REST API、定时任务——必须复用同一 Agent 主链路，并能从 Session 和审计数据中追踪完整执行过程。

## 10. 编码和文档约定

- 代码、类名、配置键和 API 字段使用英文；解释性文档优先使用中文。
- 使用清晰的领域名称，避免 `Manager`、`Util`、`Common` 等无明确职责的抽象。
- 公共 API 的错误必须稳定、清晰、可测试，禁止直接向客户端暴露堆栈或密钥。
- 文档中的接口、模块和命令必须与代码同步；改变架构决策时同时更新技术方案。
- README 面向首次接触项目的用户；技术细节和决策依据放在 `docs/`。
- 不为了满足“9 个模块”而制造空模块，也不为了省事把不同边界的职责全部塞进 core。

## 11. 决策原则

出现多种实现方案时，按以下顺序取舍：

1. 是否保持企业私有、可控、可审计的定位。
2. 是否守住底座与业务 Agent、Skill 与 Tool 的边界。
3. 是否让核心执行链路简单、确定、可测试。
4. 是否避免供应商锁定并保持替换能力。
5. 是否符合当前阶段范围，避免过早建设扩展功能。
6. 是否能通过自动化测试和审计数据证明行为正确。

任何会绕过 `AgentService`、`ToolExecutor`、Sandbox 或审计写入的“快捷实现”，都应视为架构缺陷。
