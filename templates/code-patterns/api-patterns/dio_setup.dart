import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Dio HTTP Client Setup Template for Flutter Apps
/// This template provides a robust HTTP client configuration with:
/// - Automatic retry logic
/// - Request/response logging
/// - Authentication token management
/// - Error handling
/// - Timeout configuration

class DioClient {
  static const String _baseUrl = 'https://api.example.com'; // Replace with your API base URL
  static const Duration _connectTimeout = Duration(seconds: 30);
  static const Duration _receiveTimeout = Duration(seconds: 30);

  late final Dio _dio;

  DioClient() {
    _dio = Dio(_createBaseOptions());
    _setupInterceptors();
  }

  BaseOptions _createBaseOptions() {
    return BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      responseType: ResponseType.json,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }

  void _setupInterceptors() {
    // Request Interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add authentication token if available
          final token = await _getAuthToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          // Add request logging in debug mode
          if (kDebugMode) {
            print('🌐 REQUEST[${options.method}] => PATH: ${options.path}');
            print('Headers: ${options.headers}');
            if (options.data != null) {
              print('Data: ${options.data}');
            }
          }

          return handler.next(options);
        },

        onResponse: (response, handler) {
          // Add response logging in debug mode
          if (kDebugMode) {
            print('✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
            print('Data: ${response.data}');
          }

          return handler.next(response);
        },

        onError: (DioException error, handler) async {
          // Log error details
          if (kDebugMode) {
            print('❌ ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}');
            print('Error: ${error.message}');
            if (error.response?.data != null) {
              print('Response Data: ${error.response?.data}');
            }
          }

          // Handle specific error codes
          if (error.response?.statusCode == 401) {
            // Handle unauthorized - refresh token or logout
            await _handleUnauthorized();
          } else if (error.response?.statusCode == 403) {
            // Handle forbidden
            await _handleForbidden();
          } else if (error.response?.statusCode == 429) {
            // Handle rate limiting - implement retry with backoff
            return handler.resolve(await _retryRequest(error));
          }

          return handler.next(error);
        },
      ),
    );

    // Retry Interceptor for failed requests
    _dio.interceptors.add(
      RetryInterceptor(
        dio: _dio,
        options: const RetryOptions(
          retries: 3,
          retryInterval: Duration(seconds: 1),
        ),
      ),
    );
  }

  // Authentication token management
  Future<String?> _getAuthToken() async {
    // TODO: Implement token retrieval from secure storage
    // Example: return await SecureStorage.getToken();
    return null;
  }

  Future<void> _handleUnauthorized() async {
    // TODO: Implement token refresh or logout logic
    // Example: Navigate to login screen or refresh token
  }

  Future<void> _handleForbidden() async {
    // TODO: Handle forbidden access
    // Example: Show permission error dialog
  }

  Future<Response> _retryRequest(DioException error) async {
    // Implement exponential backoff retry logic
    await Future.delayed(const Duration(seconds: 2));
    return _dio.request(
      error.requestOptions.path,
      data: error.requestOptions.data,
      queryParameters: error.requestOptions.queryParameters,
      options: Options(
        method: error.requestOptions.method,
        headers: error.requestOptions.headers,
      ),
    );
  }

  // Generic HTTP methods
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> post(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.post(path, data: data, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> put(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.put(path, data: data, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> delete(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.delete(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // Error handling
  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException('Connection timeout. Please check your internet connection.');
      case DioExceptionType.badResponse:
        return HttpException('Server error: ${error.response?.statusCode}');
      case DioExceptionType.cancel:
        return RequestCancelledException('Request was cancelled');
      case DioExceptionType.unknown:
      default:
        return NetworkException('Network error occurred. Please try again.');
    }
  }

  // Get the Dio instance for advanced usage
  Dio get dio => _dio;
}

// Custom exception classes
class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);
  @override
  String toString() => message;
}

class HttpException implements Exception {
  final String message;
  HttpException(this.message);
  @override
  String toString() => message;
}

class RequestCancelledException implements Exception {
  final String message;
  RequestCancelledException(this.message);
  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
  @override
  String toString() => message;
}

// Retry Interceptor (requires dio_retry package)
class RetryInterceptor extends Interceptor {
  final Dio dio;
  final RetryOptions options;

  RetryInterceptor({required this.dio, required this.options});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      try {
        final response = await dio.request(
          err.requestOptions.path,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
          options: Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
          ),
        );
        return handler.resolve(response);
      } catch (e) {
        return handler.next(err);
      }
    }
    return handler.next(err);
  }

  bool _shouldRetry(DioException error) {
    return error.type == DioExceptionType.connectionTimeout ||
           error.type == DioExceptionType.receiveTimeout ||
           error.type == DioExceptionType.sendTimeout ||
           (error.response?.statusCode == 429) || // Rate limited
           (error.response?.statusCode == 500) || // Server error
           (error.response?.statusCode == 502) || // Bad gateway
           (error.response?.statusCode == 503) || // Service unavailable
           (error.response?.statusCode == 504);   // Gateway timeout
  }
}

class RetryOptions {
  final int retries;
  final Duration retryInterval;

  const RetryOptions({
    this.retries = 3,
    this.retryInterval = const Duration(seconds: 1),
  });
}

// Usage example:
/*
void main() async {
  final dioClient = DioClient();

  try {
    // GET request
    final response = await dioClient.get('/users');

    // POST request
    final newUser = await dioClient.post('/users', data: {
      'name': 'John Doe',
      'email': 'john@example.com',
    });

    // PUT request
    final updatedUser = await dioClient.put('/users/1', data: {
      'name': 'John Smith',
    });

    // DELETE request
    await dioClient.delete('/users/1');

  } catch (e) {
    print('API Error: $e');
  }
}
*/