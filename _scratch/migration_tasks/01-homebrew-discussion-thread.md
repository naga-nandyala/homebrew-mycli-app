# Task 1 — Raise a Homebrew discussion thread (intent to migrate)

> **Status:** DRAFT — not yet posted.

## Goal

Notify Homebrew maintainers of our intent to migrate `azure-cli` from
`homebrew-core` (formula) to `homebrew-cask` (cask), reference the prior
conversation, and confirm the coordination plan **before** raising the two PRs.

## Where to post

- **Preferred:** A new thread in [Homebrew/discussions](https://github.com/orgs/Homebrew/discussions)
  (or `Homebrew/homebrew-cask` Discussions), tagging the maintainers who advised
  us previously: `@bevanjkay`, `@daeho-ro`, `@krehel`.
- Alternatively, re-open the conversation by commenting on
  [PR #257931](https://github.com/Homebrew/homebrew-cask/pull/257931) and linking
  the new discussion.

## Draft post

---

**Title:** Intent to migrate `azure-cli` from homebrew-core (formula) → homebrew-cask (cask)

Hi Homebrew maintainers,

Following our earlier conversation in
[homebrew-cask#257931](https://github.com/Homebrew/homebrew-cask/pull/257931),
we are now ready to migrate **Azure CLI** from the `homebrew-core` formula to a
`homebrew-cask` cask.

**Why the cask is now required**

Azure CLI has introduced broker-based authentication, which depends on
`pymsalruntime` / `msal[broker]` — a component that is **not open-source** and
therefore cannot be built from source in `homebrew-core`. The cask distributes a
pre-built tarball that is **Microsoft-signed and Apple-notarized**, with the
Azure CLI Python site-packages bundled. It reuses Homebrew's `python@3.14`
(same dependency the existing formula already declares), analogous to the
official `gcloud-cli` cask.

**Interim state**

Per your prior guidance, we have been distributing the cask from our own tap:
<https://github.com/Azure/homebrew-azure-cli>.

**Migration plan (as you previously confirmed)**

We intend to raise two coordinated PRs:

1. **homebrew-core** — delete `Formula/a/azure-cli.rb` and add a
   `tap_migrations.json` entry: `"azure-cli": "homebrew/cask"`.
2. **homebrew-cask** — add `Casks/a/azure-cli.rb` (token `azure-cli`).

In [#257931](https://github.com/Homebrew/homebrew-cask/pull/257931) `@bevanjkay`
confirmed this is the correct approach and that maintainers would help coordinate
the merge timing to avoid any downtime for the `azure-cli` token.

**Ask**

- Is there anything you'd like us to adjust before we open the two PRs?
- Once open, could you help coordinate the simultaneous merge as previously
  offered?

Thank you!

---

## Checklist

- [ ] Confirm the correct venue (Discussions vs. issue vs. comment on #257931)
- [ ] Tag the previously-involved maintainers
- [ ] Link the interim tap `Azure/homebrew-azure-cli`
- [ ] Await maintainer acknowledgement **before** opening PRs (Tasks 2 & 3)
