# Codex Skills

This repository contains practical, reusable skills created for Codex and shared publicly.

Each skill lives in its own directory and starts with a `SKILL.md` file. A skill may include `scripts/`, `references/`, `templates/`, and examples when they are needed to make the workflow reliable.

## Repository layout

```text
codex-skills/
  skills/
    example-skill/
      SKILL.md
      scripts/
      references/
```

## Add a skill

1. Create a new directory under `skills/` using lowercase letters, numbers, and hyphens.
2. Write the workflow in `SKILL.md`, including when it should be used and any requirements.
3. Test it locally before committing.
4. Ensure the contribution contains no API keys, tokens, personal data, or machine-specific paths.

## Install a skill locally

Copy or link the skill directory into your Codex skills directory, then start a new task so Codex can discover it.

```sh
cp -R skills/<skill-name> ~/.codex/skills/
```

## License

MIT. See [LICENSE](LICENSE).
