# OryxOS 项目进度

> 最后更新：2026-09-04（Asia/Shanghai）
>
> 当前阶段：阶段一——单机运行时内核；Maven 工程骨架与项目展示站已初始化
>
> 状态：定位、README、架构图和中英文首页已经统一，Agent 核心能力待逐步实现

## 已完成

### 项目资料

- 已阅读并理解四份项目核心文档：
  - `IndustryResearch.md`
  - `DemandAnalysis.md`
  - `TechnicalSolution.md`
  - `AiProgrammingGuide.md`
- 已生成根目录 `CLAUDE.md`，记录架构约束、开发流程和质量门禁。
- 已按照标准开源项目结构重写 `README.md`。
- 已绘制 `docs/images/architecture.svg`，并在 README 中正式引用。
- 架构图已经过实际渲染检查，文字、模块和连线没有重叠。
- 已纳入并梳理 `docs/oryxos.md`，明确 Agent Harness OS 定位、五大核心能力与三阶段路线图。
- README、官网首页和中英文介绍文档已统一使用同一套产品边界。
- 已明确区分北极星愿景、阶段目标和当前工程骨架，移除把规划能力写成已交付能力的表述。
- 已完成中英文 VitePress 官网的特色首页设计，并通过生产构建验证。

### Maven 工程

- 已创建父工程 `pom.xml`。
- 已按照本轮明确要求创建 9 个基础模块：
  1. `oryxos-core`
  2. `oryxos-provider`
  3. `oryxos-memory`
  4. `oryxos-tool`
  5. `oryxos-channel-cli`
  6. `oryxos-web`
  7. `oryxos-storage`
  8. `oryxos-cli`
  9. `oryxos-boot`
- 已建立模块之间的基础依赖方向。
- 已使用 `com.oryxos` 作为 Java 基础包名。
- 已设置项目版本 `0.1.0-SNAPSHOT`。
- 已锁定 Java 21 编译级别和 Spring Boot 3.3.5。
- 已增加 Maven Enforcer 门禁：
  - JDK 必须为 21
  - Maven 必须为 3.8.6 或更高版本
- 已添加项目级 `.mvn/settings.xml`，避免受到本机旧 Maven HTTP 镜像和错误本地仓库路径影响。
- 已添加 `.gitignore`，忽略 `target/`、`.oryxos/`、IDE 文件、日志和 `.DS_Store`。

### 最小可运行代码

- `oryxos-core`：`OryxTool` 基础接口。
- `oryxos-provider`：`ProviderService` 基础接口。
- `oryxos-memory`：`MemoryService` 基础接口。
- `oryxos-tool`：`ToolRegistry` 基础接口。
- `oryxos-channel-cli`：`CliChannel` 骨架。
- `oryxos-storage`：Storage 模块命名空间骨架。
- `oryxos-web`：`GET /health` 健康接口。
- `oryxos-cli`：Picocli 主类 `OryxOsCli`，可执行 fat JAR 无参数启动时打印版本。
- `oryxos-boot`：Spring Boot 主类 `OryxOsApplication` 和 `application.yml`。

## 已验证

### Maven 全量构建

使用 Eclipse Temurin JDK 21.0.12.1 执行：

```bash
mvn clean package
```

结果：父工程和全部 9 个模块均为 `SUCCESS`。

### 可执行 JAR

生成产物：

```text
oryxos-boot/target/oryxos-boot-0.1.0-SNAPSHOT.jar
```

产物约 43 MB，Manifest 已确认：

```text
Main-Class: org.springframework.boot.loader.launch.JarLauncher
Start-Class: com.oryxos.OryxOsApplication
```

### 启动与健康检查

fat JAR 已在临时端口 `18080` 成功启动，实际请求：

```text
GET /health
```

返回：

```json
{"status":"UP","service":"oryxos"}
```

验证完成后测试进程已经正常停止，没有后台服务遗留。

## 当前边界

- 当前完成的是可编译、可打包、可启动的工程骨架，不是完整 Agent OS 实现。
- Provider、ReAct、Memory、内置 Tool、MCP、Session、SQLite、完整 REST API 和 Scheduler 尚未实现。
- 目前没有自动化测试；本轮完成的是编译、打包和实际启动验证。
- `oryxos-storage` 暂时关闭 DataSource/JPA 自动配置，等 SQLite Repository 落地后需要移除该临时排除配置。
- 技术方案当前第 10 章已出现新增知识库和飞书后的 11 模块版本；本轮按明确要求只建立基础 9 模块，未创建：
  - `oryxos-knowledge`
  - `oryxos-channel-feishu`
- 本机系统默认 Java 仍是 Java 8。继续开发前需要安装或显式切换到 JDK 21。

## 明天建议从这里继续

推荐按核心能力依赖顺序推进：

1. 确认 9 模块基线是否继续保持，还是同步技术方案最新的 11 模块。
2. 为现有骨架补第一批自动化测试和架构依赖测试。
3. 开始 US-1 Provider：
   - 定义 Provider 请求和响应模型。
   - 建立 provider name 到模型客户端的显式映射。
   - 先实现 Mock Provider，确保无需 API Key 也能测试。
   - 再接入第一个真实 Provider。
4. Provider 稳定后进入 US-2 ReAct Loop。

## Git 工作区状态

当前改动尚未提交。包括 README、CLAUDE 指令、文档、架构图、父 POM、9 个模块和 Maven 项目配置。

下次继续前建议先执行：

```bash
git status --short
java -version
mvn -version
```

确认使用 JDK 21 后再运行：

```bash
mvn clean package
```
