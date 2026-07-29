# Task 4 — Coordinate simultaneous merge with maintainers

> **Status:** DRAFT — applies once Tasks 2 & 3 PRs are open.

## Why coordination is needed

`azure-cli` must never be unresolvable. If the formula is deleted **before** the
cask merges (or vice-versa), there is a window where `brew install azure-cli`
fails. In [#257931](https://github.com/Homebrew/homebrew-cask/pull/257931),
`@bevanjkay` explicitly offered:

> "Homebrew maintainers will help to coordinate the merging of the PRs to ensure
> there isn't any downtime for the `azure-cli` token."

## Actions

1. **Cross-link the two PRs** in each description and as a comment.
2. **Explicitly request coordinated merge** referencing the #257931 promise.
3. **Do not self-merge / do not let either merge alone.**

## Cross-link comment (paste on BOTH PRs)

---

This PR is one half of the coordinated `azure-cli` formula → cask migration:

- homebrew-core (delete formula + `tap_migrations.json`): **<Task 2 PR link>**
- homebrew-cask (add `Casks/a/azure-cli.rb`): **<Task 3 PR link>**

Per prior maintainer guidance in
[homebrew-cask#257931](https://github.com/Homebrew/homebrew-cask/pull/257931),
these two PRs should be **merged together** to avoid any downtime for the
`azure-cli` token. Could a maintainer help coordinate the merge timing? Thank you!

---

## Post-merge verification

```bash
brew update
brew info azure-cli          # should show the CASK
brew install azure-cli       # resolves to cask, no --cask needed
az version
```

Also verify auto-migration for an existing formula user:

```bash
# (on a machine that had the formula installed)
brew update
brew upgrade                 # should migrate azure-cli formula -> cask
```

## Checklist

- [ ] Both PRs cross-linked (description + comment)
- [ ] Coordinated-merge request posted, citing #257931
- [ ] Neither PR merged independently
- [ ] Post-merge verification completed
- [ ] Interim tap `Azure/homebrew-azure-cli` retirement planned (see note below)

> **Note:** After migration, decide whether to retire/redirect the interim
> `Azure/homebrew-azure-cli` tap or keep it for preview builds.
