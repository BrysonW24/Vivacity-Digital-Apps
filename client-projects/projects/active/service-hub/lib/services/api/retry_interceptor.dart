import 'package:dio/dio.dart';

/// Retry Interceptor
///
/// Automatically retries failed requests with exponential backoff.
class RetryInterceptor extends Interceptor {
  static const int _maxRetries = 3;
  static const int _initialDelayMs = 1000;

  final Map<RequestOptions, int> _requestRetries = {};

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final requestOptions = err.requestOptions;
    final retryCount = _requestRetries[requestOptions] ?? 0;

    // Only retry on timeout or connection errors
    if (retryCount < _maxRetries &&
        (err.type == DioExceptionType.connectionTimeout ||
            err.type == DioExceptionType.receiveTimeout ||
            (err.response?.statusCode ?? 500) >= 500)) {
      _requestRetries[requestOptions] = retryCount + 1;

      // Calculate backoff delay
      final delayMs = _initialDelayMs * (1 << retryCount); // exponential
      await Future.delayed(Duration(milliseconds: delayMs));

      try {
        final dio = Dio();
        final response = await dio.request(
          requestOptions.path,
          data: requestOptions.data,
          queryParameters: requestOptions.queryParameters,
          options: Options(
            method: requestOptions.method,
            sendTimeout: requestOptions.sendTimeout,
            receiveTimeout: requestOptions.receiveTimeout,
            headers: requestOptions.headers,
          ),
        );
        _requestRetries.remove(requestOptions);
        handler.resolve(response);
        return;
      } catch (e) {
        handler.next(err);
        return;
      }
    }

    _requestRetries.remove(requestOptions);
    handler.next(err);
  }
}
