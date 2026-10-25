# CC Switch 与桌面 App 远程连接

更新：2026-10-25（Asia/Shanghai）。适用于 macOS 与 Windows。

先在官方桌面 App 中完成 ChatGPT 官方账号登录，再用 CC Switch 选择第三方 API。CC Switch 内的 CLI 授权连接不能替代桌面 App 登录。官方身份、第三方流量、手机远程连接必须分别验证。

## 桌面 App 主流程

1. 打开官方桌面 App，在应用内完成 ChatGPT 登录，确认账号及工作区。如果现有第三方配置阻碍登录，先按下节停用 Codex 接管并临时切回官方，再回到桌面 App 登录。
2. 在 CC Switch 的“设置 > 通用 > Codex 应用增强”开启“非接管切换时保留官方登录”。旧版标签可能不同，应核对安装版本。
3. 在 Codex 提供商面板选择第三方服务。只在提供商设置界面输入密钥。模型请求将交由所选服务处理。
4. 按实际协议配置：原生 Responses 服务可直连；只支持 Chat Completions 且标有“需要路由”的配置，需启动本地路由并启用 Codex 接管。全局 `enableLocalProxy=true` 不代表 Codex takeover 已生效。
5. 完全退出并重新打开桌面 App，重新加载提供商与模型目录。
6. 分别验证官方身份、第三方流量及远程连接。配置文件或提供商卡片只证明配置意图，不能单独证明实际请求和计费去向。

## 桌面端手机配对

官方文档支持 macOS 与 Windows。电脑和手机使用同一账号及工作区；组织可能需要管理员开放，功能入口也受逐步发布影响。

桌面 App 入口：`Settings > Connections > Control this Mac or PC > Set up / Add`。按提示验证，再用手机扫描界面二维码并完成连接。二维码只在自己的设备间使用，不记录到聊天或仓库。官方手机设置流程从桌面 App 发起，CLI 或 IDE 扩展不能替代。

若首次配对需要临时切官方：先在 CC Switch 停用 Codex 接管并确认配置已恢复，再选择 `OpenAI Official`，重启桌面 App 并确认官方登录。配对后切回第三方、按协议恢复路由、重启并重新验收。不要在第三方接管尚未解除时直接切官方，也不要假定每个版本右下角都有同名菜单。

Mac 保持在线且避免睡眠；Windows 使用 Computer Use 时保持会话解锁并预留前台桌面。聊天记录可读不代表 Computer Use 已验证。

## 验证与设备记录

| 项目 | 验收证据 | 不足以证明成功 |
| --- | --- | --- |
| 官方身份 | 桌面 App 账号/工作区或必要的脱敏认证摘要 | CLI 登录状态、默认登录文件存在性 |
| 第三方流量 | 测试请求对应的服务商用量/计费；有路由时核对 CC Switch 请求统计 | 选中提供商、配置存在、代理健康 |
| 手机远程 | 手机实际连接并完成所声称的操作 | 配置已保存、CLI 帮助存在 |
| 持久性 | 重启后重新验证各项 | 重启前的一次成功 |

| 设备 | 已确认范围 | 待验证范围 |
| --- | --- | --- |
| MacBook Air M1（M1 Air） | 用户补充设备型号；仓库历史有 Mac 离线恢复排查经验 | 历史记录不足以核对完整验收，本次未重测；不宣布手机任务、审批、计费或完整远程流程通过 |
| 华硕天选 Air（Windows） | 2026-10-25 用户确认手机已连接、能查看聊天记录；此前确认桌面官方认证和第三方配置字段 | 手机发起任务、审批、Computer Use、实际第三方计费、重启后的长期登录保留 |

Windows 成功依据为用户最新实测反馈，并非本次文档维护重新操作设备的结果。Mac 范围依据仓库历史提交 `7c8f941`；其中网络节点、重启等为排查经验，不作为端到端成功或因果关系的证据。

## Windows 当天复盘

- 桌面包 `OpenAI.Codex`，版本 `26.1021.3705.0`；CC Switch 可执行文件版本 `4.0.20`。
- 桌面认证摘要有 `authenticatedAccountPresent=true`、`authMethod=chatgpt`、`result=succeeded`；同时 CLI 曾报告未登录，默认 `auth.json` 不存在。两种状态可能不一致，不能据此认定桌面掉登录或凭据没有持久化。
- `preserveCodexOfficialAuthOnSwitch=true` 已设置；全局代理开关开启，但当时未核实 Codex 接管状态。
- 按用户明确要求，将当前 `[model_providers.custom]` 的 `requires_openai_auth` 改为 `true`。先在本机创建带时间戳的配置备份，再回读确认；未更换 endpoint 或密钥，未读写登录文件。
- 回读确认 `model_provider=custom`、`wire_api=responses`，仍指向第三方 API；provider-scoped `experimental_bearer_token` 仅检查存在性。公开示例使用 `https://provider.example/v1`，无需公布实际服务地址。
- 配置确认不等于流量验证：未检查本会话请求统计或供应商计费。CC Switch 再次切换可能重写该字段。
- 后续手机访问成功不能单独归因于 `requires_openai_auth=true`；没有隔离变量测试，它不是所有版本、提供商的官方推荐，也不是远程修复充分条件。
- 早期失败时出现登录后 Statsig bootstrap 超时和 durable WebSocket 建连前关闭，其与远程启用失败的因果关系未确认。
- 网络只读检查中，系统本地代理开启；直连官方站点约 15 秒超时，显式代理访问根地址返回 403。curl 403 可能来自站点防护，不能独立证明浏览器或 App 不可用。换可访问官方站点的节点并重启是排查建议，不是成功原因的证明。
- 最终用户确认手机已能查看聊天记录，因此远程状态更新为“已连接并可查看记录”，其余能力继续分项验证。

## CC Switch 版本边界

上游指南适用 v3.20.1 及以上，界面文字以 v3.20.4 为准：第三方密钥写入 provider 配置；非接管切换时，保留开关决定官方登录是否保留；接管期间保留官方登录。不要沿用旧教程中“仅控制账号显示”或“关闭后用第三方密钥覆盖登录文件”的解释。

本次核对 v4.0.20 标签源码，提交为 `85ad4969b3399500baaea9d46b1e08f87aba80e1`：
`codex_direct.rs` 的 `preserve_login` 读取保留开关，临时 detach 存在保留登录的例外；`live/project/codex.rs` 的 `requires_openai_auth` 按凭据类别和登录状态生成。独立 Bearer / EnvKey 与其他凭据类别分开处理，源码还阻止某些缺少独立密钥、可能回退使用官方凭据访问第三方的配置。因此不能批量强制该字段为 true。

上游的登录文件实现说明不能替代桌面 App 认证检查。不要读取、复制或迁移登录文件、CC Switch 数据库、Cookie、令牌或配对码。

## 离线排查

先检查桌面账号、工作区、连接界面、主机在线状态和网络。需要日志时只提取必要的脱敏状态摘要。CLI 状态只描述对应 CLI 环境；不要因默认文件缺失覆盖桌面认证。

Mac 历史经验包括检查节点、完全退出重开 App、必要时在桌面端重登并刷新手机列表。将其作为候选步骤；恢复与否必须实测，不应自动重新配对，也不保证重登一定重新登记主机。第三方直连不依赖本地代理，路由接管则需要对应服务运行。

## 附录：独立 CLI 实验

这些只用于用户明确要求的 CLI 排查，不是桌面手机连接的前置步骤：

```sh
codex --version
codex login status
codex remote-control --help
```

当天 PATH 是桌面附带的 `codex-cli 0.164.0-alpha.11.1`。帮助包含 remote-control，但实验运行 `codex remote-control start --json` 报缺少完整本地包，需要 packaged CLI 或 standalone installer。该错误仅说明这份附带 CLI 不能按此方式启动，不能推断 Windows 不支持远程。

不要为桌面需求自动转用 npx、独立 CLI 安装或 CLI 配对。CLI 授权不能替代桌面官方登录；独立 CLI 实验应遵循其版本文档，不输出或记录配对码。

## 来源

- [OpenAI 远程连接文档](https://learn.chatgpt.com/docs/remote-connections)，2026-10-25 核对。
- [CC Switch 登录保留指南](https://github.com/farion1231/cc-switch/blob/main/docs/guides/codex-official-auth-preservation-guide-zh.md)。其中 CLI 建议与本教程桌面主流程明确区分。
- [v4.0.20 登录切换源码](https://github.com/farion1231/cc-switch/blob/v4.0.20/src-tauri/src/services/provider/codex_direct.rs)及[认证配置源码](https://github.com/farion1231/cc-switch/blob/v4.0.20/src-tauri/src/live/project/codex.rs)。
- 本仓库历史 Mac 经验与用户 2026-10-25 Windows 复盘、手机连接成功反馈；仅按上述证据范围记载。
