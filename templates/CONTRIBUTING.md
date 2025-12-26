# Contributing to Application Templates

Thank you for your interest in contributing to the Vivacity Digital Application Templates repository. This document provides guidelines and standards for contributing new templates or improving existing ones.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Contribution Workflow](#contribution-workflow)
- [Template Standards](#template-standards)
- [Documentation Requirements](#documentation-requirements)
- [Testing Guidelines](#testing-guidelines)
- [Submission Process](#submission-process)

## Code of Conduct

### Our Standards

- Professional and respectful communication
- Constructive feedback and collaboration
- Focus on technical merit and quality
- Inclusive and welcoming environment

### Scope

This code of conduct applies to all project spaces including code reviews, issues, pull requests, and communications.

## Getting Started

### Prerequisites

Before contributing, ensure you have:

1. **Development Environment**
   - Git installed and configured
   - Relevant development tools (Flutter, Node.js, etc.)
   - Code editor with linting support

2. **Knowledge Requirements**
   - Understanding of the target platform/framework
   - Familiarity with best practices for the technology
   - Experience with production-ready code

3. **Repository Access**
   - Fork the repository
   - Clone your fork locally
   - Set up upstream remote

```bash
git clone https://github.com/your-username/Vivacity-Digital-Apps.git
cd Vivacity-Digital-Apps/templates
git remote add upstream https://github.com/vivacity-digital/Vivacity-Digital-Apps.git
```

## Contribution Workflow

### 1. Identify Contribution Type

#### New Template
- Fills a gap in existing templates
- Addresses common development needs
- Follows modern best practices
- Production-ready quality

#### Template Improvement
- Bug fixes or corrections
- Performance optimizations
- Updated dependencies
- Enhanced documentation

#### Documentation
- Clarifications and examples
- Usage guides
- Architecture explanations

### 2. Create Feature Branch

```bash
# Update your fork
git checkout main
git pull upstream main

# Create feature branch
git checkout -b feature/template-name
# or
git checkout -b fix/issue-description
```

### 3. Develop Your Contribution

Follow the [Template Standards](#template-standards) section below.

### 4. Commit Changes

```bash
# Stage changes
git add .

# Commit with descriptive message
git commit -m "Add: [Template Name] - Brief description"
```

**Commit Message Format:**
- `Add:` for new templates
- `Update:` for improvements to existing templates
- `Fix:` for bug fixes
- `Docs:` for documentation only changes

### 5. Push and Create Pull Request

```bash
# Push to your fork
git push origin feature/template-name

# Create pull request on GitHub
```

## Template Standards

### Directory Structure

Place templates in the appropriate category:

```
templates/
├── testing_frameworks/    # For test configurations
├── ui_components/         # For UI components
├── code-patterns/         # For architectural patterns
├── ci-cd/                 # For CI/CD configs
├── platform-guides/       # For platform-specific setups
└── docs/                  # For documentation templates
```

### Code Quality Requirements

#### 1. Clean Code Principles

```dart
// Good: Clear, self-documenting code
class UserRepository {
  Future<User> fetchUserById(String id) async {
    final response = await _httpClient.get('/users/$id');
    return User.fromJson(response.data);
  }
}

// Avoid: Unclear naming, missing error handling
class UR {
  get(i) async {
    var r = await http.get('/users/$i');
    return User.fromJson(r.data);
  }
}
```

#### 2. Error Handling

Always include proper error handling:

```dart
try {
  final result = await apiCall();
  return Right(result);
} on NetworkException catch (e) {
  return Left(NetworkFailure(e.message));
} on ApiException catch (e) {
  return Left(ApiFailure(e.message));
} catch (e) {
  return Left(UnknownFailure(e.toString()));
}
```

#### 3. Type Safety

Use strong typing:

```typescript
// Good: Explicit types
interface User {
  id: string;
  name: string;
  email: string;
}

function getUser(id: string): Promise<User> {
  return api.get<User>(`/users/${id}`);
}

// Avoid: Any types
function getUser(id: any): Promise<any> {
  return api.get(`/users/${id}`);
}
```

#### 4. Configuration Flexibility

Use environment variables and configuration files:

```dart
class ApiConfig {
  static String get baseUrl =>
    const String.fromEnvironment('API_BASE_URL',
      defaultValue: 'https://api.example.com');

  static int get timeout =>
    const int.fromEnvironment('API_TIMEOUT',
      defaultValue: 30000);
}
```

### Security Requirements

#### Never Include:
- API keys or secrets
- Passwords or tokens
- Personal information
- Hardcoded credentials
- Private keys

#### Always Include:
- Environment variable examples
- `.env.example` files
- Security best practices comments
- Input validation examples

```bash
# .env.example
API_KEY=your_api_key_here
DATABASE_URL=postgresql://localhost:5432/mydb
JWT_SECRET=your_secret_here
```

### Performance Standards

#### Bundle Size
- **Micro tier**: <50KB initial load
- **Standard tier**: 100-500KB
- **Premium tier**: Optimized, no hard limit

#### Optimization Requirements
- Lazy loading where applicable
- Code splitting for large apps
- Minification and compression
- Asset optimization

### Naming Conventions

#### Files
- Use lowercase with underscores: `api_client.dart`
- Descriptive names: `user_repository.dart` not `repo.dart`
- Match framework conventions

#### Classes/Components
- PascalCase: `UserRepository`, `ApiClient`
- Descriptive names: `AuthenticationService` not `AuthSvc`

#### Variables/Functions
- camelCase: `getUserById`, `apiClient`
- Meaningful names: `fetchUserData()` not `getData()`

## Documentation Requirements

### Inline Documentation

Every template must include:

#### 1. File Header
```dart
/// User Repository
///
/// Handles user data fetching and caching.
/// Uses Dio for HTTP requests with automatic retry logic.
///
/// Usage:
/// ```dart
/// final repository = UserRepository();
/// final user = await repository.getUserById('123');
/// ```
```

#### 2. Function Documentation
```dart
/// Fetches user by ID from the API
///
/// [id] - The unique user identifier
///
/// Returns [User] on success
/// Throws [NetworkException] on connection failure
/// Throws [NotFoundException] if user doesn't exist
Future<User> getUserById(String id) async {
  // Implementation
}
```

#### 3. Complex Logic Comments
```dart
// Retry logic: Attempt up to 3 times with exponential backoff
// This handles temporary network issues without failing immediately
for (int attempt = 0; attempt < 3; attempt++) {
  try {
    return await _makeRequest();
  } catch (e) {
    if (attempt == 2) rethrow;
    await Future.delayed(Duration(seconds: pow(2, attempt)));
  }
}
```

### README Files

For complex templates or platform configurations, include a README with:

```markdown
# Template Name

## Overview
Brief description of what this template provides.

## Features
- Feature 1
- Feature 2
- Feature 3

## Prerequisites
- Required tools
- Minimum versions
- Dependencies

## Installation
Step-by-step setup instructions

## Configuration
How to customize for specific needs

## Usage Examples
Practical examples with code snippets

## Architecture
High-level architecture explanation (if complex)

## Troubleshooting
Common issues and solutions
```

## Testing Guidelines

### Code Testing

All code templates should be:
- Syntax-validated
- Linted with platform-specific linters
- Tested in a sample project
- Verified on target platform

```bash
# Flutter/Dart
dart analyze
dart format --set-exit-if-changed .
flutter test

# React/TypeScript
npm run lint
npm run type-check
npm test

# Next.js
npm run lint
npm run build
```

### Configuration Testing

For CI/CD and configuration templates:
- Validate YAML/JSON syntax
- Test in actual CI/CD environment
- Verify all referenced secrets/variables
- Document required setup

### Platform Testing

Platform-specific templates must be tested on:
- **iOS**: Latest stable iOS version
- **Android**: API 21 (minimum) and latest
- **Web**: Chrome, Firefox, Safari (latest versions)

## Submission Process

### Pull Request Checklist

Before submitting, ensure:

- [ ] Code follows style guidelines
- [ ] All tests pass
- [ ] Documentation is complete
- [ ] No secrets or credentials included
- [ ] Commit messages are clear
- [ ] Branch is up to date with main
- [ ] Changes are focused and atomic

### Pull Request Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] New template
- [ ] Bug fix
- [ ] Enhancement
- [ ] Documentation

## Category
- [ ] Testing Frameworks
- [ ] UI Components
- [ ] Code Patterns
- [ ] CI/CD
- [ ] Platform Guides
- [ ] Documentation

## Testing
Describe testing performed

## Checklist
- [ ] Code follows style guidelines
- [ ] Documentation updated
- [ ] Tests added/updated
- [ ] No breaking changes
- [ ] Backward compatible

## Screenshots (if applicable)
Add screenshots for UI templates
```

### Review Process

1. **Automated Checks**
   - Linting
   - Tests
   - Build verification

2. **Code Review**
   - Technical correctness
   - Best practices adherence
   - Documentation quality
   - Security review

3. **Approval**
   - Requires approval from maintainers
   - Address feedback
   - Re-request review after changes

4. **Merge**
   - Squash and merge
   - Update changelog
   - Tag release if necessary

## Template Categories Guide

### Testing Frameworks
- Unit test examples
- Integration test setups
- E2E test configurations
- Mock data and factories

### UI Components
- Reusable widgets/components
- Styled components
- Component libraries
- Design system elements

### Code Patterns
- API client implementations
- State management patterns
- Authentication flows
- Data persistence patterns

### CI/CD
- GitHub Actions workflows
- GitLab CI pipelines
- Platform-specific deployment
- Release automation

### Platform Guides
- iOS configurations
- Android setups
- Web platform templates
- Hybrid app configurations

## Best Practices

### Version Control
- Keep commits atomic and focused
- Write clear commit messages
- Don't commit large binary files
- Use `.gitignore` appropriately

### Backward Compatibility
- Maintain compatibility where possible
- Document breaking changes clearly
- Provide migration guides
- Version templates appropriately

### Dependencies
- Use stable, maintained packages
- Document version requirements
- Avoid unnecessary dependencies
- Keep dependencies up to date

### Performance
- Optimize for production
- Consider bundle size
- Use lazy loading
- Profile and benchmark

## Getting Help

### Resources
- Review existing templates
- Read documentation thoroughly
- Check closed pull requests
- Search issues

### Contact
- Open an issue for questions
- Tag maintainers for guidance
- Join community discussions
- Contact Vivacity Digital team

## Recognition

Contributors will be:
- Listed in release notes
- Credited in documentation
- Acknowledged in changelog

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.

---

Thank you for contributing to Vivacity Digital Application Templates!
