/// Generic API response wrapper
/// Used to wrap all API responses for consistent error handling and type safety

class ApiResponse<T> {
  final T? data;
  final String? message;
  final bool success;
  final int? statusCode;
  final dynamic error;
  final String? errorCode;

  ApiResponse({
    this.data,
    this.message,
    required this.success,
    this.statusCode,
    this.error,
    this.errorCode,
  });

  /// Success factory constructor
  factory ApiResponse.success(
    T data, {
    String? message,
    int? statusCode,
  }) {
    return ApiResponse(
      data: data,
      message: message ?? 'Success',
      success: true,
      statusCode: statusCode ?? 200,
    );
  }

  /// Error factory constructor
  factory ApiResponse.error(
    dynamic error, {
    String? message,
    int? statusCode,
    String? errorCode,
  }) {
    return ApiResponse(
      message: message ?? 'Error',
      success: false,
      statusCode: statusCode ?? 500,
      error: error,
      errorCode: errorCode,
    );
  }

  /// Loading state factory
  factory ApiResponse.loading() {
    return ApiResponse(
      message: 'Loading',
      success: false,
      statusCode: null,
    );
  }

  // Getters for convenience
  bool get isSuccess => success && data != null;
  bool get isError => !success;
  bool get hasData => data != null;
  bool get isLoading => message == 'Loading' && !success;
}
