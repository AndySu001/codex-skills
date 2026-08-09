# Codex 实用技能

这里收录为 Codex 创建并公开分享的实用、可复用技能。

每个技能都位于独立目录中，并以 `SKILL.md` 作为入口说明。根据需要，技能还可以包含 `scripts/`、`references/`、`templates/` 和示例文件，确保使用流程清晰可靠。

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
3. 本地测试通过后再提交。
4. 发布前确认不包含 API 密钥、令牌、个人资料或与本机绑定的路径。

## 本地安装

将技能目录复制或链接到 Codex 的技能目录，然后新建一个任务，让 Codex 识别该技能。

```sh
cp -R skills/<skill-name> ~/.codex/skills/
```

## 许可证

本仓库采用 MIT 许可证，详见 [LICENSE](LICENSE)。
