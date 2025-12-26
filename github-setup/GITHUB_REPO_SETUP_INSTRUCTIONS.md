# GitHub Monorepo Setup Instructions

## Step 1: Create GitHub Repository (Manual - GitHub Web Interface)

### Create the vivacity-digital-apps Repository

1. Go to https://github.com/organizations/vivacitydigital/repositories/new
   (Or: GitHub home → Your orgs → vivacitydigital → New)

2. Fill in the form:
   - **Repository name**: `vivacity-digital-apps`
   - **Description**: `6 Flutter applications with shared boilerplate. Portfolio showcase.`
   - **Visibility**: `Public`
   - **Initialize with README**: `No` (we'll add our own)
   - **Add .gitignore**: `Dart`
   - **.gitignore template**: Choose `Dart`
   - **Add a license**: `MIT License` (optional)

3. Click "Create repository"

4. You'll get a URL: `https://github.com/vivacitydigital/vivacity-digital-apps`

---

## Step 2: Clone Repository Locally

Once you've created the GitHub repo, run these commands:

```bash
cd "e:\dev\AiaaS\vivacity-digital-dev\Vivacity-Digital-Apps"
git clone https://github.com/vivacitydigital/vivacity-digital-apps.git
cd vivacity-digital-apps
```

---

## Step 3: Copy Project Files

A script will prepare all the files for you. Files are already organized in:

```
Prepared in:
  └── e:\dev\AiaaS\vivacity-digital-dev\Vivacity-Digital-Apps\monorepo-prepared\
```

Copy the prepared structure:

```bash
# Navigate to the vivacity-digital-apps directory you just cloned
cd vivacity-digital-apps

# Copy all prepared files
# (Script will handle this)
```

---

## Step 4: Verify Structure

After copying, your repo should look like:

```
vivacity-digital-apps/
├── apps/
│   ├── journal-app/
│   ├── fitcoach-pro/
│   ├── taskflow/
│   ├── recipebank/
│   ├── booking-hub/
│   └── service-hub/
├── shared/
│   └── boilerplate/
├── .github/
│   └── workflows/
├── docs/
├── .gitignore
├── README.md
├── CONTRIBUTING.md
└── LICENSE (optional)
```

---

## Step 5: Create Initial Commit and Push

```bash
cd vivacity-digital-apps
git add .
git commit -m "feat: Initialize vivacity-digital-apps monorepo

- Add 6 Flutter applications (journal-app, fitcoach-pro, taskflow, recipebank, booking-hub, service-hub)
- Add shared boilerplate with complete architecture
- Add GitHub Actions CI/CD workflows
- Add comprehensive documentation
- Add MIT license for open-source portfolio"

git push origin main
```

---

## Step 6: Configure GitHub Settings (Web Interface)

After pushing, go to: https://github.com/vivacitydigital/vivacity-digital-apps/settings

### 1. General Settings
- Default branch: `main`
- Auto-delete head branches: ✅ Enable
- Always suggest updating PR branches: ✅ Enable

### 2. Branches → Add Protection Rule
- Branch name pattern: `main`
- Require pull request reviews before merging: 1
- Require status checks to pass: ✅
- Require branches to be up to date: ✅

### 3. Actions → General
- Default permissions: "Read repository contents"
- Allow GitHub Actions to create/approve PRs: ✅

---

## You're Done with Phase 1!

Once you've:
1. ✅ Created the GitHub repo
2. ✅ Cloned it locally
3. ✅ Run the file copy script
4. ✅ Created initial commit and pushed
5. ✅ Configured branch protection rules

**Your monorepo is live!** All 6 Flutter projects are on GitHub.

Next: Phase 2 - Create portfolio-website Next.js project

