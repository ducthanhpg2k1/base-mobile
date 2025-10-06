import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../config/app_config.dart';
import '../../features/auth/data/models/user_model.dart';
import '../../features/home/data/models/post_model.dart';

part 'api_client.g.dart';

/// Main API client using Retrofit and Dio
@RestApi(baseUrl: AppConfig.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;
  
  // Auth endpoints
  @POST('/auth/login')
  Future<UserModel> login(@Body() Map<String, dynamic> loginData);
  
  @POST('/auth/register')
  Future<UserModel> register(@Body() Map<String, dynamic> registerData);
  
  @POST('/auth/refresh')
  Future<Map<String, dynamic>> refreshToken(@Body() Map<String, dynamic> refreshData);
  
  @POST('/auth/logout')
  Future<void> logout();
  
  // User endpoints
  @GET('/user/profile')
  Future<UserModel> getUserProfile();
  
  @PUT('/user/profile')
  Future<UserModel> updateUserProfile(@Body() Map<String, dynamic> userData);
  
  // Posts endpoints
  @GET('/posts')
  Future<List<PostModel>> getPosts({
    @Query('page') int page = 1,
    @Query('limit') int limit = AppConfig.defaultPageSize,
  });
  
  @GET('/posts/{id}')
  Future<PostModel> getPost(@Path('id') int id);
  
  @POST('/posts')
  Future<PostModel> createPost(@Body() Map<String, dynamic> postData);
  
  @PUT('/posts/{id}')
  Future<PostModel> updatePost(@Path('id') int id, @Body() Map<String, dynamic> postData);
  
  @DELETE('/posts/{id}')
  Future<void> deletePost(@Path('id') int id);
}
