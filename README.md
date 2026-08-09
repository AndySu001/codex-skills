# Codex 实用技能

这是一个按分支管理的开源 Codex Skill 仓库。`main` 只保存仓库导航、教程与发布门禁；每个可安装 Skill 都位于自己的分支，便于独立发布、测试和维护。

## 技能分支

| 分支 | 用途 | 教程 |
| --- | --- | --- |
| `ccswitch-remote-control` | 保留官方 Codex 登录，同时配置第三方模型与 Remote Control | [教程](docs/ccswitch-remote-control.md) |

## 安装技能

克隆所需 Skill 分支，再将该分支中的技能目录放入 `CODEX_HOME` 指定的技能目录：

```sh
git clone --branch <skill-branch> --single-branch <repository-url>
cp -R <repository>/skills/<skill-name> "$CODEX_HOME/skills/"
```

安装后新建一个 Codex 任务即可使用该 Skill。

## 许可证

本仓库采用 MIT 许可证，详见 [LICENSE](LICENSE)。
