# 📢 Heads-up: Azure CLI Homebrew install is moving from a **formula** to a **cask** (macOS)

We're changing how Azure CLI is distributed through Homebrew on **macOS**. This
post explains what is changing, what you need to do (spoiler: **nothing changes in
the command you run**), and where to get help if you hit any issues.

> **TL;DR** — Keep using the exact same command you use today:
>
> ```bash
> brew update && brew install azure-cli
> ```
>
> No need to add `--cask`. Existing installs are migrated automatically.

---

## What is changing?

Today, `azure-cli` is distributed as a **homebrew-core formula** (built from
source). We are migrating it to a **homebrew-cask** that ships a **pre-built,
Microsoft-signed and Apple-notarized** tarball from the official
[Azure/azure-cli GitHub releases](https://github.com/Azure/azure-cli/releases).

| | Before (formula) | After (cask) |
|---|---|---|
| Source | `homebrew/core` | `homebrew/cask` |
| Build | Compiled from source on your machine | Pre-built, signed & notarized bundle |
| Command | `brew install azure-cli` | `brew install azure-cli` (unchanged) |

## Why are we doing this?

Azure CLI is introducing **broker-based authentication**, which depends on a
component (`pymsalruntime` / `msal[broker]`) that is **not open-source** and
therefore cannot be built from source. Homebrew-core only accepts dependencies
that build from source, so the full Azure CLI (with broker auth) is distributed
as a **cask** with all dependencies bundled.

---

## ✅ What do I need to do?

**Nothing different.** The install and upgrade commands stay the same:

```bash
# Install (or upgrade)
brew update && brew install azure-cli

# Upgrade an existing install
brew update && brew upgrade azure-cli
```

- **You do NOT need `brew install --cask azure-cli`.** After migration,
  `azure-cli` exists only in `homebrew-cask`, so plain `brew install azure-cli`
  resolves to it automatically.
- **Already have Azure CLI installed via the formula?** Homebrew will
  **automatically migrate** you to the cask on your next
  `brew update && brew upgrade`. No manual uninstall/reinstall is required.

> ℹ️ `brew update` is important — it refreshes local metadata so Homebrew knows
> the old formula has moved to the cask.

---

## 🔎 What to expect after upgrading

- `az version` should report the same (or newer) version you had before.
- `which az` will point to the Homebrew-managed `az` binary.
- Your existing config in `~/.azure` is preserved.

---

## 🐞 Known issues & how to report them

If you run into any of the following, please let us know **in this issue thread**:

- `brew install azure-cli` still installing/keeping the old formula version.
- `az` command not found after upgrade, or a stale version reported by
  `az version`.
- Errors mentioning `--cask`, "both a cask and formula", or
  "No available formula/cask".
- Authentication (broker/login) errors after upgrading.
- Shell completion (bash/zsh/fish) no longer working.

### Please include this diagnostic output

When reporting a problem, paste the output of:

```bash
brew update
brew config
brew info azure-cli
az version
which -a az
```

<details>
<summary>Optional: fully reset and reinstall (only if asked)</summary>

```bash
brew uninstall azure-cli
brew update
brew install azure-cli
az version
```

</details>

---

## 💬 Getting help

- **Comment on this issue** with the diagnostic output above and a short
  description of what you ran and what you expected.
- For general Azure CLI bugs unrelated to installation, please open a new issue
  at <https://github.com/Azure/azure-cli/issues>.

Thanks for helping us make the Azure CLI experience on macOS smoother! 🙏
