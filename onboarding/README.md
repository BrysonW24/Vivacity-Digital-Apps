# Onboarding - Vivacity Digital Apps

## 📌 Overview
The `onboarding/` directory is designed to **help new developers quickly get up to speed** with the Vivacity Digital Apps development workflow. This section provides setup instructions, coding standards, tools to install, and access requirements.

This guide is intended for **new engineers, contractors, and contributors** working on Flutter applications under Vivacity Digital Apps.

## 📂 Forecasted Folder & File Structure
_These are expected files and subfolders that will be created to support structured onboarding._

```
onboarding/
│── setup/                      # Environment setup guides
│   ├── flutter_install.md      # Installing Flutter & Dart
│   ├── android_studio_setup.md # Setting up Android Studio for Flutter
│   ├── vs_code_setup.md        # Configuring VS Code for Flutter development
│   ├── git_workflow.md         # Cloning, branching, and PR conventions
│
│── guidelines/                 # Coding standards & best practices
│   ├── dart_style_guide.md     # Dart best practices & linting rules
│   ├── flutter_ui_guidelines.md# Flutter UI & component styling standards
│   ├── state_management.md     # Preferred state management techniques
│
│── tools/                      # Essential tools & extensions
│   ├── required_plugins.md     # VS Code & Android Studio plugins
│   ├── debugging_tools.md      # Overview of logging & debugging utilities
│   ├── testing_frameworks.md   # Unit & integration testing frameworks
│
│── access/                     # Repository & credentials setup
│   ├── github_access.md        # Requesting GitHub repo access
│   ├── firebase_project_setup.md # Gaining access to Firebase projects
│   ├── aws_credentials.md      # Setting up AWS credentials for cloud services
│
│── README.md                    # This document
```

## 🛠 Onboarding Steps
### **1️⃣ Setting Up Development Environment**
1. **Install Flutter & Dart** ([Official Flutter Guide](https://flutter.dev/docs/get-started/install))
2. **Set up your preferred IDE**
   - **VS Code** → Install recommended Flutter & Dart extensions.
   - **Android Studio** → Ensure Flutter plugin is installed.
3. **Clone the repository**
   ```bash
   git clone https://github.com/BrysonW24/Vivacity-Digital-Apps.git
   ```
4. **Install project dependencies**
   ```bash
   cd Vivacity-Digital-Apps
   flutter pub get
   ```
5. **Run a sample app**
   ```bash
   cd building-with-flutter/3-apps/flutter-counter-app
   flutter run
   ```

### **2️⃣ Coding Standards & Workflow**
- **Follow the Dart Style Guide** → Code must be properly formatted.
- **Use state management best practices** (Provider, Riverpod, Bloc, etc.).
- **Commit messages should be structured** (e.g., `feat: Added login functionality`).
- **Pull Request Process:**
  1. Create a feature branch (`feature/new-feature`).
  2. Write clean, structured code.
  3. Open a **pull request to the development branch**.
  4. Get code reviewed & approved.
  5. Merge to **main** when ready for production.

### **3️⃣ Essential Tools & Plugins**
- **VS Code Plugins** → Flutter, Dart, GitLens, Flutter Tree
- **Android Studio Plugins** → Flutter, Dart, Material Theme UI
- **Logging & Debugging** → DevTools, Flutter Inspector

### **4️⃣ Repository & Cloud Access**
- **GitHub** → Request repo access from the team.
- **Firebase** → Gain project access for analytics & authentication.
- **AWS/GCP/Azure** → If cloud services are required, request credentials.

## 🚀 Future Roadmap
- ✅ Provide **detailed onboarding guides for different roles**
- ✅ Define **coding standards & workflow best practices**
- 🔜 Automate **onboarding with setup scripts**
- 🔜 Improve **developer environment consistency**

## 📞 Need Help?
If you're stuck during onboarding, refer to this **README.md** or reach out to the development team.

🎯 **Get started smoothly & contribute effectively! 🚀🔥**

