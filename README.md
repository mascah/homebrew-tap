# homebrew-tap

Homebrew tap for [mascah](https://github.com/mascah)'s tools.

## Usage

```bash
brew install mascah/tap/nerve
```

or

```bash
brew tap mascah/tap
brew install nerve
```

## Formulae

| Formula | Description |
|---|---|
| [nerve](https://github.com/mascah/nerve) | Per-worktree port/env isolation so AI agents can run your whole stack |

Formulae under `Formula/` are **build-from-source** — `brew install` compiles the
tool on your machine, so there's no code-signing, no Gatekeeper prompt, and Linux
works too. Each formula is maintained by hand: bump its `url` tag + `sha256` per
release.
