import 'package:dio/dio.dart';
import '../../storage/local_storage_service.dart';
import '../../config/app_config.dart';

/// Interceptor to handle authentication tokens
class AuthInterceptor extends Interceptor {
  final LocalStorageService _localStorage;
  
  AuthInterceptor(this._localStorage);
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add authorization header if token exists
    final token = _localStorage.getString(AppConfig.userTokenKey);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    
    super.onRequest(options, handler);
  }
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle 401 Unauthorized errors
    if (err.response?.statusCode == 401) {
      // Clear stored token
      await _localStorage.remove(AppConfig.userTokenKey);
      await _localStorage.remove(AppConfig.userDataKey);
      
      // You can add logic to redirect to login page here
      // For now, we'll just pass the error through
    }
    
    super.onError(err, handler);
  }
}
