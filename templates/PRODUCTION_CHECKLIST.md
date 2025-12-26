# Production Repository Separation Checklist

This document provides a comprehensive checklist for separating the templates directory into a standalone production repository.

## Pre-Separation Tasks

### Documentation Review
- [x] Main README.md optimized and professional
- [x] STRUCTURE.md created with complete directory documentation
- [x] CONTRIBUTING.md established with contribution guidelines
- [x] CHANGELOG.md initialized with version history
- [x] LICENSE file added (MIT License)
- [x] Category READMEs created for all major directories
- [ ] Platform-specific READMEs standardized
- [ ] All inline code documentation reviewed
- [ ] Remove any "README-old.md" or draft files

### Code Quality
- [ ] All template code linted and formatted
- [ ] No syntax errors in any template
- [ ] All dependencies specified with minimum versions
- [ ] Remove any commented-out code
- [ ] Verify all file paths in documentation
- [ ] Test all code examples in READMEs

### Security Audit
- [ ] No hardcoded API keys or secrets
- [ ] No personal or sensitive information
- [ ] All `.env.example` files present (no `.env` files)
- [ ] Verify `.gitignore` is comprehensive
- [ ] Review all configuration files for sensitive data
- [ ] Ensure no internal URLs or IPs

### Content Standardization
- [ ] All documentation uses neutral, professional language
- [ ] Consistent terminology throughout
- [ ] No company-specific references that shouldn't be public
- [ ] All branding is appropriate for public release
- [ ] Version numbers consistent across all files

## Repository Setup

### 1. Create New Repository

```bash
# Option A: GitHub CLI
gh repo create vivacity-digital/application-templates --public \
  --description "Production-ready application templates and boilerplates" \
  --homepage "https://vivacitydigital.com"

# Option B: Manual creation via GitHub web interface
# Navigate to https://github.com/new
```

**Repository Settings:**
- Name: `application-templates` or `vivacity-templates`
- Description: "Production-ready templates, boilerplates, and configurations for rapid application development"
- Visibility: Public (or Private initially)
- Initialize without README (we'll add our own)
- No .gitignore (we have our own)
- License: MIT (already included)

### 2. Prepare Source Directory

```bash
# Navigate to templates directory
cd e:\dev\AiaaS\vivacity-digital-dev\Vivacity-Digital-Apps\templates

# Initialize git if not already done
git init

# Create .gitignore
cat > .gitignore << 'EOF'
# OS Files
.DS_Store
Thumbs.db
desktop.ini

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# Temporary files
*.tmp
*.log
.temp/

# Build outputs (in case someone tests locally)
build/
dist/
*.apk
*.ipa
*.aab

# Dependencies (should not be in templates)
node_modules/
.pub-cache/
.flutter-plugins
.flutter-plugins-dependencies
.packages

# Environment files
.env
.env.local
.env.production

# Test coverage
coverage/
.nyc_output/

# Platform specific
ios/Pods/
android/.gradle/

# Backup and draft files
*-old.*
*.bak
*.backup
EOF
```

### 3. Clean Up Directory

```bash
# Remove draft files
find . -name "*-old.*" -type f -delete
find . -name "*.bak" -type f -delete
find . -name "*.backup" -type f -delete

# Remove empty directories
find . -type d -empty -delete

# Remove build artifacts if any
find . -name "build" -type d -exec rm -rf {} +
find . -name "node_modules" -type d -exec rm -rf {} +
find . -name ".pub-cache" -type d -exec rm -rf {} +
```

### 4. Initial Commit

```bash
# Stage all files
git add .

# Create initial commit
git commit -m "Initial release: Application Templates v1.0.0

- Comprehensive template collection for web, mobile, and hybrid apps
- Testing frameworks and UI components
- Code patterns for API and state management
- CI/CD configurations for GitHub Actions, GitLab, Bitrise
- Platform-specific configs (iOS, Android, Web, Hybrid)
- Complete documentation and contribution guidelines

Includes:
- README.md with usage examples
- STRUCTURE.md for directory organization
- CONTRIBUTING.md for contributors
- CHANGELOG.md for version tracking
- LICENSE (MIT)
- Category-specific READMEs"
```

### 5. Push to Remote

```bash
# Add remote origin
git remote add origin https://github.com/vivacity-digital/application-templates.git

# Create and push main branch
git branch -M main
git push -u origin main

# Create develop branch
git checkout -b develop
git push -u origin develop
```

## Repository Configuration

### Branch Protection Rules

Configure on GitHub: Settings > Branches > Add rule

**For `main` branch:**
- [x] Require pull request before merging
- [x] Require approvals: 1
- [x] Dismiss stale pull request approvals
- [x] Require status checks to pass
- [x] Require branches to be up to date
- [ ] Require signed commits (optional)
- [x] Include administrators
- [x] Restrict pushes

**For `develop` branch:**
- [x] Require pull request before merging
- [ ] Require approvals: 0 (or 1 for stricter control)
- [x] Require status checks to pass

### Repository Settings

**General:**
- [ ] Features:
  - [x] Issues enabled
  - [x] Discussions enabled (optional, for community)
  - [ ] Projects (optional)
  - [x] Wiki disabled (use docs/ instead)
- [ ] Pull Requests:
  - [x] Allow squash merging
  - [x] Allow rebase merging
  - [ ] Allow merge commits
  - [x] Automatically delete head branches

**Collaborators:**
- [ ] Add team members with appropriate access levels
- [ ] Configure code owners (create CODEOWNERS file)

**Secrets and Variables:**
- [ ] Add CI/CD secrets if needed for automated testing
- [ ] Configure deployment keys if needed

### GitHub Actions

Create workflow for automated checks:

```yaml
# .github/workflows/quality-check.yml
name: Quality Check

on:
  pull_request:
    branches: [main, develop]
  push:
    branches: [main]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Check markdown
        uses: DavidAnson/markdownlint-cli2-action@v9
        with:
          globs: '**/*.md'

      - name: Check YAML
        uses: ibiqlik/action-yamllint@v3
        with:
          file_or_dir: ci-cd/configs/*.yml

  verify-links:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Check links in markdown
        uses: gaurav-nelson/github-action-markdown-link-check@v1
```

### Issue Templates

Create `.github/ISSUE_TEMPLATE/` directory:

**Bug Report** (bug_report.yml):
```yaml
name: Bug Report
description: Report a bug in a template
labels: ["bug", "triage"]
body:
  - type: markdown
    attributes:
      value: Thanks for taking the time to report this issue!

  - type: dropdown
    id: category
    attributes:
      label: Category
      options:
        - Testing Frameworks
        - UI Components
        - Code Patterns
        - CI/CD
        - Platform Guides
        - Documentation
    validations:
      required: true

  - type: textarea
    id: description
    attributes:
      label: Description
      description: What's the issue?
    validations:
      required: true
```

**Feature Request** (feature_request.yml):
```yaml
name: Feature Request
description: Suggest a new template or improvement
labels: ["enhancement"]
body:
  - type: textarea
    id: description
    attributes:
      label: Template Description
      description: Describe the template or feature you'd like to see
    validations:
      required: true
```

### Pull Request Template

Create `.github/pull_request_template.md`:

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] New template
- [ ] Template improvement
- [ ] Bug fix
- [ ] Documentation update
- [ ] CI/CD configuration

## Category
- [ ] Testing Frameworks
- [ ] UI Components
- [ ] Code Patterns
- [ ] CI/CD
- [ ] Platform Guides
- [ ] Documentation

## Checklist
- [ ] Code follows style guidelines
- [ ] Documentation is complete
- [ ] No secrets or credentials included
- [ ] Templates tested
- [ ] CHANGELOG.md updated
- [ ] All files properly formatted

## Testing Performed
Describe how you tested these changes

## Breaking Changes
List any breaking changes (if applicable)
```

## Documentation Finalization

### Update All Links

- [ ] Verify all internal links work
- [ ] Update repository URLs from local to GitHub
- [ ] Fix any broken markdown links
- [ ] Ensure all relative paths are correct

### Add Badges to README

```markdown
# Application Templates

![License](https://img.shields.io/github/license/vivacity-digital/application-templates)
![Version](https://img.shields.io/github/v/release/vivacity-digital/application-templates)
![Stars](https://img.shields.io/github/stars/vivacity-digital/application-templates)
![Issues](https://img.shields.io/github/issues/vivacity-digital/application-templates)
![Contributors](https://img.shields.io/github/contributors/vivacity-digital/application-templates)
```

### Create Additional Documentation

**CODE_OF_CONDUCT.md:**
```markdown
# Code of Conduct

## Our Pledge
We are committed to providing a welcoming and inclusive environment.

## Our Standards
- Professional communication
- Respectful collaboration
- Constructive feedback
- Focus on technical merit

## Enforcement
Violations can be reported to conduct@vivacitydigital.com
```

**SECURITY.md:**
```markdown
# Security Policy

## Reporting Vulnerabilities
Please report security issues to security@vivacitydigital.com

Do not open public issues for security vulnerabilities.

## Supported Versions
Only the latest version receives security updates.
```

## Release Preparation

### Create Release

```bash
# Tag the release
git tag -a v1.0.0 -m "Release version 1.0.0

Initial production release including:
- Complete template collection
- Comprehensive documentation
- CI/CD configurations
- Platform-specific setups"

# Push tag
git push origin v1.0.0
```

### GitHub Release

On GitHub: Releases > Create a new release

- Tag: v1.0.0
- Title: "Application Templates v1.0.0"
- Description: Copy from CHANGELOG.md
- Attachments: None needed (templates are in repo)

### Update Version References

- [ ] README.md mentions correct version
- [ ] CHANGELOG.md has release date
- [ ] All documentation references are current

## Post-Separation Tasks

### Repository Promotion

**Internal:**
- [ ] Announce to Vivacity Digital team
- [ ] Update internal documentation
- [ ] Add to company resources list

**External (if public):**
- [ ] Share on social media
- [ ] Post on relevant forums/communities
- [ ] Add to awesome lists (if applicable)
- [ ] Update company website

### Monitoring Setup

- [ ] Enable GitHub Insights
- [ ] Set up notifications for issues/PRs
- [ ] Configure dependency alerts
- [ ] Enable security alerts

### Maintenance Plan

- [ ] Schedule regular updates (quarterly)
- [ ] Assign maintainers
- [ ] Create maintenance schedule
- [ ] Plan for dependency updates

## Verification Steps

### Final Checks

```bash
# Clone fresh copy to verify
git clone https://github.com/vivacity-digital/application-templates.git test-clone
cd test-clone

# Verify structure
ls -la

# Test copy commands from README
cp -r testing_frameworks/ /tmp/test/
cp -r ui_components/ /tmp/test/

# Check for sensitive data
git log --all --full-history --source --source -- '*secret*' '*password*' '*key*'
```

### Quality Assurance

- [ ] All READMEs render correctly on GitHub
- [ ] All code blocks have syntax highlighting
- [ ] All links work (internal and external)
- [ ] No broken images or assets
- [ ] Repository description is accurate
- [ ] Topics/tags are set appropriately

### Community Readiness

- [ ] Contributing guidelines are clear
- [ ] Issue templates work correctly
- [ ] PR template is comprehensive
- [ ] Code of conduct is present
- [ ] License is clearly stated

## Rollback Plan

If issues are discovered:

```bash
# Option 1: Fix and force push (only if no one has cloned)
git commit --amend
git push --force

# Option 2: Revert and push fix
git revert <commit-hash>
git push origin main

# Option 3: Delete and recreate repository
# (Last resort, requires admin access)
```

## Success Criteria

Repository is ready when:

- [x] All documentation is professional and complete
- [x] No sensitive information present
- [x] All templates are tested and working
- [ ] Branch protection configured
- [ ] CI/CD workflows running
- [ ] Issue/PR templates functional
- [ ] README renders perfectly
- [ ] License clearly stated
- [ ] Contributing guidelines clear
- [ ] Initial release tagged

## Timeline

**Week 1:**
- Complete all pending documentation
- Security audit
- Clean up files

**Week 2:**
- Create repository
- Configure settings
- Initial push

**Week 3:**
- Set up CI/CD
- Create templates
- Test everything

**Week 4:**
- Final review
- Create release
- Announce

## Contact Points

**Repository Maintainers:**
- Primary: [Name/Email]
- Secondary: [Name/Email]

**Security Contact:**
- security@vivacitydigital.com

**General Inquiries:**
- templates@vivacitydigital.com

---

**Status:** In Progress
**Target Release:** TBD
**Current Version:** 1.0.0-rc

Last Updated: 2025-12-22
