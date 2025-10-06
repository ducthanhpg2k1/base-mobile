import 'package:dio/dio.dart';
import '../../utils/logger.dart';

/// Interceptor for logging HTTP requests and responses
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.info('🚀 REQUEST[${options.method}] => PATH: ${options.path}');
    AppLogger.debug('Headers: ${options.headers}');
    if (options.data != null) {
      AppLogger.debug('Data: ${options.data}');
    }
    if (options.queryParameters.isNotEmpty) {
      AppLogger.debug('Query Parameters: ${options.queryParameters}');
    }
    
    super.onRequest(options, handler);
  }
  
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.info('✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    AppLogger.debug('Data: ${response.data}');
    
    super.onResponse(response, handler);
  }
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.error(
      '❌ ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
      err,
      err.stackTrace,
    );
    
    if (err.response?.data != null) {
      AppLogger.debug('Error Data: ${err.response?.data}');
    }
    
    super.onError(err, handler);
  }
}
