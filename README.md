# CCSwitch Remote Control

此分支包含 `ccswitch-remote-control` Skill。先在官方桌面 App 登录 ChatGPT，再通过 CC Switch 配置第三方模型，分别验证官方身份、模型流量和手机远程连接。支持 macOS 与 Windows 的桌面流程，CLI 实验独立列入附录。

参阅[完整教程与设备验证范围](skills/ccswitch-remote-control/references/desktop-workflow.md)。Windows 天选 Air 已由用户确认手机连接并查看聊天记录；其他操作不据此视为通过。MacBook Air M1 的范围按已有记录标注。

## 安装

将以下地址和请求直接交给 Codex：

```text
从 https://github.com/AndySu001/codex-skills/tree/ccswitch-remote-control 安装并启用 ccswitch-remote-control Skill。
```

Codex 会安装该 Skill；安装后即可在任务中使用 `$ccswitch-remote-control`。

## 许可证

本仓库采用 MIT 许可证，详见 [LICENSE](LICENSE)。
