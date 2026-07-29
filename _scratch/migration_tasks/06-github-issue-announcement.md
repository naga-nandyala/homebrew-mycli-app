# Task 6 — Post GitHub issue announcement (no user action needed)

> **Status:** DRAFT — post to `Azure/azure-cli` **after** the coordinated merge (Task 4).

## Purpose

Reassure customers that the formula → cask migration requires **no change** on
their side — `brew install azure-cli` continues to work — and give them a place
to report issues.

## Ready-to-post content

The full announcement body is maintained here:

- [../azure-cli-issue-announcement.md](../azure-cli-issue-announcement.md)

It already covers: TL;DR (same command), what/why is changing, no action needed,
auto-migration of existing installs, known issues + diagnostics, and how to get
help.

## Recommended additions before posting (optional)

- **Timing line:** state when the change goes live (e.g. "rolling out with
  Azure CLI x.y.z" or "as of <date>").
- **CI/automation note:** first install prompts for `python@3.14`; press `y`, or
  use `HOMEBREW_NO_ASK=1` / `-y` in scripts (parity with official `gcloud-cli`).
- **Scope line:** clarify this affects **macOS Homebrew** only (Linux/other
  install paths unchanged).

## Where to post

- New issue (pinned) in `Azure/azure-cli`:
  <https://github.com/Azure/azure-cli/issues>
- Optionally cross-post/link from release notes.

## Checklist

- [ ] Finalize timing line
- [ ] Add CI/automation + macOS-scope notes (optional)
- [ ] Post as a **pinned** issue in `Azure/azure-cli`
- [ ] Link the pinned issue from release notes / docs
- [ ] Post only **after** the Homebrew PRs are merged (Task 4)
