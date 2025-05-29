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
