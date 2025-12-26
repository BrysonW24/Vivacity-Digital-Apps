import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/app_config.dart';

/// HTTP API client for making requests to the backend
/// Handles authentication, error handling, and request/response logging
class ApiClient {
  late http.Client _httpClient;

  ApiClient({http.Client? httpClient}) {
    _httpClient = httpClient ?? http.Client();
  }

  /// Make a GET request
  Future<dynamic> get(String endpoint) async {
    try {
      final url = Uri.parse(AppConfig.getApiUrl(endpoint));
      final response = await _httpClient.get(url).timeout(
        Duration(seconds: AppConfig.apiTimeoutSeconds),
        onTimeout: () => throw TimeoutException('Request timeout'),
      );

      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  /// Make a POST request
  Future<dynamic> post(String endpoint, {required dynamic body}) async {
    try {
      final url = Uri.parse(AppConfig.getApiUrl(endpoint));
      final response = await _httpClient.post(
        url,
        headers: _getHeaders(),
        body: jsonEncode(body),
      ).timeout(
        Duration(seconds: AppConfig.apiTimeoutSeconds),
        onTimeout: () => throw TimeoutException('Request timeout'),
      );

      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  /// Make a PUT request
  Future<dynamic> put(String endpoint, {required dynamic body}) async {
    try {
      final url = Uri.parse(AppConfig.getApiUrl(endpoint));
      final response = await _httpClient.put(
        url,
        headers: _getHeaders(),
        body: jsonEncode(body),
      ).timeout(
        Duration(seconds: AppConfig.apiTimeoutSeconds),
        onTimeout: () => throw TimeoutException('Request timeout'),
      );

      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  /// Make a DELETE request
  Future<dynamic> delete(String endpoint) async {
    try {
      final url = Uri.parse(AppConfig.getApiUrl(endpoint));
      final response = await _httpClient.delete(url).timeout(
        Duration(seconds: AppConfig.apiTimeoutSeconds),
        onTimeout: () => throw TimeoutException('Request timeout'),
      );

      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  /// Get default headers for requests
  Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // Add authorization header if needed:
      // 'Authorization': 'Bearer $token',
    };
  }

  /// Handle HTTP response and throw errors if needed
  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Success response
      if (response.body.isEmpty) return null;
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      // Unauthorized - handle logout/token refresh
      throw UnauthorizedException('Unauthorized');
    } else if (response.statusCode == 403) {
      throw ForbiddenException('Access forbidden');
    } else if (response.statusCode == 404) {
      throw NotFoundException('Resource not found');
    } else if (response.statusCode == 500) {
      throw ServerException('Server error');
    } else {
      throw ApiException('HTTP ${response.statusCode}: ${response.body}');
    }
  }

  void dispose() {
    _httpClient.close();
  }
}

// Custom exceptions
class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}

class TimeoutException extends ApiException {
  TimeoutException(String message) : super(message);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(String message) : super(message);
}

class ForbiddenException extends ApiException {
  ForbiddenException(String message) : super(message);
}

class NotFoundException extends ApiException {
  NotFoundException(String message) : super(message);
}

class ServerException extends ApiException {
  ServerException(String message) : super(message);
}
