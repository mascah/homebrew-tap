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
works too.

Bump a formula to a new release with `./bump-formula.sh vX.Y.Z` (after the source
repo's tag is pushed) — it fetches the tag's source-tarball `sha256`, rewrites the
formula's `url` + `sha256`, commits, and pushes. `--dry-run` previews the change.
