# 🧱 Flutter Base Boilerplate (Tier 1)

Welcome to the **Vivacity Digital Apps Flutter Base Boilerplate**. This is a clean, scalable, and modular Flutter starter project to kick off production-grade cross-platform apps.

> **Tier 1** of the Vivacity multi-layer boilerplate system.

---

## 🌟 Purpose

This boilerplate is designed to:

- ✅ Rapidly scaffold frontend UI prototypes
- ✅ Serve as the foundation for advanced layers (auth, fullstack, etc.)
- ❌ Intentionally exclude auth/business logic/cloud to stay light

Ideal for:
- UI development & experimentation
- Dev onboarding & team consistency
- Foundation for tiered boilerplates (e.g., `2-flutter-auth-base`, `3-flutter-fullstack-base`)

---

## 🧠 Philosophy

- 📆 Clean separation of concerns
- 📁 Organized, layered folder structure
- 🫠 Stateless UI + simple app-wide state (Provider)
- 🌍 Platform-ready: Web, iOS, Android support
- ❌ No external dependencies or business logic included

---

## 📁 Folder Structure

```
1-flutter-base/
├── android/             # Native Android setup
├── ios/                 # Native iOS setup
├── web/                 # Web support
├── lib/
│   ├── assets/          # Fonts, icons, mock JSON data
│   ├── config/          # Themes, env, constants
│   ├── core/            # Dependency injection, core logic
│   ├── models/          # Base data models
│   ├── platform/        # Android/iOS platform utils
│   ├── providers/       # App-wide Provider state
│   ├── utils/           # Formatters, validators, logger
│   ├── views/           # UI screens: app/, extras/, home/
│   ├── widgets/         # Modular components: buttons, inputs, nav
│   └── main.dart        # App entry point
├── pubspec.yaml         # Project dependencies & config
└── README.md            # Project overview
```

---

## 🔄 What's Included

| Feature                                    | Status |
|-------------------------------------------|--------|
| 🔹 Clean folder structure             | ✅     |
| 🌟 Light/dark theme support           | ✅     |
| 🎨 Design system (buttons, inputs)     | ✅     |
| 🌐 Web/iOS/Android ready              | ✅     |
| 🧰 Provider state (theme, notification) | ✅     |
| 🔮 Mock data loader (offline testing)  | ✅     |
| 🎭 Typography & reusable widgets       | ✅     |
| 🔧 Indicators, dialogs, loaders       | ✅     |
| ⚖️ GitHub Actions CI-ready             | ✅     |

---

## ❌ What's Not Included (By Design)

| Feature                                   | Status |
|------------------------------------------|--------|
| 🔐 Auth (login, register, user state) | ❌     |
| ☁️ Cloud integrations (Firebase, Supabase) | ❌     |
| 🚧 Backend API logic / HTTP requests | ❌     |
| 💬 Push notifications, deep links     | ❌     |
| 🧠 State libs (Bloc, Riverpod, etc.)  | ❌     |

> For those, use `2-flutter-auth-base` and `3-flutter-fullstack-base`

---

## 🔄 Using Flutter Version Management (FVM)

**FVM** (Flutter Version Management) lets you lock your project to a specific Flutter version.

### 🔹 Why use it?
- Ensures every team member uses the same SDK version
- Prevents unexpected behavior from global SDK upgrades
- Lets you switch Flutter versions easily per project

### 🔧 Setup
```bash
# Install FVM
dart pub global activate fvm

# Add this to PATH if not already:
# Windows: C:\Users\<your-name>\AppData\Local\Pub\Cache\bin

# Then inside this project directory:
fvm use
```

### 🌎 Sample `.fvm/fvm_config.json`
```json
{
  "flutterSdkVersion": "3.19.3",
  "channel": "stable"
}
```

Use FVM-prefixed commands to run Flutter:
```bash
fvm flutter pub get
fvm flutter run
```

Add `.fvm/` to your `.gitignore` so you don't commit SDK binaries.

---

## 🪨 Widget Showcase

You can run the `WidgetShowcaseScreen` to view:

- Buttons
- Inputs & dropdowns
- Dialogs (loading, confirmation)
- Snackbars & toasts
- Loaders (circular, shimmer, animated dots)
- Typography components (heading, body, label)

> Useful when upgrading Flutter versions or testing themes

---

## ✏️ How to Use

```bash
flutter pub get
flutter run
```

To view all UI elements:
```dart
Navigator.push(context, MaterialPageRoute(builder: (_) => const WidgetShowcaseScreen()));
```

---

## 🔄 Suggested Maintenance

- 🚀 Add `.fvm/fvm_config.json` to pin Flutter SDK
- 📚 Add `CHANGELOG.md` to track updates
- 🔧 Add widget tests to `test/widget_showcase_test.dart`

---

## 🚀 Contribution Workflow

1. Create a branch: `feature/widget-name`
2. Add widget + showcase test
3. Update `README.md` if structure changes
4. PR to `main`

---

## 🔒 License

MIT License — Free to use, fork, extend
