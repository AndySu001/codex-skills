# Codex 实用技能

这里收录为 Codex 创建并公开分享的实用、可复用技能。

每个技能都位于独立目录中，并以 `SKILL.md` 作为入口说明。根据需要，技能还可以包含 `scripts/`、`references/`、`templates/` 和示例文件，确保使用流程清晰可靠。

## 技能列表

- [codex-official-auth-remote-control](skills/codex-official-auth-remote-control/SKILL.md)：在使用第三方 Codex 提供商时保留官方登录，并安全启用 Remote Control。

## 仓库结构

```text
codex-skills/
  skills/
    example-skill/
      SKILL.md
      scripts/
      references/
```

## 添加技能

1. 在 `skills/` 下创建技能目录，目录名使用小写字母、数字和连字符。
2. 在 `SKILL.md` 中写清用途、触发场景、操作流程和使用前提。
3. 在每次提交和推送前运行 `scripts/pre-publish-safety-audit.sh`，并完成下方人工复核。
4. 本地测试通过后再提交。

## 发布前脱敏审查

每次提交和推送前必须执行：

```sh
scripts/pre-publish-safety-audit.sh
```

脚本会阻止常见密钥、令牌、Cookie、私钥、个人联系方式、私有网络地址、聊天记录和日志文件。它不能可靠识别所有个人资料、机器标识或上下文泄露，因此提交者还必须人工确认：示例只使用占位符或虚构值；不含用户目录、私有域名或接口、真实日志、聊天记录、屏幕截图元数据，以及任何可识别个人或设备的信息。

## 本地安装

将技能目录复制或链接到由 `CODEX_HOME` 指定的 Codex 技能目录，然后新建一个任务，让 Codex 识别该技能。

```sh
cp -R skills/<skill-name> "$CODEX_HOME/skills/"
```

## 许可证

本仓库采用 MIT 许可证，详见 [LICENSE](LICENSE)。
