# iOS Standard Tier Template

## Overview
This is the standard tier template for iOS applications. It provides a full-featured structure for professional iOS apps with comprehensive testing and standard iOS development practices using SwiftUI and Combine.

## Purpose
- Production-ready iOS applications
- Apps with multiple views and complex UI
- Applications requiring data persistence and networking
- Projects needing comprehensive testing

## Features
- MVVM architecture pattern with SwiftUI
- Comprehensive testing (unit, integration, UI tests)
- Networking and data persistence layers
- SwiftUI components and design system
- Standard iOS development tools

## Structure
```
ios/standard/
├── App/
│   ├── Sources/       # Main source code (ViewModels, Models, Services)
│   ├── Resources/     # Assets, fonts, localization
│   ├── Tests/         # Unit tests
│   └── UITests/       # UI tests
├── Config/            # Application configuration
├── Tests/             # Additional test configurations
└── Docs/              # Documentation
```

## Usage
1. Copy this template to your iOS project directory
2. Configure your bundle identifier and app settings in `Config/`
3. Implement ViewModels and data layers in `App/Sources/`
4. Design SwiftUI views and components
5. Write unit tests in `App/Tests/`
6. Write UI tests in `App/UITests/`

## Architecture
- **View**: SwiftUI views for UI
- **ViewModel**: Business logic with ObservableObject
- **Repository**: Data access layer with Combine publishers
- **Model**: Data structures and entities

## Dependencies
- SwiftUI and Combine for reactive programming
- Networking libraries (Alamofire, URLSession+Combine)
- Persistence libraries (Core Data, Realm)
- Dependency injection (Swinject, Resolver)
- Testing frameworks (XCTest, ViewInspector)

## Testing
- Unit tests for business logic and ViewModels
- Integration tests for data layers and networking
- UI tests for user interactions and flows
- Snapshot testing for SwiftUI views

## Platform Support
- iOS 15.0+ (primary target)
- iPadOS support with adaptive layouts
- macOS support via Catalyst (optional)
- watchOS companion apps (optional)

## Customization
- Extend repository pattern for different data sources
- Add custom SwiftUI views and modifiers
- Configure theming and design system
- Integrate third-party SDKs

## Upgrade Path
For enterprise features and advanced analytics, consider the premium tier.