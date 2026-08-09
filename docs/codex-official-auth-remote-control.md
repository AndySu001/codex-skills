# 官方登录、第三方模型与 Remote Control

本教程说明如何让 Codex 保留官方 ChatGPT/Codex 登录，同时通过 CC Switch 选择第三方模型提供商，并按需开启 Remote Control。

## 先理解边界

这套配置将“身份”和“模型流量”分开处理：

- 官方登录用于让 Codex 保持官方账号身份，并支持依赖该登录态的功能。
- CC Switch 当前选中的提供商决定模型请求的实际去向和计费方。
- Remote Control 需要在已授权设备间完成配对；配对码是短期敏感信息，绝不能记录到聊天、日志或仓库。

CC Switch 的提供商管理属于桌面应用内部能力，并不是供外部脚本调用的公开管理接口。不要尝试从其配置数据库、浏览器数据或登录文件中提取任何认证信息。

## 准备条件

开始前确认以下命令可用：

```sh
codex --version
codex login status
codex remote-control --help
```

还需要：

- CC Switch 3.16.1 或更新版本。
- 可完成官方登录的 ChatGPT/Codex 账号。
- 仅在使用第三方模型时才需要第三方提供商账号和 API Key。

## 配置步骤

1. 打开 CC Switch 的 `Codex` 标签页，将当前提供商切换为 `OpenAI Official`。
2. 运行 `codex login`，在浏览器中完成官方登录。只用 `codex login status` 确认成功，不要查看或复制登录文件内容。
3. 在 CC Switch 打开 `Settings -> General -> Codex App Enhancements`，启用 `Keep official login when switching third-party providers`。
4. 回到 `Codex` 标签页，添加或选择第三方提供商。只在 CC Switch 的表单中输入 API Key。
5. 按提供商协议决定连接方式：
   - 提供原生 Responses API 时，直接连接。
   - 只提供 Chat Completions API 时，在 `Settings -> Routing -> Local Routing` 启动本地路由，并启用 Codex takeover。
6. 每次切换提供商或模型目录后，重启 Codex。

启用官方登录保留后，Codex 继续显示官方账号是预期行为。不要根据账号显示判断模型流量；应查看 CC Switch 的当前提供商和已脱敏的请求统计。

## 开启 Remote Control

确认官方登录已完成、Codex 已重启后，启动 Remote Control：

```sh
codex remote-control start --json
```

只有准备好在受信任设备上立即完成配对时，才生成配对码：

```sh
codex remote-control pair
```

将配对码仅输入受信任客户端。不要粘贴到对话、终端录屏、工单、日志或仓库。结束后停止服务：

```sh
codex remote-control stop
```

## 验证清单

1. `codex login status` 显示官方登录正常。
2. CC Switch 显示预期的 Codex 提供商；需要路由时，Codex takeover 已启用。
3. 重启 Codex 后发起无敏感信息的测试请求。
4. 在 CC Switch 的脱敏统计中确认请求落到预期提供商。
5. 在已授权设备上配对并确认 Remote Control 可以连接。

本机代理的健康状态只能说明代理服务正在运行，不能证明提供商切换或 Remote Control 已经成功。

## 常见问题

**切换第三方后为什么仍显示官方账号？**

这是官方登录保留的预期结果。账号显示来自官方登录态，模型流量由 CC Switch 的当前提供商决定。

**第三方请求失败怎么办？**

先确认提供商协议。对于只支持 Chat Completions 的提供商，开启本地路由与 Codex takeover，并重启 Codex。

**官方功能不可用怎么办？**

切回 `OpenAI Official`，重新完成官方登录，再确认“切换第三方时保留官方登录”仍已开启，最后切回所需提供商。

**Remote Control 无法连接怎么办？**

确认官方登录状态和 `codex remote-control` 命令可用，然后生成新的配对码并只在受信任客户端中使用。不要公开包含配对码或认证字段的错误输出。
