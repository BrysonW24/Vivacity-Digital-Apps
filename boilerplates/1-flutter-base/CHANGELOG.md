# 📦 Flutter Base Boilerplate — CHANGELOG

## v1.0.0 - 2024-03-23

- Initial release with Flutter 3.19.3
- Uses Material 3 text styles (`titleLarge`, `bodyMedium`, etc.)
- Modular folder structure: widgets, services, views

This file tracks all major updates, enhancements, and breaking changes made to the **1-flutter-base** boilerplate.

---

## [1.0.0] - 2025-03-23

### 🚀 Initial Stable Release
- 🎯 Modular folder structure for scalable Flutter apps
- 🎨 Theme switching support (Material 3)
- 🧱 Reusable widgets: buttons, inputs, indicators, typography
- 📱 Multi-platform ready: Web, Android, iOS
- 🧩 Provider for basic app state management
- 🧪 Mock JSON data loading (products, categories)
- 🧰 Core utils: formatters, validators, logger
- 💬 Basic screen layout with home, settings, profile, notifications, FAQ
- 🛠 Platform utilities for iOS & Android (permissions, notifications)
- 🧪 `WidgetShowcaseScreen` for UI validation

### ⚙️ Tooling & Config
- ✅ `pubspec.yaml` configured with Dart >=3.0.0 <4.0.0
- ✅ `.gitignore`, `README.md`, and `analysis_options.yaml` prefilled
- ✅ `fvm_config.json` supported (optional)
- ✅ Compatible with Flutter 3.19.3

---

## 🔮 Upcoming
- [ ] Add language switching support (i18n-ready)
- [ ] Integrate golden tests for visual regression
- [ ] Optional onboarding flow (with animation)
- [ ] Extend widget showcase to support themes

---

## 🛠 Migration Notes
- If upgrading from older boilerplates, replace deprecated styles (`headline6` → `titleLarge`)
- Add missing Material 3 fields in `theme.dart` if updating to newer SDKs
