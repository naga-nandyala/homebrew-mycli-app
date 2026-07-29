# Task 2 — homebrew-core PR (delete formula + tap_migrations.json)

> **Status:** DRAFT — do NOT open this PR until Task 1 (discussion) is acknowledged.

## Repo & branch

- Repo: `Homebrew/homebrew-core`
- Suggested branch: `azure-cli-migrate-to-cask`

## Changes

### 1. Delete the formula

```
Formula/a/azure-cli.rb   ← delete this file
```

### 2. Add a migration entry to `tap_migrations.json`

Insert alphabetically — **after `avidemux`, before `chromedriver`**:

```jsonc
  "avidemux": "homebrew/cask",
  "azure-cli": "homebrew/cask",          // ← add this line
  "chromedriver": "homebrew/cask",
```

This is what makes `brew install azure-cli` resolve to the cask **and**
auto-migrates users who already have the formula installed.

> **Coordinated-conflict note:** while this formula still exists, the paired
> homebrew-cask PR's `brew audit --cask --new` fails with
> `cask token conflicts with an existing homebrew/core formula` (verified
> locally 2026-07-28). Deleting `Formula/a/azure-cli.rb` here is what clears
> that conflict. Conversely, the cask side must delete its stale
> `"azure-cli": "homebrew/core"` entry in homebrew-cask's `tap_migrations.json`
> (which otherwise shadows the new cask). Both directions must land together —
> neither PR is safe to merge alone.

## Suggested commands (run in the cloned repo)

```bash
cd homebrew-core
git checkout -b azure-cli-migrate-to-cask
git rm Formula/a/azure-cli.rb
# edit tap_migrations.json to add the "azure-cli" line (see above)

# validate JSON + formula audit tooling
brew style
git diff --staged
```

## PR description (draft)

---

**Title:** `azure-cli`: migrate to homebrew-cask

Azure CLI is moving to a signed/notarized cask because upcoming broker-based
authentication depends on the closed-source `pymsalruntime` / `msal[broker]`,
which cannot be built from source in homebrew-core.

- Deletes `Formula/a/azure-cli.rb`
- Adds `tap_migrations.json` entry: `"azure-cli": "homebrew/cask"`

Paired with the homebrew-cask PR that adds `Casks/a/azure-cli.rb`:
**<link to Task 3 PR>**

Context / prior maintainer guidance:
<https://github.com/Homebrew/homebrew-cask/pull/257931>
(`@bevanjkay` confirmed this migration approach and offered to coordinate the
simultaneous merge.)

Please coordinate merge timing with the paired homebrew-cask PR to avoid any
downtime for the `azure-cli` token.

---

## Checklist

- [ ] Branch created from latest `main`
- [ ] `Formula/a/azure-cli.rb` removed via `git rm`
- [ ] `tap_migrations.json` entry added in correct alphabetical position
- [ ] Cross-link to the homebrew-cask PR (Task 3)
- [ ] Reference #257931 in the description
- [ ] Do NOT merge independently — must be coordinated with Task 3
