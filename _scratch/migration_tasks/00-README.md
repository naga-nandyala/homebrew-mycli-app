# Migration Tasks — azure-cli: homebrew-core (formula) → homebrew-cask (cask)

This folder contains one draft `.md` per task for migrating `azure-cli` from a
Homebrew **formula** (`homebrew-core`) to a **cask** (`homebrew-cask`).

> ⚠️ **Status: DRAFTS ONLY. No PRs or discussions have been raised yet.**

## Task index & sequencing

| # | Task | File | Depends on |
|---|------|------|-----------|
| 1 | Raise Homebrew discussion thread (intent + cite #257931) | [01-homebrew-discussion-thread.md](01-homebrew-discussion-thread.md) | — |
| 2 | homebrew-core PR: delete formula + `tap_migrations.json` | [02-homebrew-core-pr.md](02-homebrew-core-pr.md) | maintainer nod on #1 |
| 3 | homebrew-cask PR: add `Casks/a/azure-cli.rb` | [03-homebrew-cask-pr.md](03-homebrew-cask-pr.md) | maintainer nod on #1 |
| 4 | Coordinate simultaneous merge with maintainers | [04-coordination-with-maintainers.md](04-coordination-with-maintainers.md) | #2 + #3 open |
| 5 | Update MSDocs / MSLearn install instructions | [05-msdocs-mslearn-update.md](05-msdocs-mslearn-update.md) | merge scheduled |
| 6 | Post GitHub issue announcement (no user action needed) | [06-github-issue-announcement.md](06-github-issue-announcement.md) | after merge |

## Key facts established (evidence-based)

- `brew install azure-cli` will resolve directly to the cask post-migration — **no `--cask` needed** (proven with `copilot-cli` and `gcloud-cli`).
- The formula→cask collision rule requires the formula be **removed** and a
  `tap_migrations.json` entry added — **maintainer-confirmed** in
  [PR #257931](https://github.com/Homebrew/homebrew-cask/pull/257931).
- The cask's `depends_on formula: "python@3.14"` triggers a `[y/n]` prompt
  interactively; this is **normal** (official `gcloud-cli` behaves identically)
  and is **auto-skipped in CI** (no TTY) or with `HOMEBREW_NO_ASK=1` / `-y`.- homebrew-cask's `tap_migrations.json` **already maps** `\"azure-cli\": \"homebrew/core\"`
  (a historical reverse migration). Task 3 **must delete** this line or the new
  cask stays shadowed/unreachable — verified locally 2026-07-28.
- End-to-end local test passed (2026-07-28, Apple Silicon): style ✅, install ✅
  (`az version` → 2.88.0), uninstall ✅. New-cask audit's **only** failure is the
  expected core-formula token conflict, which clears when Task 2 removes the
  formula — proving the two PRs must merge **together**.
## Reference

- Prior maintainer guidance: <https://github.com/Homebrew/homebrew-cask/pull/257931>
- Custom tap (interim): <https://github.com/Azure/homebrew-azure-cli>
