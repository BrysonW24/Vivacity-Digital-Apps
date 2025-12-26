import 'package:dio/dio.dart';

/// Logging Interceptor
///
/// Logs all HTTP requests and responses for debugging.
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print(
      '╔════════════════════════════════════════════════════════════════');
    print('║ [REQUEST] ${options.method} ${options.path}');
    print('║ Headers: ${options.headers}');
    if (options.data != null) {
      print('║ Body: ${options.data}');
    }
    print(
      '╚════════════════════════════════════════════════════════════════');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      '╔════════════════════════════════════════════════════════════════');
    print('║ [RESPONSE] ${response.statusCode} ${response.requestOptions.path}');
    print('║ Headers: ${response.headers}');
    print('║ Body: ${response.data}');
    print(
      '╚════════════════════════════════════════════════════════════════');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print(
      '╔════════════════════════════════════════════════════════════════');
    print('║ [ERROR] ${err.response?.statusCode} ${err.requestOptions.path}');
    print('║ Message: ${err.message}');
    if (err.response != null) {
      print('║ Body: ${err.response?.data}');
    }
    print(
      '╚════════════════════════════════════════════════════════════════');
    handler.next(err);
  }
}
