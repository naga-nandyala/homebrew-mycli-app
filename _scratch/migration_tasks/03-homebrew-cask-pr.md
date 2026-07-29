# Task 3 — homebrew-cask PR (add azure-cli.rb cask)

> **Status:** DRAFT — do NOT open this PR until Task 1 (discussion) is acknowledged.

## Repo & branch

- Repo: `Homebrew/homebrew-cask`
- Suggested branch: `add-azure-cli-cask`
- New file: `Casks/a/azure-cli.rb` (token **`azure-cli`**, not `azure-cli-preview`)
- Edit: `tap_migrations.json` — **delete** the existing `"azure-cli": "homebrew/core"` line (see below)

## ⚠️ Critical: remove the existing tap_migrations shadow

homebrew-cask's `tap_migrations.json` **already contains** a historical entry:

```jsonc
  "azure-cli": "homebrew/core",
```

This records that the `azure-cli` cask token was previously migrated **to** the
core formula. While present, brew redirects the `azure-cli` token straight to
homebrew-core and the new cask is **unreachable** (verified locally — the token
resolved to `homebrew-core/Casks/azure-cli.rb` and failed with "does not
exist"). This PR **must delete that line** so the new cask resolves.

```jsonc
-  "azure-cli": "homebrew/core",
```

## Cask content (proposed)

Based on the validated cask from the interim tap `Azure/homebrew-azure-cli`,
retokenised to `azure-cli`. Optionally wrap the dependency in `on_macos do`
to mirror the official `gcloud-cli` style (macOS-only tarball).

```ruby
cask "azure-cli" do
  arch arm: "arm64", intel: "x86_64"

  version "2.88.0"
  sha256 arm:   "f97865d9300522481e39cd016005fc2fe0a35d8a8900e9ddc77c6f75984ffea9",
         intel: "b50714213c46f354ac176f92fc5d6162e87525b3de6c893b00bbfa2eadb5f6b2"

  url "https://github.com/Azure/azure-cli/releases/download/azure-cli-#{version}/azure-cli-#{version}-macos-#{arch}.tar.gz",
      verified: "github.com/Azure/azure-cli/"
  name "Azure CLI"
  desc "Microsoft Azure CLI 2.0"
  homepage "https://docs.microsoft.com/cli/azure/overview"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on formula: "python@3.14"

  binary "bin/az"
  bash_completion "completions/bash/az"
  fish_completion "completions/fish/az.fish"
  zsh_completion "completions/zsh/_az"

  zap trash: "~/.azure"
end
```

> **Version note:** bump `version` + `sha256` to the release being shipped at
> actual migration time. `2.88.0` is the current placeholder.

## Validation commands

```bash
cd homebrew-cask
git checkout -b add-azure-cli-cask
# add Casks/a/azure-cli.rb and delete the tap_migrations.json azure-cli->core line

export HOMEBREW_NO_INSTALL_FROM_API=1
brew style --fix homebrew/cask/azure-cli
brew audit --cask --new homebrew/cask/azure-cli
brew install --cask homebrew/cask/azure-cli
az version
brew uninstall --cask homebrew/cask/azure-cli
```

> Use the **fully-qualified** `homebrew/cask/azure-cli` token during local
> testing. A bare `azure-cli` is ambiguous while the core formula still exists
> (and would collide with any custom tap that also defines an `azure-cli` cask).

## Local validation results (2026-07-28, Apple Silicon)

Ran end-to-end against the real installed tap (then reverted to pristine):

| Step | Result |
|------|--------|
| `brew style --fix` | ✅ No offenses |
| `brew audit --cask --new` | ⚠️ Only the **expected** `cask token conflicts with an existing homebrew/core formula` error — download + arm sha256 verified fine |
| `brew install --cask` | ✅ Installed; pulled `python@3.14` + `sqlite`; linked `az` + bash/fish/zsh completions; showed the `[y/n]` dependency prompt |
| `az version` | ✅ `azure-cli 2.88.0` |
| `brew uninstall --cask` | ✅ Clean; autoremoved `python@3.14` |

The audit's core-formula conflict is **expected and only resolves once Task 2
lands** (formula deleted + `tap_migrations.json` reverse entry added). It is the
concrete proof the two PRs must merge together.

## PR description (draft)

---

**Title:** Add `azure-cli` cask

Adds Azure CLI as a signed/notarized cask, migrating from the homebrew-core
formula. Upcoming broker-based auth depends on the closed-source
`pymsalruntime` / `msal[broker]`, which cannot be built from source in
homebrew-core.

Paired with the homebrew-core PR that deletes the formula and adds the
`tap_migrations.json` entry: **<link to Task 2 PR>**

Context / prior maintainer guidance:
<https://github.com/Homebrew/homebrew-cask/pull/257931>

Please coordinate merge timing with the paired homebrew-core PR to avoid any
downtime for the `azure-cli` token.

---

## Checklist

- [ ] Token is `azure-cli` (matches the formula name being migrated)
- [ ] **Deleted** the `"azure-cli": "homebrew/core"` line from `tap_migrations.json`
- [ ] `version` + `sha256` updated to the migration-time release
- [ ] `brew style` passes
- [ ] `brew audit --cask --new` passes (only the core-formula conflict remains, cleared by Task 2)
- [ ] (Optional) `on_macos do ... end` wrapping to match `gcloud-cli` style
- [ ] Cross-link to the homebrew-core PR (Task 2)
- [ ] Do NOT merge independently — must be coordinated with Task 2

## Commit message

First line ≤ 50 chars, per homebrew-cask convention:

```
azure-cli 2.88.0 (new cask)
```
