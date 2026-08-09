---
name: codex-official-auth-remote-control
description: Preserve an official ChatGPT/Codex login while using CC Switch to configure a third-party Codex provider, then enable and verify Codex Remote Control. Use when a user needs third-party model routing without losing official Codex identity, Remote Control, or official plugin access.
---

# Codex Official Auth and Remote Control

Configure CC Switch so Codex keeps its official ChatGPT login while model traffic uses a selected third-party provider. Then enable Codex Remote Control without exposing credentials.

## Safety Boundary

- Never read, print, commit, copy, or ask the user to paste Codex's `auth.json`, CC Switch's database, cookies, access tokens, API keys, pairing codes, or full configuration files.
- Never put a real credential in a command, a TOML example, a log, or a Git commit.
- Treat a CC Switch provider-management command as an internal desktop-app API, not a public HTTP API. Its local proxy health endpoint only reports proxy health; it cannot configure providers.
- Do not edit `auth.json` by hand. Let Codex and CC Switch manage it.
- Explain that CC Switch local routing may send prompts and tool data to the selected third-party provider. Confirm that this is acceptable before enabling it.

## Prerequisites

Check these non-sensitive facts first:

```sh
codex --version
codex login status
codex remote-control --help
```

Require all of the following:

- CC Switch 3.16.1 or later, with its Codex integration available.
- A working Codex CLI or desktop app.
- A ChatGPT/Codex account that can complete official login.
- A third-party provider and API key only when model traffic will be routed away from OpenAI.

Do not start a pairing session merely to inspect availability: pairing produces a short-lived secret code. Ask the user before starting or pairing a remote-control daemon if it is not already their intended action.

## Configure Official Login Preservation

1. In CC Switch, open the `Codex` tab and select `OpenAI Official` as the current provider.
2. Run `codex login` and let the user complete the official login in the browser. Verify only with `codex login status`.
3. In CC Switch, open `Settings -> General -> Codex App Enhancements` and enable `Keep official login when switching third-party providers`.
4. Add or select the desired third-party Codex provider in the `Codex` tab. Enter its API key only in CC Switch's provider form; never handle it in chat or a shell command.
5. Choose routing based on the provider protocol:
   - Use its native Responses API directly when supported.
   - For a Chat Completions-only provider, open `Settings -> Routing -> Local Routing`, start routing, and enable Codex takeover.
6. Restart Codex after a provider or model-catalog change.

The expected separation is: official login material remains managed by Codex, while provider settings are managed by CC Switch. Codex continuing to display the official account is expected; use CC Switch's active-provider view and non-sensitive request statistics to determine where model traffic goes.

## Enable Remote Control

After the official login is preserved and Codex has restarted, use the installed Codex CLI:

```sh
codex remote-control start --json
```

Only when the user is ready to pair an authorized remote client, run:

```sh
codex remote-control pair
```

Keep the returned pairing code private and enter it only into the authorized client. Do not paste the code into chat, issue trackers, shell history captures, or repository files. Stop the daemon when it is no longer needed:

```sh
codex remote-control stop
```

## Verify Without Secrets

Use this order:

1. Confirm `codex login status` reports the official login.
2. Confirm CC Switch shows the intended Codex provider and, when applicable, that Codex local routing is enabled.
3. Restart Codex and make a harmless test request.
4. Confirm the selected provider's non-sensitive request count or CC Switch's redacted request view changes as expected.
5. Start Remote Control and pair only with an authorized device. Confirm the remote client can connect and that no pairing code was recorded.

Do not treat a successful local-proxy health check as evidence that provider switching or Remote Control works. It proves only that CC Switch's local proxy is alive.

## Troubleshoot

- If Codex shows the official account after switching providers, treat that as expected when login preservation is enabled.
- If third-party traffic fails, verify the provider protocol and enable local routing only when conversion is required; then restart Codex.
- If official features disappear, select `OpenAI Official`, complete official login again, re-enable login preservation, and switch back to the third-party provider.
- If Remote Control fails, check `codex remote-control --help`, confirm official login status, and use a fresh pairing code. Do not disclose the error output if it contains a code or credential.
- If the user only wants the official provider, keep `OpenAI Official` selected and do not enable third-party routing or takeover.
