// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SinglePost _$SinglePostFromJson(Map<String, dynamic> json) => SinglePost(
      id: json['_id'] as String?,
      user: json['user'] == null
          ? null
          : SinglePostUser.fromJson(json['user'] as Map<String, dynamic>),
      title: json['title'] as String?,
      description: json['description'] as String?,
      category: json['category'] as String?,
      location: json['location'] as String?,
      status: json['status'] as String?,
      visibility:
          $enumDecodeNullable(_$PostVisiblilityEnumMap, json['visibility']),
      expireDate: json['expireDate'] == null
          ? null
          : DateTime.parse(json['expireDate'] as String),
      postType: $enumDecodeNullable(_$PostTypeEnumMap, json['postType']),
      likes: json['likes'] as int?,
      totalComments: json['totalComments'] as int?,
      likedBy:
          (json['likedBy'] as List<dynamic>?)?.map((e) => e as String).toList(),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      bids: json['bids'] as List<dynamic>?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      v: json['__v'] as int?,
    );

Map<String, dynamic> _$SinglePostToJson(SinglePost instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'location': instance.location,
      'status': instance.status,
      'visibility': _$PostVisiblilityEnumMap[instance.visibility],
      'expireDate': instance.expireDate?.toIso8601String(),
      'postType': _$PostTypeEnumMap[instance.postType],
      'likes': instance.likes,
      'totalComments': instance.totalComments,
      'likedBy': instance.likedBy,
      'images': instance.images,
      'bids': instance.bids,
      'createdAt': instance.createdAt?.toIso8601String(),
      '__v': instance.v,
    };

const _$PostVisiblilityEnumMap = {
  PostVisiblility.Private: 'Private',
  PostVisiblility.Public: 'Public',
};

const _$PostTypeEnumMap = {
  PostType.Barter: 'Barter',
  PostType.Giveaway: 'Giveaway',
};

PostComment _$PostCommentFromJson(Map<String, dynamic> json) => PostComment(
      comments: (json['docs'] as List<dynamic>?)
          ?.map((e) => SinglePostComment.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDocs: json['totalDocs'] as int?,
      limit: json['limit'] as int?,
      totalPages: json['totalPages'] as int?,
      page: json['page'],
      pagingCounter: json['pagingCounter'],
      hasPrevPage: json['hasPrevPage'] as bool?,
      hasNextPage: json['hasNextPage'] as bool?,
      prevPage: json['prevPage'],
      nextPage: json['nextPage'],
    );

Map<String, dynamic> _$PostCommentToJson(PostComment instance) =>
    <String, dynamic>{
      'docs': instance.comments,
      'totalDocs': instance.totalDocs,
      'limit': instance.limit,
      'totalPages': instance.totalPages,
      'page': instance.page,
      'pagingCounter': instance.pagingCounter,
      'hasPrevPage': instance.hasPrevPage,
      'hasNextPage': instance.hasNextPage,
      'prevPage': instance.prevPage,
      'nextPage': instance.nextPage,
    };

SinglePostComment _$SinglePostCommentFromJson(Map<String, dynamic> json) =>
    SinglePostComment(
      id: json['_id'] as String?,
      user: json['user'] == null
          ? null
          : CommentUser.fromJson(json['user'] as Map<String, dynamic>),
      post: json['post'] as String?,
      commentText: json['commentText'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      v: json['__v'] as int?,
      likedBy:
          (json['likedBy'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SinglePostCommentToJson(SinglePostComment instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'post': instance.post,
      'commentText': instance.commentText,
      'likedBy': instance.likedBy,
      'createdAt': instance.createdAt?.toIso8601String(),
      '__v': instance.v,
    };

CommentUser _$CommentUserFromJson(Map<String, dynamic> json) => CommentUser(
      id: json['_id'] as String?,
      fullName: json['fullName'] as String?,
      username: json['username'] as String?,
      country: json['country'] as String?,
      profilePicture: json['profilePicture'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      fcmPushToken: json['fcmPushToken'] as String?,
    );

Map<String, dynamic> _$CommentUserToJson(CommentUser instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fullName': instance.fullName,
      'username': instance.username,
      'country': instance.country,
      'profilePicture': instance.profilePicture,
      'createdAt': instance.createdAt?.toIso8601String(),
      'fcmPushToken': instance.fcmPushToken,
    };

SinglePostUser _$SinglePostUserFromJson(Map<String, dynamic> json) =>
    SinglePostUser(
      id: json['_id'] as String?,
      fullName: json['fullName'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      country: json['country'] as String?,
      profilePicture: json['profilePicture'] as String?,
      followers: json['followers'] as List<dynamic>?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      expoPushToken: json['expoPushToken'] as String?,
      fcmPushToken: json['fcmPushToken'] as String?,
    );

Map<String, dynamic> _$SinglePostUserToJson(SinglePostUser instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fullName': instance.fullName,
      'username': instance.username,
      'email': instance.email,
      'country': instance.country,
      'profilePicture': instance.profilePicture,
      'followers': instance.followers,
      'createdAt': instance.createdAt?.toIso8601String(),
      'expoPushToken': instance.expoPushToken,
      'fcmPushToken': instance.fcmPushToken,
    };
