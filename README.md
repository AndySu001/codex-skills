# CCSwitch Remote Control

此分支包含 `ccswitch-remote-control` Skill。它用于在保留官方 Codex 登录的同时，通过 CC Switch 配置第三方模型，并安全启用 Remote Control。

## 安装

将技能目录复制或链接到由 `CODEX_HOME` 指定的 Codex 技能目录：

```sh
cp -R skills/ccswitch-remote-control "$CODEX_HOME/skills/"
```

安装后新建一个 Codex 任务，并使用 `$ccswitch-remote-control` 调用该 Skill。

## 许可证

本仓库采用 MIT 许可证，详见 [LICENSE](LICENSE)。
