// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      user: BartrUser.fromJson(json['user']),
      token: json['token'] as String,
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
    };

BartrUser _$BartrUserFromJson(Map<String, dynamic> json) => BartrUser(
      fcmPushToken: json['fcmPushToken'] as String?,
      id: json['_id'] as String?,
      fullName: json['fullName'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      country: json['country'] as String?,
      profilePicture: json['profilePicture'] as String?,
      emailConfirmed: json['emailConfirmed'] as bool?,
      signupCode: json['signupCode'] as int?,
      terms: json['terms'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      v: json['__v'] as int?,
      followers: (json['followers'] as List<dynamic>?)
          ?.map((e) => Follow.fromJson(e as Map<String, dynamic>))
          .toList(),
      following: (json['following'] as List<dynamic>?)
          ?.map((e) => Follow.fromJson(e as Map<String, dynamic>))
          .toList(),
      posts: (json['posts'] as List<dynamic>?)
          ?.map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
      expoPushToken: json['expoPushToken'] as String?,
      coverPhoto: json['coverPhoto'] as String?,
      verified: json['verified'] as bool?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$BartrUserToJson(BartrUser instance) => <String, dynamic>{
      '_id': instance.id,
      'fullName': instance.fullName,
      'username': instance.username,
      'email': instance.email,
      'country': instance.country,
      'profilePicture': instance.profilePicture,
      'emailConfirmed': instance.emailConfirmed,
      'signupCode': instance.signupCode,
      'terms': instance.terms,
      'createdAt': instance.createdAt?.toIso8601String(),
      '__v': instance.v,
      'followers': instance.followers,
      'following': instance.following,
      'posts': instance.posts,
      'expoPushToken': instance.expoPushToken,
      'coverPhoto': instance.coverPhoto,
      'verified': instance.verified,
      'password': instance.password,
      'fcmPushToken': instance.fcmPushToken,
    };

Follow _$FollowFromJson(Map<String, dynamic> json) => Follow(
      id: json['_id'] as String?,
      fullName: json['fullName'] as String?,
      username: json['username'] as String?,
      profilePicture: json['profilePicture'] as String?,
      following: (json['following'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$FollowToJson(Follow instance) => <String, dynamic>{
      '_id': instance.id,
      'fullName': instance.fullName,
      'username': instance.username,
      'profilePicture': instance.profilePicture,
      'following': instance.following,
    };

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: json['_id'] as String?,
      user: json['user'] == null
          ? null
          : PostUser.fromJson(json['user'] as Map<String, dynamic>),
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
      bids: (json['bids'] as List<dynamic>?)
          ?.map((e) => Bid.fromJson(e as Map<String, dynamic>))
          .toList(),
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      v: json['__v'] as int?,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
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
      'comments': instance.comments,
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

Bid _$BidFromJson(Map<String, dynamic> json) => Bid(
      id: json['_id'] as String?,
      user: json['user'] as String?,
      post: json['post'] as String?,
      itemName: json['itemName'] as String?,
      itemDescription: json['itemDescription'] as String?,
      itemPicture: json['itemPicture'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      v: json['__v'] as int?,
    );

Map<String, dynamic> _$BidToJson(Bid instance) => <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'post': instance.post,
      'itemName': instance.itemName,
      'itemDescription': instance.itemDescription,
      'itemPicture': instance.itemPicture,
      'createdAt': instance.createdAt?.toIso8601String(),
      '__v': instance.v,
    };

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['_id'] as String?,
      user: json['user'] as String?,
      post: json['post'] as String?,
      commentText: json['commentText'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      v: json['__v'] as int?,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'post': instance.post,
      'commentText': instance.commentText,
      'createdAt': instance.createdAt?.toIso8601String(),
      '__v': instance.v,
    };

PostUser _$PostUserFromJson(Map<String, dynamic> json) => PostUser(
      id: json['_id'] as String?,
      fullName: json['fullName'] as String?,
      username: json['username'] as String?,
      country: json['country'] as String?,
      profilePicture: json['profilePicture'] as String?,
      followers: (json['followers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      email: json['email'] as String?,
      verified: json['verified'] as bool?,
      fcmPushToken: json['fcmPushToken'] as String?,
    );

Map<String, dynamic> _$PostUserToJson(PostUser instance) => <String, dynamic>{
      '_id': instance.id,
      'fullName': instance.fullName,
      'username': instance.username,
      'country': instance.country,
      'profilePicture': instance.profilePicture,
      'followers': instance.followers,
      'email': instance.email,
      'verified': instance.verified,
      'fcmPushToken': instance.fcmPushToken,
    };
