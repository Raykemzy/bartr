import 'package:bartr/core/utils/enums.dart';
import 'package:json_annotation/json_annotation.dart';
part 'single_post_model.g.dart';

@JsonSerializable()
class SinglePost {
  SinglePost({
    this.id,
    this.user,
    this.title,
    this.description,
    this.category,
    this.location,
    this.status,
    this.visibility,
    this.expireDate,
    this.postType,
    this.likes,
    this.totalComments,
    this.likedBy,
    this.images,
    this.bids,
    // this.comments,
    this.createdAt,
    this.v,
  });
  @JsonKey(name: '_id')
  final String? id;
  final SinglePostUser? user;
  final String? title;
  final String? description;
  final String? category;
  final String? location;
  final String? status;
  final PostVisiblility? visibility;
  final DateTime? expireDate;
  final PostType? postType;
  final int? likes;

  final int? totalComments;
  final List<String>? likedBy;
  final List<String>? images;
  final List<dynamic>? bids;
  // final List<PostComment>? comments;
  final DateTime? createdAt;
  @JsonKey(name: "__v")
  final int? v;

  factory SinglePost.fromJson(Map<String, dynamic> json) =>
      _$SinglePostFromJson(json);
  Map<String, dynamic> toJson() => _$SinglePostToJson(this);
}

@JsonSerializable()
class PostComment {
  PostComment({
    this.comments,
    this.totalDocs,
    this.limit,
    this.totalPages,
    this.page,
    this.pagingCounter,
    this.hasPrevPage,
    this.hasNextPage,
    this.prevPage,
    this.nextPage,
  });

  @JsonKey(name: "docs")
  final List<SinglePostComment>? comments;
  final int? totalDocs;
  final int? limit;
  final int? totalPages;
  final dynamic page;
  final dynamic pagingCounter;
  final bool? hasPrevPage;
  final bool? hasNextPage;
  final dynamic prevPage;
  final dynamic nextPage;

  factory PostComment.fromJson(Map<String, dynamic> json) =>
      _$PostCommentFromJson(json);
  Map<String, dynamic> toJson() => _$PostCommentToJson(this);
}

@JsonSerializable()
class SinglePostComment {
  SinglePostComment({
    this.id,
    this.user,
    this.post,
    this.commentText,
    this.createdAt,
    this.v,
    this.likedBy,
  });

  @JsonKey(name: '_id')
  final String? id;
  final CommentUser? user;
  final String? post;
  final String? commentText;
  final List<String>? likedBy;
  final DateTime? createdAt;
  @JsonKey(name: "__v")
  final int? v;

  factory SinglePostComment.fromJson(Map<String, dynamic> json) =>
      _$SinglePostCommentFromJson(json);
  Map<String, dynamic> toJson() => _$SinglePostCommentToJson(this);
}

@JsonSerializable()
class CommentUser {
  CommentUser({
    this.id,
    this.fullName,
    this.username,
    this.country,
    this.profilePicture,
    this.createdAt,
    this.fcmPushToken,
  });
  @JsonKey(name: '_id')
  final String? id;

  final String? fullName;
  final String? username;
  final String? country;

  final String? profilePicture;
  final DateTime? createdAt;
  final String? fcmPushToken;

  factory CommentUser.fromJson(Map<String, dynamic> json) =>
      _$CommentUserFromJson(json);
  Map<String, dynamic> toJson() => _$CommentUserToJson(this);
}

@JsonSerializable()
class SinglePostUser {
  SinglePostUser({
    this.id,
    this.fullName,
    this.username,
    this.email,
    this.country,
    this.profilePicture,
    this.followers,
    this.createdAt,
    this.expoPushToken,
    this.fcmPushToken,
  });
  @JsonKey(name: '_id')
  final String? id;

  final String? fullName;
  final String? username;
  final String? email;
  final String? country;

  final String? profilePicture;
  final List<dynamic>? followers;
  final DateTime? createdAt;
  final String? expoPushToken;
  final String? fcmPushToken;

  factory SinglePostUser.fromJson(Map<String, dynamic> json) =>
      _$SinglePostUserFromJson(json);
  Map<String, dynamic> toJson() => _$SinglePostUserToJson(this);
}
