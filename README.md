# 🚀 git-flow-sync

A CLI tool that extends [Git Flow](https://nvie.com/posts/a-successful-git-branching-model/) with automatic **remote synchronization**, **branch cleanup**, and enhanced **developer ergonomics**.

**Features:**

- Start or finish `feature`, `release`, or `hotfix` branches
- Automatically push updates to remote
- Automatically delete remote branches after finishing
- Cleanup local branches that track deleted remotes
- Dry run and verbose output modes
- Confirmation prompt to prevent accidental deletion

---

## 📦 Installation

1. Clone or download `git-flow-sync.sh`
2. Make it executable:
   ```bash
   chmod +x git-flow-sync.sh
   ```
3. (Optional) Move it into your `$PATH`:
   ```bash
   mv git-flow-sync.sh ~/bin/git-flow-sync
   ```

---

## ⚙️ Requirements

- `git`
- `git-flow` (initialized in your repo)
- Unix-compatible shell (Bash)

---

## 🔧 Usage

```bash
git-flow-sync.sh [--dry-run] [--verbose] <start|finish|cleanup> [feature|release|hotfix] <branch-name>
```

### ✅ Commands

| Command        | Description                                                                 |
|----------------|-----------------------------------------------------------------------------|
| `start`        | Start a new Git Flow branch and push to remote                              |
| `finish`       | Finish a Git Flow branch, push target branch (e.g., `develop`), and delete remote |
| `cleanup`      | Clean up local branches that track deleted remote branches (`[gone]`)       |

---

### 🔁 Examples

#### Start a feature and push to remote

```bash
git-flow-sync.sh start feature login-ui
```

#### Finish a feature, sync `develop`, and delete remote feature branch

```bash
git-flow-sync.sh finish feature login-ui
```

#### Preview what will be cleaned up (dry run)

```bash
git-flow-sync.sh cleanup --dry-run
```

#### Cleanup and auto-delete all stale local branches (force)

```bash
git-flow-sync.sh cleanup --force
```

---

## 🧩 Options

| Option        | Description                                                                 |
|---------------|-----------------------------------------------------------------------------|
| `--dry-run`   | Show what would happen without executing any changes                        |
| `--verbose`   | Print detailed output of all commands being executed                        |
| `--force`     | Skip confirmation when deleting stale local branches during `cleanup`       |

---

## 🧹 Cleanup Behavior

The `cleanup` command:

1. Runs `git fetch --prune`
2. Finds local branches tracking deleted remotes (`[gone]`)
3. Optionally deletes those branches (with prompt or force)

This helps keep your repo clean and prevents tracking outdated work.

---

## 🔐 Safety

- Never deletes anything automatically unless `--force` is explicitly provided.
- Always prompts before deleting branches in interactive mode.

---

## 🛠 Extension Ideas

You can easily expand the script to:

- Support `support` branches
- Add `git stash` or save work protection
- Push tags to remote on `release finish`
- Generate changelogs
- Integrate with CI/CD triggers

---

## 📄 License

MIT – Use and customize freely.

---

## ✨ Created by

Built to make **Git Flow actually flow** — cleanly, safely, and with fewer manual steps.
