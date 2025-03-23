## 🧪 Mock Data Strategy

This folder contains structured mock data files in `.json` format used to simulate real backend responses for UI prototyping and local testing.

### Why JSON?

- ✅ **Production-readiness**: Simulates real-world REST API or GraphQL responses
- ✅ **Separation of concerns**: Keeps UI logic and mock data cleanly decoupled
- ✅ **Reusable for testing**: Easily consumed in unit, widget, or integration tests
- ✅ **Swappable**: Allows switching between mock and real data sources without code changes
- ✅ **Scalable**: Add new mock datasets as the app grows (`products.json`, `categories.json`, etc.)

### Example Structure

```bash
lib/
└── assets/
    └── mock_data/
        ├── products.json
        ├── categories.json
        └── users.json (if needed in higher tiers)
```

## 📦 Why Mock Data is Stored in JSON (Not Dart)

In this boilerplate, mock data is stored in `.json` format rather than hardcoded Dart objects. This decision is intentional and aligns with how real-world apps are built and scaled.

Here’s why:

---

### ✅ 1. **Simulates Real-World APIs**

Most production applications fetch data from RESTful APIs or GraphQL — which return data in **JSON** format.

Using `.json` for mock data:
- Mimics how responses from APIs actually look
- Allows you to **build and test your `fromJson()` methods**
- Prepares the app for swapping in real backend calls later without rewriting the UI

---

### ✅ 2. **Keeps Code Clean and Decoupled**

Using JSON avoids cluttering your Dart files with long lists of mock objects. Instead, you:

- Keep your data and logic separate
- Focus Dart files on UI, business logic, and model definitions
- Update mock data without touching your codebase

This follows **clean architecture** and separation of concerns principles.

---

### ✅ 3. **More Scalable for Teams and Tests**

When your app grows, it’s easier to:

- Maintain mock data in versioned JSON files
- Create multiple datasets (`products_v1.json`, `test_users.json`, etc.)
- Run unit or integration tests using pre-loaded fixtures

It also makes it easy to generate mock data with tools or download real data as test samples.

---

### ✅ 4. **Easier to Swap with Live Data**

By matching the structure of API responses, you can transition to real API calls later by simply replacing:

```dart
final jsonString = await rootBundle.loadString('lib/assets/mock_data/products.json');
