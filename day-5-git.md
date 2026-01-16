# Day 5 – Git Mastery for CI/CD Engineers

## Objective

Build a **clear, calm mental model of Git** so Git stops being a blocker for CI/CD pipelines.

The goal of Day 5 was to:

* Stop guessing Git commands
* Understand *why* Git shows errors
* Handle rebase, merge, and divergence confidently
* Use Git safely in CI/CD workflows

---

## Git Mental Model (Critical)

Git operates with multiple states that must stay in sync:

```
Working Directory → Staging Area → Local Repository → Remote Repository
```

Most Git problems occur when these states **drift apart**.

Key commands to inspect state:

```bash
git status
git branch
git branch -vv
git log --oneline --graph --decorate --all
```

---

## Branch States

A branch can be:

* Ahead of remote
* Behind remote
* Diverged from remote

**Diverged does not mean broken** — it only means histories differ.

---

## Merge vs Rebase

### Merge

* Preserves full history
* Creates a merge commit
* Safe for shared branches

```bash
git merge main
```

### Rebase

* Rewrites commit history
* Produces linear history
* Preferred for feature branches

```bash
git rebase main
```

### Golden Rule

> **Never rebase a branch that others are already using.**

---

## Handling Rebase Conflicts Safely

```bash
git status
# fix conflicts
git add <file>
git rebase --continue
```

Recovery commands:

```bash
git rebase --abort
```

Rebase is safe as long as abort is understood.

---

## Git in CI/CD Context

CI pipelines run based on:

* Branch name
* Commit hash

If local and remote branches differ, CI may:

* Run unexpected code
* Fail inconsistently

---

## Safe CI-Friendly Git Workflow

Before pushing:

```bash
git fetch origin
git status
git log --oneline --decorate --all
```

Recommended strategy:

* Feature branches → **rebase** before pushing
* Main branch → **merge**, never rebase

---

## Handling Divergent Branches

Correct approach:

```bash
git fetch origin
git rebase origin/your-branch
```

Avoid blind usage of:

```bash
git pull
```

`git pull` performs an implicit merge and can pollute history.

---

## Force Push (Controlled Usage)

After rebasing a feature branch:

```bash
git push --force-with-lease
```

Why `--force-with-lease`:

* Protects others' work
* Prevents accidental overwrites

Never use plain `--force`.

---

## Recovery & Confidence Commands

Undo last commit (keep changes):

```bash
git reset --soft HEAD~1
```

Undo last commit (discard changes):

```bash
git reset --hard HEAD~1
```

Fix detached HEAD:

```bash
git checkout -b recovery-branch
```

Recover lost commits:

```bash
git reflog
git checkout <commit-hash>
```

Clean working directory:

```bash
git clean -fd
```

---

## Key Learnings

* Git errors are state mismatches, not randomness
* Rebase is safe when understood
* CI/CD failures often originate from Git misuse
* `reflog` makes Git forgiving, not dangerous

---

## One-Line Explanation (Interview Ready)

> Git is a distributed version control system where most issues arise from misunderstanding branch state and history manipulation.

---

## Final Outcome

After Day 5:

* Git errors feel diagnosable, not stressful
* Rebase vs merge decisions are intentional
* CI/CD workflows are calmer and predictable

---

### Final Advice

Never guess with Git. Inspect state first, then act.
