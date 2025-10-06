import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/storage/local_storage_service.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/di/injection_container.dart';
import '../models/user_model.dart';

part 'auth_repository.g.dart';

/// Repository for authentication operations
@riverpod
class AuthRepository extends _$AuthRepository {
  late final ApiClient _apiClient;
  late final LocalStorageService _localStorage;
  
  @override
  Future<UserModel?> build() async {
    _apiClient = getIt<ApiClient>();
    _localStorage = getIt<LocalStorageService>();
    
    // Return current user if logged in
    return await getCurrentUser();
  }
  
  /// Login with email and password
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _apiClient.login({
        'email': email,
        'password': password,
      });
      
      // Store user data and token
      await _localStorage.setJson(AppConfig.userDataKey, response.toJson());
      await _localStorage.setString(AppConfig.userTokenKey, 'dummy_token_${response.id}');
      
      state = AsyncValue.data(response);
      return response;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }
  
  /// Register new user
  Future<UserModel> register(String name, String email, String password) async {
    try {
      final response = await _apiClient.register({
        'name': name,
        'email': email,
        'password': password,
      });
      
      // Store user data and token
      await _localStorage.setJson(AppConfig.userDataKey, response.toJson());
      await _localStorage.setString(AppConfig.userTokenKey, 'dummy_token_${response.id}');
      
      state = AsyncValue.data(response);
      return response;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }
  
  /// Logout current user
  Future<void> logout() async {
    try {
      await _apiClient.logout();
    } catch (e) {
      // Continue with logout even if API call fails
    } finally {
      // Clear stored data
      await _localStorage.remove(AppConfig.userTokenKey);
      await _localStorage.remove(AppConfig.userDataKey);
      state = const AsyncValue.data(null);
    }
  }
  
  /// Get current user from storage
  Future<UserModel?> getCurrentUser() async {
    final userData = _localStorage.getJson(AppConfig.userDataKey);
    if (userData != null) {
      return UserModel.fromJson(userData);
    }
    return null;
  }
  
  /// Check if user is logged in
  bool get isLoggedIn {
    final token = _localStorage.getString(AppConfig.userTokenKey);
    return token != null && token.isNotEmpty;
  }
  
  /// Update user profile
  Future<UserModel> updateProfile(Map<String, dynamic> userData) async {
    try {
      final response = await _apiClient.updateUserProfile(userData);
      
      // Update stored user data
      await _localStorage.setJson(AppConfig.userDataKey, response.toJson());
      state = AsyncValue.data(response);
      
      return response;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }
}
