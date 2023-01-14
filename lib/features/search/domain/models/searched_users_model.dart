import 'package:json_annotation/json_annotation.dart';

import '../../../login/domain/models/login_model.dart';
part 'searched_users_model.g.dart';

@JsonSerializable()
class SearchedUser {
  SearchedUser({
    this.fcmPushToken,
    this.id,
    this.fullName,
    this.username,
    this.email,
    this.country,
    this.profilePicture,
    this.emailConfirmed,
    this.signupCode,
    this.terms,
    this.createdAt,
    this.v,
    this.followers,
    this.following,
    this.posts,
    this.expoPushToken,
    this.coverPhoto,
    this.passwordResetCode,
    this.passwordResetCodeExpire,
    this.password,
  });
  @JsonKey(name: '_id')
  final String? id;

  final String? fullName;

  final String? username;

  final String? email;

  final String? country;

  final String? profilePicture;

  final bool? emailConfirmed;

  final int? signupCode;

  final bool? terms;

  final DateTime? createdAt;
  @JsonKey(name: '__v')
  final int? v;

  final List<String>? followers;

  final List<String>? following;

  final List<Post>? posts;

  final String? expoPushToken;

  final String? coverPhoto;

  final int? passwordResetCode;

  final DateTime? passwordResetCodeExpire;

  final String? password;

  final String? fcmPushToken;

  factory SearchedUser.fromJson(json) => _$SearchedUserFromJson(json);
  Map<String, dynamic> toJson() => _$SearchedUserToJson(this);
}
