# Git Branching Strategy - Vivacity Digital Apps

## 📌 Overview
This document outlines the **Git branching strategy** for Vivacity Digital Apps. It explains the purpose of each branch, when to create and merge branches, and how to maintain a structured workflow for **solo development and scaling to teams**.

## 📂 Branch Structure & Purpose
Below is the structured branch hierarchy used in this repository:

```
main                # Stable, production-ready code
│
development         # Active working branch (merged before main)
│
├── feature/xyz     # New features under development
│
├── bugfix/xyz      # Fixes for non-critical bugs
│
├── hotfix/xyz      # Urgent fixes for production
│
└── release/xyz     # Pre-release branch for testing
```

---

### **🔹 `main` - Stable Production Code**
✅ **Purpose:**
- This branch contains the latest **stable, production-ready code**.
- **Only tested, reviewed, and approved** changes should be merged here.

🚀 **When to update?**
- After testing and approval from the `development` branch.
- Only merge using **pull requests** to prevent accidental overwrites.

📌 **Commands:**
```bash
git checkout main
git merge development
git push origin main
```

---

### **🔸 `development` - Active Development Branch**
❌ **Not Stable (Work in Progress)**

✅ **Purpose:**
- This branch is where **active development** happens.
- Feature branches merge here before being finalized.

🚀 **When to update?**
- Regularly merged from feature branches after testing.
- Periodically synced with `main` to stay up to date.

📌 **Commands:**
```bash
git checkout development
git pull origin development
git merge feature/new-feature
git push origin development
```

---

### **🛠 `feature/*` - Feature Development**
✅ **Purpose:**
- **Every new feature gets its own branch.**
- Keeps development organized and modular.

🚀 **When to create?**
- Whenever developing a new feature.
- Named as `feature/feature-name`.

📌 **Commands:**
```bash
git checkout -b feature/new-feature development
# Work on the feature
git commit -m "feat: added login functionality"
git push origin feature/new-feature
```

🔄 **Merging:**
```bash
git checkout development
git merge feature/new-feature
git push origin development
```

---

### **🐛 `bugfix/*` - Fixing Bugs**
✅ **Purpose:**
- Used for **fixing non-critical bugs** found in development.
- **Not urgent** (hotfix branch is used for production bugs).

📌 **Commands:**
```bash
git checkout -b bugfix/fix-login development
# Fix the issue
git commit -m "fix: resolved login bug"
git push origin bugfix/fix-login
```

🔄 **Merging:**
```bash
git checkout development
git merge bugfix/fix-login
git push origin development
```

---

### **🔥 `hotfix/*` - Urgent Fixes for Production**
✅ **Purpose:**
- **Critical bug fixes** that need immediate action.
- **Created from `main` and merged back ASAP.**

📌 **Commands:**
```bash
git checkout -b hotfix/urgent-bug main
# Fix the issue
git commit -m "hotfix: urgent fix for production crash"
git push origin hotfix/urgent-bug
```

🔄 **Merging:**
```bash
git checkout main
git merge hotfix/urgent-bug
git push origin main
git checkout development
git merge main
git push origin development
```

---

### **🚀 `release/*` - Pre-Production Testing**
✅ **Purpose:**
- Used for **final testing** before merging into `main`.
- Stabilizes the code before production deployment.

📌 **Commands:**
```bash
git checkout -b release/v1.0 development
# Conduct testing & bug fixes
git commit -m "chore: final tests before release"
git push origin release/v1.0
```

🔄 **Merging:**
```bash
git checkout main
git merge release/v1.0
git push origin main
```

---

## 🔄 Keeping Branches Up-to-Date
To keep everything **clean and organized**:
- Delete **merged feature branches**
```bash
git branch -d feature/old-feature
git push origin --delete feature/old-feature
```
- Regularly **sync development with main**
```bash
git checkout development
git pull origin main
git push origin development
```

---

## 🚀 Future Roadmap
✅ Document branch workflows clearly
✅ Maintain structured feature and bugfix branches
🔜 Automate branch cleanup scripts
🔜 Introduce GitHub Actions for release automation

---

## 📌 FAQs
**1️⃣ Will the README automatically update across branches?**  
No, when you commit this README to `main`, other branches **will not automatically get the update**. You need to manually merge or rebase it.

**2️⃣ Can I skip using `release` branches?**  
Yes! For solo projects, `release/*` branches are **optional**.

**3️⃣ Should I commit directly to `main`?**  
❌ **No.** Always commit to `development` first, test it, and then merge into `main`.

---

## 📞 Need Help?
If you have any questions regarding Git branching, refer to this **README.md** or contact the repository maintainer.

🎯 **Keep your workflow