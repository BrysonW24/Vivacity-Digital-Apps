# Contributing to React Web Platform

Thank you for your interest in contributing! This document provides guidelines and instructions for contributing to this project.

## Code of Conduct

Please be respectful and professional in all interactions. We are committed to providing a welcoming and inclusive environment.

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/your-username/react-web-platform.git`
3. Create a branch: `git checkout -b feature/your-feature-name`
4. Setup development environment: `./automation-scripts/setup.sh`

## Development Workflow

### Before Making Changes

- Check existing issues and PRs to avoid duplicating work
- Open an issue to discuss significant changes before starting work
- Discuss major architectural changes with maintainers

### While Developing

1. Create a feature branch from `develop`
2. Write clean, readable code following our style guide
3. Add tests for new functionality
4. Write meaningful commit messages

### Commit Messages

Follow conventional commits format:

```
type(scope): description

[optional body]

[optional footer]
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`

Example:
```
feat(auth): add JWT token refresh mechanism

Implement automatic token refresh for better UX.

Closes #123
```

### Code Style

- Use TypeScript for type safety
- Follow ESLint and Prettier configurations
- Format code with: `pnpm format`
- Lint code with: `pnpm lint`

### Testing

- Write tests for new features and bug fixes
- Run tests locally: `pnpm test`
- Ensure tests pass in CI/CD pipeline
- Aim for >70% code coverage

### Documentation

- Update README.md if adding user-facing features
- Add/update JSDoc comments for exported functions
- Document complex logic with inline comments
- Update API documentation if adding endpoints

## Pull Request Process

1. Update the CHANGELOG.md with your changes
2. Ensure all checks pass in CI/CD
3. Request review from maintainers
4. Address feedback and re-request review
5. Squash commits if requested
6. PR will be merged once approved

## Testing Guidelines

### Unit Tests
```bash
pnpm test
```

### Integration Tests
```bash
pnpm test:integration
```

### E2E Tests
```bash
pnpm test:e2e
```

### Coverage Report
```bash
pnpm test:coverage
```

## Reporting Issues

- Use the issue template provided
- Include reproduction steps for bugs
- Provide relevant version information
- Attach error messages and screenshots if applicable

## Questions?

- Open an issue with the `question` label
- Join our community discussions
- Check existing documentation

Thank you for contributing!
