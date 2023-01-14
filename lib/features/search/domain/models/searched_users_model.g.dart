// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searched_users_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchedUser _$SearchedUserFromJson(Map<String, dynamic> json) => SearchedUser(
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
          ?.map((e) => e as String)
          .toList(),
      following: (json['following'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      posts: (json['posts'] as List<dynamic>?)
          ?.map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
      expoPushToken: json['expoPushToken'] as String?,
      coverPhoto: json['coverPhoto'] as String?,
      passwordResetCode: json['passwordResetCode'] as int?,
      passwordResetCodeExpire: json['passwordResetCodeExpire'] == null
          ? null
          : DateTime.parse(json['passwordResetCodeExpire'] as String),
      password: json['password'] as String?,
    );

Map<String, dynamic> _$SearchedUserToJson(SearchedUser instance) =>
    <String, dynamic>{
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
      'passwordResetCode': instance.passwordResetCode,
      'passwordResetCodeExpire':
          instance.passwordResetCodeExpire?.toIso8601String(),
      'password': instance.password,
      'fcmPushToken': instance.fcmPushToken,
    };
