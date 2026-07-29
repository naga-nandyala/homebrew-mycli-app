# Task 5 — Update MSDocs / MSLearn install instructions

> **Status:** DRAFT — publish around the coordinated merge (Task 4), not before.

## Scope

Update the official Azure CLI macOS install documentation so it reflects the
cask-based distribution. The command **stays the same** (`brew install azure-cli`),
so most pages need only minor wording/verification changes.

## Docs to review/update

- **Install Azure CLI on macOS** (MSLearn):
  <https://learn.microsoft.com/cli/azure/install-azure-cli-macos>
- Source repo: `MicrosoftDocs/azure-docs-cli`
  - Prior related PR: [MicrosoftDocs/azure-docs-cli#5878](https://github.com/MicrosoftDocs/azure-docs-cli/pull/5878)
- Any internal ADO docs under `_scratch_cask_issue/msdocs_publishing/`

## Content changes

### Install (unchanged command, clarify behavior)

```bash
brew update && brew install azure-cli
```

Add a short note:

> On macOS, Azure CLI is distributed as a Homebrew **cask** (a signed,
> notarized build). The install command is unchanged — you do **not** need
> `--cask`. On first install you may be prompted to install the `python@3.14`
> dependency; press `y` (or set `HOMEBREW_NO_ASK=1` in automation).

### Upgrade

```bash
brew update && brew upgrade azure-cli
```

> Existing formula installs are migrated to the cask automatically on upgrade.

### Uninstall

```bash
brew uninstall azure-cli
```

### CI / automation note

```bash
HOMEBREW_NO_ASK=1 brew install azure-cli
# or
brew install azure-cli -y
```

## Checklist

- [ ] Update macOS install page wording (cask, no `--cask`, dependency prompt)
- [ ] Update upgrade/uninstall sections
- [ ] Add CI/automation note (`HOMEBREW_NO_ASK=1` / `-y`)
- [ ] Verify no page still instructs `brew install --cask azure-cli`
- [ ] Align with `_scratch_cask_issue/msdocs_publishing/` drafts
- [ ] Time the doc PR merge with the Homebrew merge (Task 4)
