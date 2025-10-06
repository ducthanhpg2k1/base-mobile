import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/di/injection_container.dart';
import '../models/post_model.dart';

part 'post_repository.g.dart';

/// Repository for post operations
@riverpod
class PostRepository extends _$PostRepository {
  late final ApiClient _apiClient;
  
  @override
  Future<List<PostModel>> build() async {
    _apiClient = getIt<ApiClient>();
    return await getPosts();
  }
  
  /// Get all posts with pagination
  Future<List<PostModel>> getPosts({int page = 1, int limit = 20}) async {
    try {
      final posts = await _apiClient.getPosts(page: page, limit: limit);
      state = AsyncValue.data(posts);
      return posts;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }
  
  /// Get single post by ID
  Future<PostModel> getPost(int id) async {
    try {
      return await _apiClient.getPost(id);
    } catch (e) {
      rethrow;
    }
  }
  
  /// Create new post
  Future<PostModel> createPost(String title, String content, {String? image}) async {
    try {
      final newPost = await _apiClient.createPost({
        'title': title,
        'content': content,
        if (image != null) 'image': image,
      });
      
      // Add new post to current list
      final currentPosts = state.value ?? [];
      state = AsyncValue.data([newPost, ...currentPosts]);
      
      return newPost;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }
  
  /// Update existing post
  Future<PostModel> updatePost(int id, String title, String content, {String? image}) async {
    try {
      final updatedPost = await _apiClient.updatePost(id, {
        'title': title,
        'content': content,
        if (image != null) 'image': image,
      });
      
      // Update post in current list
      final currentPosts = state.value ?? [];
      final updatedPosts = currentPosts.map((post) {
        return post.id == id ? updatedPost : post;
      }).toList();
      state = AsyncValue.data(updatedPosts);
      
      return updatedPost;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }
  
  /// Delete post
  Future<void> deletePost(int id) async {
    try {
      await _apiClient.deletePost(id);
      
      // Remove post from current list
      final currentPosts = state.value ?? [];
      final filteredPosts = currentPosts.where((post) => post.id != id).toList();
      state = AsyncValue.data(filteredPosts);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }
  
  /// Refresh posts list
  Future<void> refreshPosts() async {
    state = const AsyncValue.loading();
    await getPosts();
  }
}
