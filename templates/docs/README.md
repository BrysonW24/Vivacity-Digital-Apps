# Templates - Vivacity Digital Apps

## 📌 Overview
The `templates/` directory provides **production-ready, reusable code templates** that accelerate Flutter development. All templates include comprehensive documentation, error handling, and real-world usage examples.

## 📂 Current Implementation Status

### ✅ **Fully Implemented Templates**

#### **API Integration Templates** 📡
- **[`dio_setup.dart`](../code-patterns/api-patterns/dio_setup.dart)** - Complete Dio HTTP client with retry logic, authentication, and error handling
- **[`graphql_setup.dart`](../code-patterns/api-patterns/graphql_setup.dart)** - GraphQL client with subscriptions, caching, and real-time updates
- **[`http_client.dart`](../code-patterns/api-patterns/http_client.dart)** - Basic HTTP client template (placeholder)

#### **UI Component Templates** 🎨
- **[`buttons.dart`](ui_components/buttons.dart)** - Custom button library (Primary, Secondary, Danger, Icon, Gradient buttons)
- **[`textfields.dart`](ui_components/textfields.dart)** - Specialized text fields (Email, Password with strength indicator, Search, Phone)

#### **State Management Templates** 🔄
- **[`provider_example.dart`](../code-patterns/state-patterns/provider_example.dart)** - Complete Provider implementation with authentication, cart, and theme management
- **[`riverpod_example.dart`](../code-patterns/state-patterns/riverpod_example.dart)** - Modern Riverpod implementation with async state and providers

#### **CI/CD Configuration Templates** 🚀
- **[`github_actions.yml`](../ci-cd/configs/github_actions.yml)** - Comprehensive GitHub Actions workflow with testing, building, and deployment
- **[`bitrise_pipeline.yml`](../ci-cd/configs/bitrise_pipeline.yml)** - Bitrise mobile CI/CD pipeline with app store deployment
- **[`gitlab_ci.yml`](../ci-cd/configs/gitlab_ci.yml)** - GitLab CI comprehensive pipeline with multi-platform support

#### **Testing Framework Templates** 🧪
- **[`unit_tests_example.dart`](testing_frameworks/unit_tests_example.dart)** - Unit testing templates (placeholder)

### 📋 **Planned Templates**

#### **Project Boilerplates**
- `basic_flutter_app/` - Minimal Flutter app template
- `mvvm_flutter_template/` - MVVM-based Flutter project structure
- `clean_architecture/` - Template for clean architecture Flutter apps

#### **Additional UI Components**
- `cards.dart` - Custom card UI elements
- `dialogs.dart` - Common dialog popups (confirm, alert, success)

#### **State Management**
- `bloc_pattern.dart` - BLoC pattern starter template

#### **Testing Frameworks**
- `widget_test_example.dart` - Widget testing sample
- `integration_test.dart` - Integration testing setup

## 📂 Organized Folder & File Structure

```
templates/
│
├── 🎯 project_boilerplates/    # ✅ Production-ready project templates
│   ├── variants/               # Deployment variants
│   │   ├── small-app/         # Base template (cloud-agnostic)
│   │   ├── small-app-aws/     # AWS Amplify variant
│   │   ├── small-app-gcp/     # Google Cloud variant
│   │   └── small-app-onpremis/ # Enterprise on-premises
│   └── README.md
│
├── 💻 code-patterns/           # Code patterns & best practices
│   ├── api-patterns/          # ✅ API client templates (Dio, GraphQL, HTTP)
│   └── state-patterns/        # ✅ State management (Provider, Riverpod)
│
├── 🚀 ci-cd/                   # CI/CD pipeline templates
│   └── configs/               # ✅ GitHub Actions, Bitrise, GitLab CI
│
├── 📱 platform-guides/         # Platform-specific implementations
│   └── platform-configs/      # iOS, Android, Web, Hybrid configs
│
├── 🎨 ui_components/           # ✅ Reusable UI components
│   ├── buttons.dart           # Custom button library
│   └── textfields.dart        # Advanced text field components
│
├── 🧪 testing_frameworks/      # 🔄 Testing templates
│   └── unit_tests_example.dart # Unit test examples
│
└── 📚 docs/                    # Documentation
    ├── README.md              # This file (updated)
    ├── BOILERPLATE_USAGE_GUIDE.md
    └── CONTRIBUTION_GUIDE.md
```

### **Folder Organization Logic:**
- **project_boilerplates/** - Main starting point for new projects
- **code-patterns/** - Reusable code patterns (API, state management)
- **ci-cd/** - Deployment automation
- **platform-guides/** - Platform-specific implementations
- **ui_components/** - UI component library
- **testing_frameworks/** - Testing patterns and examples
- **docs/** - All documentation

## 🚀 How to Use Templates

### **1️⃣ Copy & Customize Templates**
```bash
# Copy any template to your project
cp templates/api_integrations/dio_setup.dart lib/services/dio_client.dart

# Then customize for your API endpoints and requirements
# Edit the baseUrl, add your authentication logic, etc.
```

### **2️⃣ API Integration Quick Start**
```dart
// Using Dio Template
import 'package:your_app/services/dio_client.dart';

final dioClient = DioClient();
// Now you have a fully configured HTTP client with:
// - Automatic retries
// - Authentication handling
// - Error management
// - Request/response logging

// Using GraphQL Template
import 'package:your_app/services/graphql_client.dart';

final graphQLClient = GraphQLClientService();
// Ready for queries, mutations, and subscriptions
```

### **3️⃣ UI Components Usage**
```dart
// Using Button Components
PrimaryButton(
  text: 'Login',
  onPressed: () => login(),
  isLoading: authState.isLoading,
)

PasswordTextField(
  controller: passwordController,
  showStrengthIndicator: true,
  onChanged: (value) => validatePassword(value),
)
```

### **4️⃣ State Management Setup**
```dart
// Provider Setup
return MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => CartProvider()),
  ],
  child: MyApp(),
);

// Riverpod Setup
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
```

### **5️⃣ CI/CD Pipeline Setup**
- **GitHub Actions**: Copy `ci-cd/configs/github_actions.yml` to `.github/workflows/`
- **Bitrise**: Import `ci-cd/configs/bitrise_pipeline.yml` into your Bitrise project
- **GitLab CI**: Copy `ci-cd/configs/gitlab_ci.yml` to `.gitlab-ci.yml`

### **6️⃣ Testing Framework Usage**
```dart
// Unit Test Example
void main() {
  test('User model should create correctly', () {
    final user = User(id: '1', name: 'Test', email: 'test@example.com');
    expect(user.name, 'Test');
  });
}
```

## 🎯 Future Roadmap & Contributions

### **Immediate Priorities** 🔥
- **Fill Placeholder Files** - Replace empty template files with working implementations
- **Add Missing Templates** - Create Bloc pattern, Clean Architecture, and testing templates
- **Expand UI Library** - Add cards, dialogs, and additional components
- **Backend Templates** - Authentication, database, and API service templates

### **Community Contributions Needed** 🤝
We're actively seeking contributors to help populate the remaining placeholder files and add new templates. Here's how you can help:

#### **Template Implementation Areas**
1. **Complete Project Boilerplates**
   - Convert placeholder files in `project_boilerplates/` to full Flutter projects
   - Add proper folder structures, dependencies, and starter code

2. **Expand Testing Frameworks**
   - Create comprehensive unit, widget, and integration test templates
   - Add testing utilities and mock data generators

3. **Add State Management Patterns**
   - Implement BLoC pattern template
   - Add MobX and GetX examples
   - Create comparison guides

4. **Enhance UI Components**
   - Build card components library
   - Create dialog templates (alert, confirmation, custom)
   - Add form validation components

#### **Contribution Guidelines**
- Follow existing code patterns and documentation standards
- Include comprehensive error handling and edge cases
- Add usage examples and clear documentation
- Ensure templates work with latest Flutter versions
- Test templates across different platforms when possible

### **Quality Standards**
- **Error Handling** - All templates must handle errors gracefully
- **Documentation** - Include inline comments and usage examples
- **Testing** - Templates should demonstrate best testing practices
- **Performance** - Consider performance implications in implementations
- **Accessibility** - UI components should follow accessibility guidelines

## 📞 Need Help?
If you need assistance with templates, refer to this **README.md** or contact the development team.

🎯 **Build efficiently, reuse smartly, and deploy confidently! 🚀🔥**

