# Try-Catch Best Practices in Dart & Flutter

## Overview

Proper error handling is crucial for creating robust Flutter applications. This guide covers try-catch patterns, exception handling, and best practices for Dart and Flutter.

## Basic Try-Catch

### Simple Try-Catch

```dart
void example() {
  try {
    // Code that might throw
    int result = int.parse('not a number');
  } catch (e) {
    // Handle the error
    print('Error: $e');
  }
}
```

### With Stack Trace

```dart
void example() {
  try {
    int result = int.parse('not a number');
  } catch (e, stackTrace) {
    print('Error: $e');
    print('Stack trace: $stackTrace');
  }
}
```

### Finally Block

```dart
void example() {
  try {
    // Open a resource
    final file = File('data.txt');
    final contents = file.readAsStringSync();
  } catch (e) {
    print('Error reading file: $e');
  } finally {
    // Always executes, even if there's an error or return
    print('Cleanup complete');
  }
}
```

## Catching Specific Exceptions

### Single Exception Type

```dart
void example() {
  try {
    int.parse('not a number');
  } on FormatException catch (e) {
    print('Invalid format: $e');
  }
}
```

### Multiple Exception Types

```dart
Future<void> fetchData() async {
  try {
    final response = await http.get(url);
    final data = jsonDecode(response.body);
  } on SocketException catch (e, stack) {
    // Network error
    print('No internet connection');
  } on HttpException catch (e, stack) {
    // HTTP error
    print('HTTP error: ${e.message}');
  } on FormatException catch (e, stack) {
    // JSON parsing error
    print('Invalid JSON format');
  } catch (e, stack) {
    // Catch all other exceptions
    print('Unknown error: $e');
  }
}
```

### Catch Order Matters

```dart
// ❌ WRONG: Generic catch first
try {
  // Code
} catch (e) {
  // This catches everything
} on FormatException catch (e) {
  // Never reached!
}

// ✅ CORRECT: Specific catches first
try {
  // Code
} on FormatException catch (e) {
  // Handles format exceptions
} on TypeError catch (e) {
  // Handles type errors
} catch (e) {
  // Catches everything else
}
```

## Async Error Handling

### Basic Async Try-Catch

```dart
Future<void> fetchUserData() async {
  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw HttpException('Failed: ${response.statusCode}');
    }
  } catch (e, stack) {
    print('Error fetching data: $e');
    rethrow;  // Re-throw to let caller handle it
  }
}
```

### Multiple Async Operations

```dart
Future<void> loadAllData() async {
  try {
    // Sequential operations
    final user = await fetchUser();
    final profile = await fetchProfile(user.id);
    final posts = await fetchPosts(user.id);

    print('Loaded all data successfully');
  } catch (e, stack) {
    print('Error in data loading pipeline: $e');
  }
}
```

### Parallel Async Operations

```dart
Future<void> loadDataParallel() async {
  try {
    // Run multiple futures in parallel
    final results = await Future.wait([
      fetchUser(),
      fetchProfile(),
      fetchPosts(),
    ]);

    final user = results[0];
    final profile = results[1];
    final posts = results[2];

    print('All data loaded');
  } catch (e, stack) {
    // Any failure will trigger this catch
    print('Error loading data: $e');
  }
}
```

### Handling Individual Errors in Parallel

```dart
Future<void> loadWithIndividualHandling() async {
  final results = await Future.wait([
    fetchUser().catchError((e) {
      print('User fetch failed: $e');
      return null;  // Return default value
    }),
    fetchProfile().catchError((e) {
      print('Profile fetch failed: $e');
      return null;
    }),
    fetchPosts().catchError((e) {
      print('Posts fetch failed: $e');
      return [];  // Return empty list
    }),
  ]);

  final user = results[0];
  final profile = results[1];
  final posts = results[2];

  // Continue with available data
}
```

## Stream Error Handling

### Basic Stream Error Handling

```dart
void listenToStream() {
  final stream = dataStream();

  stream.listen(
    (data) {
      // Handle data
      print('Received: $data');
    },
    onError: (error, stackTrace) {
      // Handle error
      print('Stream error: $error');
    },
    onDone: () {
      // Stream completed
      print('Stream closed');
    },
    cancelOnError: false,  // Continue listening after error
  );
}
```

### Handling Stream Errors with Try-Catch

```dart
Future<void> processStream() async {
  try {
    await for (final data in dataStream()) {
      // Process each item
      await processData(data);
    }
  } catch (e, stack) {
    print('Error processing stream: $e');
  }
}
```

### Transform Stream to Handle Errors

```dart
Stream<int> safeStream() {
  return riskyStream().handleError((error) {
    print('Error in stream: $error');
    // Error is consumed, stream continues
  });
}
```

## Flutter-Specific Patterns

### setState Error Handling

```dart
class _MyWidgetState extends State<MyWidget> {
  Future<void> loadData() async {
    try {
      final data = await fetchData();

      if (mounted) {  // Check widget is still in tree
        setState(() {
          _data = data;
        });
      }
    } catch (e, stack) {
      if (mounted) {
        setState(() {
          _error = e.toString();
        });
      }
    }
  }
}
```

### FutureBuilder Error Handling

```dart
FutureBuilder<User>(
  future: fetchUser(),
  builder: (context, snapshot) {
    if (snapshot.hasError) {
      // Handle error
      return ErrorWidget(error: snapshot.error);
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }

    if (snapshot.hasData) {
      return UserProfile(user: snapshot.data!);
    }

    return Text('No data');
  },
)
```

### StreamBuilder Error Handling

```dart
StreamBuilder<Message>(
  stream: messageStream,
  builder: (context, snapshot) {
    if (snapshot.hasError) {
      return ErrorBanner(
        message: 'Error: ${snapshot.error}',
        onRetry: () {
          // Retry logic
        },
      );
    }

    if (!snapshot.hasData) {
      return CircularProgressIndicator();
    }

    return MessageList(messages: snapshot.data!);
  },
)
```

## Custom Exceptions

### Define Custom Exceptions

```dart
class NetworkException implements Exception {
  final String message;
  final int? statusCode;

  NetworkException(this.message, [this.statusCode]);

  @override
  String toString() => 'NetworkException: $message (status: $statusCode)';
}

class CacheException implements Exception {
  final String message;

  CacheException(this.message);

  @override
  String toString() => 'CacheException: $message';
}

class ValidationException implements Exception {
  final Map<String, String> errors;

  ValidationException(this.errors);

  @override
  String toString() => 'ValidationException: ${errors.entries.map((e) => '${e.key}: ${e.value}').join(', ')}';
}
```

### Using Custom Exceptions

```dart
class DataRepository {
  Future<List<Item>> fetchItems() async {
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return parseItems(response.body);
      } else if (response.statusCode == 404) {
        throw NetworkException('Items not found', 404);
      } else {
        throw NetworkException('Server error', response.statusCode);
      }
    } on SocketException {
      throw NetworkException('No internet connection');
    } on FormatException {
      throw CacheException('Invalid data format');
    }
  }

  void validateItem(Item item) {
    final errors = <String, String>{};

    if (item.name.isEmpty) {
      errors['name'] = 'Name is required';
    }
    if (item.price < 0) {
      errors['price'] = 'Price must be positive';
    }

    if (errors.isNotEmpty) {
      throw ValidationException(errors);
    }
  }
}
```

### Handling Custom Exceptions

```dart
Future<void> loadItems() async {
  try {
    final items = await repository.fetchItems();
    setState(() => _items = items);
  } on NetworkException catch (e) {
    showErrorDialog('Network Error', e.message);
  } on CacheException catch (e) {
    showErrorDialog('Cache Error', e.message);
  } on ValidationException catch (e) {
    showValidationErrors(e.errors);
  } catch (e) {
    showErrorDialog('Unknown Error', e.toString());
  }
}
```

## Result Pattern (No Exceptions)

### Define Result Type

```dart
class Result<T> {
  final T? data;
  final Exception? error;

  Result.success(this.data) : error = null;
  Result.failure(this.error) : data = null;

  bool get isSuccess => error == null;
  bool get isFailure => error != null;
}
```

### Using Result Pattern

```dart
class DataRepository {
  Future<Result<List<Item>>> fetchItems() async {
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final items = parseItems(response.body);
        return Result.success(items);
      } else {
        return Result.failure(
          NetworkException('Failed', response.statusCode),
        );
      }
    } catch (e) {
      return Result.failure(Exception(e.toString()));
    }
  }
}

// Usage
Future<void> loadItems() async {
  final result = await repository.fetchItems();

  if (result.isSuccess) {
    setState(() => _items = result.data!);
  } else {
    showError(result.error!.toString());
  }
}
```

## Best Practices

### 1. Be Specific with Catches

```dart
// ❌ BAD: Generic catch-all
try {
  await operation();
} catch (e) {
  print('Error: $e');
}

// ✅ GOOD: Specific exception handling
try {
  await operation();
} on NetworkException catch (e) {
  showNetworkError();
} on ValidationException catch (e) {
  showValidationErrors(e.errors);
} on UnauthorizedException catch (e) {
  logout();
} catch (e, stack) {
  logger.error('Unexpected error', e, stack);
  showGenericError();
}
```

### 2. Always Include Stack Traces in Logs

```dart
// ❌ BAD: No stack trace
try {
  await operation();
} catch (e) {
  print('Error: $e');
}

// ✅ GOOD: Include stack trace
try {
  await operation();
} catch (e, stackTrace) {
  logger.error('Operation failed', error: e, stackTrace: stackTrace);
}
```

### 3. Don't Swallow Exceptions Silently

```dart
// ❌ BAD: Silent failure
try {
  await riskyOperation();
} catch (e) {
  // Nothing here - error is lost!
}

// ✅ GOOD: Log or handle appropriately
try {
  await riskyOperation();
} catch (e, stack) {
  logger.warning('Risky operation failed', error: e, stackTrace: stack);
  // Optionally rethrow or use default value
}
```

### 4. Rethrow When Appropriate

```dart
// Use 'rethrow' to preserve stack trace
Future<User> fetchUser() async {
  try {
    final response = await http.get(url);
    return User.fromJson(response.body);
  } catch (e, stack) {
    logger.error('Failed to fetch user', error: e, stackTrace: stack);
    rethrow;  // Let caller decide how to handle
  }
}
```

### 5. Provide Context in Errors

```dart
class UserService {
  Future<User> getUser(String userId) async {
    try {
      return await repository.fetchUser(userId);
    } catch (e, stack) {
      throw Exception('Failed to get user $userId: $e');
    }
  }
}
```

### 6. Use Finally for Cleanup

```dart
Future<void> processFile() async {
  File? file;

  try {
    file = File('data.txt');
    final contents = await file.readAsString();
    await process(contents);
  } catch (e) {
    print('Error: $e');
  } finally {
    // Cleanup always happens
    await file?.delete();
  }
}
```

### 7. Validate Early

```dart
// ✅ GOOD: Validate before processing
Future<void> saveUser(User user) async {
  // Validate first
  if (user.email.isEmpty) {
    throw ValidationException({'email': 'Email is required'});
  }

  if (!user.email.contains('@')) {
    throw ValidationException({'email': 'Invalid email format'});
  }

  // Only proceed if valid
  try {
    await repository.save(user);
  } catch (e, stack) {
    logger.error('Failed to save user', error: e, stackTrace: stack);
    rethrow;
  }
}
```

## Common Pitfalls

### 1. Catching Too Broadly

```dart
// ❌ BAD
try {
  await complexOperation();
} catch (e) {
  // Can't determine what went wrong
  showError('Something failed');
}

// ✅ GOOD
try {
  await complexOperation();
} on NetworkException {
  showError('Check your connection');
} on DatabaseException {
  showError('Data error');
} on ValidationException {
  showError('Invalid input');
}
```

### 2. Not Handling Async Errors

```dart
// ❌ BAD: Unawaited future
void badExample() {
  fetchData();  // Fire and forget - errors are lost!
}

// ✅ GOOD: Await and handle
Future<void> goodExample() async {
  try {
    await fetchData();
  } catch (e) {
    handleError(e);
  }
}

// ✅ ALSO GOOD: Explicit error handling
void alternativeGoodExample() {
  fetchData().catchError((e) {
    handleError(e);
  });
}
```

### 3. Modifying State After Dispose

```dart
// ❌ BAD
class _MyWidgetState extends State<MyWidget> {
  Future<void> loadData() async {
    final data = await fetchData();
    setState(() => _data = data);  // Might crash if widget disposed
  }
}

// ✅ GOOD
class _MyWidgetState extends State<MyWidget> {
  Future<void> loadData() async {
    try {
      final data = await fetchData();
      if (mounted) {  // Check first!
        setState(() => _data = data);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _error = e.toString());
      }
    }
  }
}
```

## Quick Reference

```dart
// Basic try-catch
try {
  // code
} catch (e, stack) {
  // handle
}

// Specific exception
try {
  // code
} on SpecificException catch (e) {
  // handle specific
} catch (e) {
  // handle others
}

// With finally
try {
  // code
} catch (e) {
  // handle
} finally {
  // cleanup
}

// Rethrow
try {
  // code
} catch (e, stack) {
  log(e, stack);
  rethrow;
}

// Async
try {
  await future;
} catch (e) {
  // handle
}

// Check mounted
if (mounted) {
  setState(() {});
}
```

---

**Resources:**
- [Dart Exception Handling](https://dart.dev/guides/language/language-tour#exceptions)
- [Flutter Error Handling](https://docs.flutter.dev/testing/errors)
- [Effective Dart: Error Handling](https://dart.dev/guides/language/effective-dart/usage#do-use-rethrow-to-rethrow-a-caught-exception)
