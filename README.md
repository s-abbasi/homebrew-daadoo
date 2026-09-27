# homebrew-daadoo

Homebrew tap for the Daadoo desktop agent.

```bash
brew install --cask s-abbasi/daadoo/daadoo
brew upgrade --cask daadoo   # later updates
```

Daadoo drives your installed Google Chrome, so Chrome must be installed. The app is ad-hoc signed but not
notarized by Apple. The cask removes the download quarantine flag so it opens without a Gatekeeper prompt.

## Releases

Each release's DMGs are attached to a GitHub Release here, `v<version>`, and `Casks/daadoo.rb` points at them.
Both are produced by `.github/workflows/release.yml`, which builds a `local-agent-v<version>` tag of the private
`s-abbasi/daadoo-app` repo on a macOS runner. See `apps/local-agent/RELEASING.md` there for the full process.
