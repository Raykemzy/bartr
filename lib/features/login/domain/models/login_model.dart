import 'package:bartr/core/utils/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class UserResponse extends Equatable {
  const UserResponse({
    required this.user,
    required this.token,
  });

  final BartrUser user;
  final String token;

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  @override
  List<Object> get props => [user, token];
}

@JsonSerializable()
class BartrUser {
  BartrUser({
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
    this.verified,
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

  final List<Follow>? followers;

  final List<Follow>? following;

  final List<Post>? posts;

  final String? expoPushToken;

  final String? coverPhoto;

  final bool? verified;
  final String? password;

  final String? fcmPushToken;

  factory BartrUser.fromJson(json) => _$BartrUserFromJson(json);
  Map<String, dynamic> toJson() => _$BartrUserToJson(this);

  Map<String, dynamic> toLocalDb() => {
        '_id': id,
        'fullName': fullName,
        'username': username,
        'email': email,
        'country': country,
        'profilePicture': profilePicture,
        'emailConfirmed': emailConfirmed,
        'signupCode': signupCode,
        'terms': terms,
        'createdAt': createdAt?.toIso8601String(),
        '__v': v,
        'followers': followers == null
            ? []
            : List.from(followers!.map((e) => e.toJson())).toList(),
        'following': following == null
            ? []
            : List.from(following!.map((e) => e.toJson())).toList(),
        'posts': posts == null
            ? []
            : List.from(posts!.map((e) => e.toJson())).toList(),
        'expoPushToken': expoPushToken,
        'coverPhoto': coverPhoto,
        'password': password,
        'fcmPushToken': fcmPushToken,
        'verified': verified,
      };

  BartrUser copyWith({
    String? id,
    String? fullName,
    String? username,
    String? email,
    String? country,
    String? profilePicture,
    bool? emailConfirmed,
    int? signupCode,
    bool? terms,
    DateTime? createdAt,
    int? v,
    List<Follow>? followers,
    List<Follow>? following,
    List<Post>? posts,
    String? expoPushToken,
    String? coverPhoto,
    bool? verified,
    String? password,
    String? fcmPushToken,
  }) {
    return BartrUser(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      username: username ?? this.username,
      email: email ?? this.email,
      country: country ?? this.country,
      profilePicture: profilePicture ?? this.profilePicture,
      emailConfirmed: emailConfirmed ?? this.emailConfirmed,
      signupCode: signupCode ?? this.signupCode,
      terms: terms ?? this.terms,
      createdAt: createdAt ?? this.createdAt,
      v: v ?? this.v,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      posts: posts ?? this.posts,
      expoPushToken: expoPushToken ?? this.expoPushToken,
      coverPhoto: coverPhoto ?? this.coverPhoto,
      verified: verified ?? this.verified,
      password: password ?? this.password,
      fcmPushToken: fcmPushToken ?? this.fcmPushToken,
    );
  }
}

@JsonSerializable()
class Follow {
  Follow({
    this.id,
    this.fullName,
    this.username,
    this.profilePicture,
    this.following,
  });

  @JsonKey(name: '_id')
  final String? id;

  final String? fullName;

  final String? username;

  final String? profilePicture;

  final List<String>? following;

  factory Follow.fromJson(Map<String, dynamic> json) => _$FollowFromJson(json);
  Map<String, dynamic> toJson() => _$FollowToJson(this);
}

@JsonSerializable()
class Post {
  Post({
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
    this.comments,
    this.createdAt,
    this.v,
  });
  @JsonKey(name: '_id')
  final String? id;

  final PostUser? user;

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

  final List<Bid>? bids;

  final List<Comment>? comments;

  final DateTime? createdAt;
  @JsonKey(name: '__v')
  final int? v;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);

  Post copyWith({
    String? id,
    PostUser? user,
    String? title,
    String? description,
    String? category,
    String? location,
    String? status,
    PostVisiblility? visibility,
    DateTime? expireDate,
    PostType? postType,
    int? likes,
    int? totalComments,
    List<String>? likedBy,
    List<String>? images,
    List<Bid>? bids,
    List<Comment>? comments,
    DateTime? createdAt,
    int? v,
  }) {
    return Post(
      id: id ?? this.id,
      user: user ?? this.user,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      location: location ?? this.location,
      status: status ?? this.status,
      visibility: visibility ?? this.visibility,
      expireDate: expireDate ?? this.expireDate,
      postType: postType ?? this.postType,
      likes: likes ?? this.likes,
      totalComments: totalComments ?? this.totalComments,
      likedBy: likedBy ?? this.likedBy,
      images: images ?? this.images,
      bids: bids ?? this.bids,
      comments: comments ?? this.comments,
      createdAt: createdAt ?? this.createdAt,
      v: v ?? this.v,
    );
  }
}

@JsonSerializable()
class Bid {
  Bid({
    this.id,
    this.user,
    this.post,
    this.itemName,
    this.itemDescription,
    this.itemPicture,
    this.createdAt,
    this.v,
  });
  @JsonKey(name: '_id')
  final String? id;

  final String? user;

  final String? post;

  final String? itemName;

  final String? itemDescription;

  final String? itemPicture;

  final DateTime? createdAt;
  @JsonKey(name: '__v')
  final int? v;

  factory Bid.fromJson(Map<String, dynamic> json) => _$BidFromJson(json);
  Map<String, dynamic> toJson() => _$BidToJson(this);
}

@JsonSerializable()
class Comment {
  Comment({
    this.id,
    this.user,
    this.post,
    this.commentText,
    this.createdAt,
    this.v,
  });
  @JsonKey(name: '_id')
  final String? id;

  final String? user;

  final String? post;

  final String? commentText;

  final DateTime? createdAt;
  @JsonKey(name: '__v')
  final int? v;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}

@JsonSerializable()
class PostUser extends Equatable {
  const PostUser({
    this.id,
    this.fullName,
    this.username,
    this.country,
    this.profilePicture,
    this.followers,
    this.email,
    this.verified,
    this.fcmPushToken,
  });

  @JsonKey(name: '_id')
  final String? id;
  final String? fullName;
  final String? username;
  final String? country;
  final String? profilePicture;
  final List<String>? followers;
  final String? email;
  final bool? verified;
  final String? fcmPushToken;

  factory PostUser.fromJson(Map<String, dynamic> json) =>
      _$PostUserFromJson(json);
  Map<String, dynamic> toJson() => _$PostUserToJson(this);
  @override
  List<Object?> get props {
    return [
      id,
      fullName,
      username,
      country,
      profilePicture,
      followers,
    ];
  }
}
