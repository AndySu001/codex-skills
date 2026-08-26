# CCSwitch Remote Control 教程

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

## 为 Remote Control 临时切换到官方

配置 Remote Control 时，先让 Codex 作为官方客户端运行：

1. 在 CC Switch 的 `Codex` 标签页选择并启用 `OpenAI Official`。
2. 如果 Codex 已打开，在右下角的账号/提供商菜单选择 `OpenAI Official`；界面也可能显示为 `Official` 或 `ChatGPT`。如果右下角没有该项，以 CC Switch 的当前提供商为准并重启 Codex。
3. 官方提供商不要启用本地路由接管；需要时运行 `codex login` 完成官方登录。
4. 保持官方提供商选中，完成 Remote Control 配置和配对。
5. 配对完成后，在 CC Switch 切回第三方提供商并重启 Codex。若还要保留官方身份、Remote Control 或官方插件，保持“切换第三方时保留官方登录”开启。

右下角显示的是当前会话/提供商提示，不是计费归属证明。切回第三方后，以 CC Switch 的当前提供商和请求统计为准。

## 切换是否显示官方登录

在 CC Switch 打开 `Settings -> General -> Codex App Enhancements`，找到 `Keep official login when switching third-party providers`：

- **开启：** Codex 继续显示官方登录，同时模型请求可以使用第三方提供商。需要 Remote Control 或官方插件时建议开启。
- **关闭：** 切换第三方提供商时可能替换当前 Codex 凭据或配置，右下角可能不再显示官方账号，Remote Control 和官方插件也可能失效。

想重新显示官方登录时：切换到 `OpenAI Official`，运行 `codex login`，重新打开上述开关，然后重启 Codex。不要手动编辑 `auth.json`。

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

## 远程显示离线时的恢复经验

实际排查中，手机显示电脑“前天离线”并不一定需要重新配对。若 Mac 上的 Codex/ChatGPT 进程仍在运行、`codex login status` 显示 `Logged in using ChatGPT`，而 CCSwitch 代理也在运行，优先按以下顺序恢复：

1. 先检查当前网络节点能否访问 `chatgpt.com`。远程控制授权同步依赖官方站点；代理节点返回 `403`、超时或 TLS 错误时，应用可能误报“请登录 ChatGPT”，手机端会显示离线，即使本地登录文件仍有效。
2. 切换到可正常访问官方站点的网络节点后，完全退出并重新打开 ChatGPT/Codex。重新登录官方账号通常会触发远程设备重新登记，很多情况下手机端下拉刷新即可恢复在线，无需重新配对。
3. 远程恢复后，再切回第三方 API。保持官方账号登录，不要关闭 CCSwitch；第三方模型请求继续经本地代理转发。

验证时要分开看三层状态：官方登录态（远程授权）、CCSwitch 进程/本地端口（模型转发）、当前提供商（实际模型流量）。其中任一层正常，都不能单独证明另外两层正常。

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
