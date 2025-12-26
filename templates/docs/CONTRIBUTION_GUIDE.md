# Template Contribution Guide

## 🎯 Overview
This guide helps contributors populate and expand the Vivacity Digital Apps template library. We welcome contributions that fill placeholder files, add new templates, and improve existing implementations.

## 📋 Current Status & Priorities

### ✅ **Completed Templates** (Ready to Use)
- **API Integration**: Dio HTTP client & GraphQL client
- **UI Components**: Buttons & Text Fields libraries
- **State Management**: Provider & Riverpod examples
- **CI/CD**: GitHub Actions, Bitrise, GitLab CI pipelines

### 🔄 **High Priority - Needs Implementation**
1. **Project Boilerplates** - Convert placeholders to working Flutter projects
2. **Bloc State Management** - Add BLoC pattern implementation
3. **Testing Templates** - Expand unit, widget, and integration tests
4. **UI Components** - Add cards, dialogs, form validation
5. **Backend Templates** - Authentication, database, API services

## 🚀 How to Contribute

### **1. Choose a Template to Implement**

#### **Option A: Fill Existing Placeholders**
```bash
# Navigate to placeholder files
cd templates/project_boilerplates/basic_flutter_app/
# Replace placeholder.txt with actual Flutter project structure
```

#### **Option B: Add New Templates**
```bash
# Create new template directory
mkdir templates/new_feature/
# Add implementation and documentation
```

### **2. Implementation Standards**

#### **Code Quality Requirements**
- **Error Handling**: Implement comprehensive error handling
- **Documentation**: Add detailed comments and usage examples
- **Testing**: Include test examples and demonstrate best practices
- **Flutter Standards**: Follow official Flutter guidelines and conventions
- **Dart Analysis**: Pass `flutter analyze` with no errors

#### **Template Structure**
```dart
/// Template Name - Brief Description
/// This template provides [functionality] with:
/// - Feature 1: Description
/// - Feature 2: Description
/// - Usage examples and best practices

// Implementation here...

// Usage example:
/*
void main() {
  // Example usage code
}
*/
```

### **3. File Naming Conventions**
- Use snake_case for file names: `custom_button.dart`
- Use PascalCase for class names: `CustomButton`
- Include descriptive suffixes: `auth_provider.dart`, `login_screen.dart`

### **4. Documentation Requirements**

#### **README Updates**
- Update main README.md with new template status
- Add template to appropriate section with implementation status
- Include brief description and key features

#### **Inline Documentation**
```dart
/// Class Purpose
/// Detailed description of what this class does
/// @param parameter - Description of parameter
/// @return What the method returns
class ExampleClass {
  /// Method Purpose
  /// @param param - Parameter description
  /// @return Return value description
  void exampleMethod(String param) {
    // Implementation
  }
}
```

### **5. Testing Guidelines**

#### **Unit Tests**
```dart
import 'package:test/test.dart';

void main() {
  group('Template Component Tests', () {
    test('should initialize correctly', () {
      // Test implementation
    });

    test('should handle errors gracefully', () {
      // Error handling tests
    });
  });
}
```

#### **Widget Tests**
```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Template widget renders correctly', (WidgetTester tester) async {
    // Widget testing implementation
  });
}
```

### **6. Pull Request Process**

#### **Branch Naming**
```bash
# For template implementations
git checkout -b template/implement-feature-name

# For template improvements
git checkout -b template/improve-existing-template

# For new template additions
git checkout -b template/add-new-template
```

#### **Commit Messages**
```bash
# Follow conventional commits
feat: implement Dio HTTP client template
feat: add GraphQL client with subscriptions
fix: resolve authentication error in provider template
docs: update template usage examples
```

#### **PR Description Template**
```markdown
## Template Implementation: [Template Name]

### Changes Made
- ✅ Implemented [specific feature]
- ✅ Added comprehensive error handling
- ✅ Included usage examples
- ✅ Added unit tests

### Files Modified
- `templates/[category]/[template_file].dart`
- `templates/README.md` (updated status)
- `README.md` (updated main documentation)

### Testing
- [ ] Unit tests pass
- [ ] Widget tests pass (if applicable)
- [ ] Integration tests pass (if applicable)
- [ ] Flutter analyze passes
- [ ] Manual testing completed

### Screenshots/Demos (if applicable)
[Add screenshots or code examples showing the template in action]

### Related Issues
Closes #[issue_number]
```

### **7. Template Categories**

#### **API Integration Templates**
- HTTP clients (Dio, http package)
- GraphQL clients
- WebSocket clients
- Authentication handlers

#### **UI Component Templates**
- Form elements (buttons, inputs, dropdowns)
- Layout components (cards, dialogs, sheets)
- Navigation components (tabs, drawers, bottom nav)
- Feedback components (loading, error states, notifications)

#### **State Management Templates**
- Provider implementations
- Riverpod implementations
- Bloc pattern implementations
- MobX implementations

#### **Testing Templates**
- Unit test utilities
- Widget test helpers
- Integration test frameworks
- Mock data generators

#### **Project Boilerplates**
- Basic Flutter apps
- Architecture-specific starters (MVVM, Clean Architecture)
- Feature-specific starters (e-commerce, social, productivity)

## 🎖️ Recognition & Rewards

Contributors to template development will be:
- Listed in the project contributors
- Featured in template documentation
- Considered for project maintainership
- Eligible for community recognition

## 📞 Need Help?

- **GitHub Issues**: For bugs and feature requests
- **GitHub Discussions**: For questions and community support
- **Slack/Teams**: For team communication

## 🔗 Useful Resources

- [Flutter Official Documentation](https://flutter.dev/docs)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [Flutter Testing Cookbook](https://flutter.dev/docs/cookbook/testing)

---

**Happy Contributing!** 🎉 Your templates will help developers worldwide build better Flutter apps faster.