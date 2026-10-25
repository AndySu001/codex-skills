---
name: ccswitch-remote-control
description: Configure CC Switch with a desktop App ChatGPT login and a third-party model provider, and verify mobile remote access on macOS or Windows. Use for desktop official-login preservation, provider routing, and remote-connection troubleshooting.
---

# CC Switch Desktop Remote Control

Keep the user's desktop App workflow primary. Read [desktop workflow and evidence](references/desktop-workflow.md) for setup, platform observations, version-specific behavior, and the separate CLI appendix.

## Workflow

1. Complete official ChatGPT login in the official desktop App and confirm account/workspace. A CLI authorization connection in CC Switch is not a substitute.
2. If an existing route prevents official login, first disable Codex takeover and confirm restoration, then select OpenAI Official and restart the desktop App. Do not route official login through a third-party takeover.
3. Enable CC Switch Settings > General > Codex App Enhancements > 非接管切换时保留官方登录. Check the installed version's labels.
4. Select the third-party provider. Use native Responses directly where supported; enable local routing and Codex takeover for a configuration requiring Chat Completions conversion. A global proxy setting does not prove Codex takeover.
5. Restart the desktop App. Validate official identity, actual provider traffic, and remote access separately.
6. Use desktop Settings > Connections > Control this Mac or PC > Set up / Add and the phone QR flow. Account/workspace must match; organization permissions and rollout may affect availability.

Keep credential entry in the appropriate UI. Never read or copy authentication files, CC Switch databases, tokens, cookies, pairing codes, or complete secret-bearing configuration. Inspect only necessary non-secret configuration fields or credential presence. Do not expose pairing output in chat or repository files.

## Evidence Rules

- Desktop identity comes from the desktop account/workspace UI or a minimal authentication status summary. CLI Not logged in or a missing default auth.json cannot establish desktop logout or failed persistence.
- Provider selection and configuration show intent. Verify actual traffic using a harmless request and correlated provider usage/billing; use CC Switch statistics when routing applies.
- Local proxy health proves only that the proxy is running.
- Verify remote operations individually: reading chats, starting tasks, approvals, and Computer Use are separate outcomes. Verify persistence after a restart separately.
- Treat requires_openai_auth=true as version- and credential-dependent. Do not force it universally or treat it as sufficient proof of a remote fix. CC Switch can overwrite it on another switch.
- For v3.20.1+ distinguish third-party keys in provider configuration from official-login preservation. The non-takeover preservation toggle does not merely hide/show the account; takeover has separate preservation behavior. Consult the pinned v4.0.20 source links in the reference for exceptions.

## Platform Evidence, 2026-10-25

- MacBook Air M1: device model confirmed; prior repository notes describe offline troubleshooting. Those notes do not establish a complete remote acceptance test; do not invent a Mac success scope.
- Windows ASUS Tianxuan Air: the user confirmed a phone connection and viewing chat history. Desktop official authentication and third-party configuration were also confirmed earlier. Phone task creation, approvals, Computer Use, third-party billing, and durable login after restart remain unverified.
- The Windows user requested setting the custom provider's requires_openai_auth to true after a local backup. Later phone success has no isolated causal attribution to this change.
- Statsig bootstrap timeout, durable WebSocket failures, and curl 403/timeout were observations during troubleshooting, not confirmed causes. Curl 403 alone cannot establish App/browser failure.

## CLI Boundary

Do not introduce codex login, npx, independent CLI installation, or CLI pairing as desktop setup prerequisites. CLI status pertains to its own environment. Only use the reference's CLI appendix when the user explicitly requests a CLI investigation.

On the recorded Windows desktop-bundled codex-cli 0.164.0-alpha.11.1, help existed but remote-control start --json failed because the complete local CLI package was absent. This is not evidence that Windows remote access is unsupported.

When reconnecting, inspect the desktop connection UI and host/network state first. Do not automatically reset credentials or re-pair; verify any recovery instead of assuming that restarting or logging in fixes it.
