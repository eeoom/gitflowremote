# 🚀 git-flow-sync

A CLI tool that extends [Git Flow](https://nvie.com/posts/a-successful-git-branching-model/) with automatic **remote synchronization**, **branch cleanup**, and enhanced **workflow automation** for teams.

---

## 🧩 Features

- Start or finish `feature`, `release`, `hotfix`, and `support` branches
- Automatically push updates and tags to remote
- Delete remote branches after finishing a flow
- Auto-detect and clean up local branches tracking deleted remotes
- Auto-stash uncommitted changes for safety
- Optional CI/CD trigger via `--ci-url`
- Dry run and verbose output modes

---

## 📦 Installation

1. Save the script file:
   - [Download git-flow-sync-extended.sh](./git-flow-sync-extended.sh)
2. Make it executable:
   ```bash
   chmod +x git-flow-sync-extended.sh
   ```
3. (Optional) Move it into your `$PATH`:
   ```bash
   sudo mv git-flow-sync-extended.sh /usr/local/bin/git-flow-sync
   ```

---

## ⚙️ Requirements

- `git`
- `git-flow` (initialized in your repo)
- Unix-compatible shell (Bash)

---

## 🔧 Usage

```bash
git-flow-sync [--dry-run] [--verbose] [--force] [--ci-url <url>] <start|finish|cleanup> [feature|release|hotfix|support] <branch-name>
```

---

## ✅ Commands

| Command   | Description                                                                 |
|-----------|-----------------------------------------------------------------------------|
| `start`   | Start a new Git Flow branch and push to remote                              |
| `finish`  | Finish a Git Flow branch, push target branch and tags, delete remote branch |
| `cleanup` | Remove local branches that track deleted remote branches (`[gone]`)         |

---

## ⚙️ Options

| Option           | Description                                                             |
|------------------|-------------------------------------------------------------------------|
| `--dry-run`      | Show actions without executing                                           |
| `--verbose`      | Show detailed output of every command                                   |
| `--force`        | Auto-delete stale local branches without confirmation                   |
| `--ci-url <url>` | Send a POST request to the given URL after finishing a branch           |

---

## 🔁 Examples

### Start a feature and push

```bash
git-flow-sync start feature navbar-update
```

### Finish a release and trigger CI

```bash
git-flow-sync finish release v1.4.0 --ci-url https://ci.example.com/deploy
```

### Safely cleanup tracking-deleted local branches

```bash
git-flow-sync cleanup --verbose
```

### Force delete all stale local branches (no prompt)

```bash
git-flow-sync cleanup --force
```

---

## 🔐 Safety

- Uncommitted changes are auto-stashed before `finish`
- Never deletes local branches without prompt (unless `--force` is set)
- Supports `--dry-run` for all destructive operations

---

## 📄 License

MIT – Free to use and adapt.

---

## ✨ Created by

Built to make **Git Flow actually flow** — cleanly, safely, and with fewer manual steps.
