# Codex 实用技能

这是一个按分支管理的开源 Codex Skill 仓库。`main` 只保存仓库导航、教程与发布门禁；每个可安装 Skill 都位于自己的分支，便于独立发布、测试和维护。

## 技能分支

| 分支 | 用途 | 教程 |
| --- | --- | --- |
| `codex-official-auth-remote-control` | 保留官方 Codex 登录，同时配置第三方模型与 Remote Control | [教程](docs/codex-official-auth-remote-control.md) |

## 安装技能

克隆所需 Skill 分支，再将该分支中的技能目录放入 `CODEX_HOME` 指定的技能目录：

```sh
git clone --branch <skill-branch> --single-branch <repository-url>
cp -R <repository>/skills/<skill-name> "$CODEX_HOME/skills/"
```

安装后新建一个 Codex 任务即可使用该 Skill。

## 添加技能

1. 从 `main` 创建一个与 Skill 同名的分支。
2. 在该分支创建 `skills/<skill-name>/SKILL.md` 和必要的资源。
3. 在每次提交和推送前完成脱敏审查。
4. 为用户可见的工作流在 `docs/` 增加或更新教程，并在此表中登记分支。

## 发布前脱敏审查

每次提交和推送前必须执行：

```sh
scripts/pre-publish-safety-audit.sh
```

脚本会阻止常见密钥、令牌、Cookie、私钥、个人联系方式、私有网络地址、聊天记录和日志文件。它不能可靠识别所有个人资料、机器标识或上下文泄露，因此提交者还必须人工确认：示例只使用占位符或虚构值；不含用户目录、私有域名或接口、真实日志、聊天记录、屏幕截图元数据，以及任何可识别个人或设备的信息。

## 许可证

本仓库采用 MIT 许可证，详见 [LICENSE](LICENSE)。
