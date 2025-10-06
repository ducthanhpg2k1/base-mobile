import 'package:json_annotation/json_annotation.dart';
import '../../../auth/data/models/user_model.dart';

part 'post_model.g.dart';

/// Post model class with JSON serialization
@JsonSerializable()
class PostModel {
  final int id;
  final String title;
  final String content;
  final String? image;
  @JsonKey(fromJson: _userFromJson, toJson: _userToJson)
  final UserModel author;
  @JsonKey(name: 'likes_count')
  final int likesCount;
  @JsonKey(name: 'comments_count')
  final int commentsCount;
  @JsonKey(name: 'is_liked')
  final bool isLiked;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  
  const PostModel({
    required this.id,
    required this.title,
    required this.content,
    this.image,
    required this.author,
    required this.likesCount,
    required this.commentsCount,
    required this.isLiked,
    required this.createdAt,
    required this.updatedAt,
  });
  
  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostModelToJson(this);
  
  PostModel copyWith({
    int? id,
    String? title,
    String? content,
    String? image,
    UserModel? author,
    int? likesCount,
    int? commentsCount,
    bool? isLiked,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PostModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      image: image ?? this.image,
      author: author ?? this.author,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      isLiked: isLiked ?? this.isLiked,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PostModel && other.id == id;
  }
  
  @override
  int get hashCode => id.hashCode;
  
  @override
  String toString() {
    return 'PostModel(id: $id, title: $title, author: ${author.name})';
  }
  
  // Helper methods for JSON serialization
  static UserModel _userFromJson(Map<String, dynamic> json) => UserModel.fromJson(json);
  static Map<String, dynamic> _userToJson(UserModel user) => user.toJson();
}
