import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../home/domain/models/posts_response.dart';

part 'user_bids_model.g.dart';

@JsonSerializable()
class Bid2 extends Equatable {
  const Bid2({
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

  factory Bid2.fromJson(json) => _$Bid2FromJson(json);
  Map<String, dynamic> toJson() => _$Bid2ToJson(this);
  @override
  List<Object?> get props => [
        id,
        user,
        post,
        itemName,
        itemDescription,
        itemPicture,
        createdAt,
        v,
      ];
}

@JsonSerializable()
class PostBidUser extends Equatable {
  const PostBidUser({
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

  factory PostBidUser.fromJson(Map<String, dynamic> json) =>
      _$PostBidUserFromJson(json);
  Map<String, dynamic> toJson() => _$PostBidUserToJson(this);
  @override
  List<Object?> get props {
    return [
      id,
      fullName,
      username,
      country,
      profilePicture,
      createdAt,
    ];
  }
}

@JsonSerializable()
class UserBid extends Equatable {
  const UserBid({
    this.receivedBids,
    this.sentBids,
  });

  final List<ReceivedBid>? receivedBids;
  final List<SentBid>? sentBids;

  factory UserBid.fromJson(json) => _$UserBidFromJson(json);
  Map<String, dynamic> toJson() => _$UserBidToJson(this);
  @override
  List<Object?> get props => [receivedBids, sentBids];
}

@JsonSerializable()
class ReceivedBid extends Equatable {
  const ReceivedBid({
    this.id,
    this.title,
    this.postType,
    this.images,
    this.bids,
    this.totalBids,
  });

  @JsonKey(name: '_id')
  final String? id;
  final String? title;

  final String? postType;

  final List<String>? images;
  final List<Bid2>? bids;
  final int? totalBids;

  factory ReceivedBid.fromJson(json) => _$ReceivedBidFromJson(json);
  Map<String, dynamic> toJson() => _$ReceivedBidToJson(this);
  @override
  List<Object?> get props => [
        id,
        title,
        postType,
        images,
        bids,
        totalBids,
      ];
}

@JsonSerializable()
class PostBidResponse {
  @JsonKey(name: "data")
  final List<PostBid> posts;
  final Pagination? pagination;
  PostBidResponse({
    required this.posts,
    this.pagination,
  });

  factory PostBidResponse.fromJson(json) => _$PostBidResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PostBidResponseToJson(this);
}

@JsonSerializable()
class PostBid extends Equatable {
  const PostBid({
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
  final PostBidUser? user;
  final String? post;

  final String? itemName;

  final String? itemDescription;

  final String? itemPicture;
  final DateTime? createdAt;
  @JsonKey(name: '__v')
  final int? v;

  factory PostBid.fromJson(json) => _$PostBidFromJson(json);
  Map<String, dynamic> toJson() => _$PostBidToJson(this);
  @override
  List<Object?> get props => [
        id,
        user,
        post,
        itemName,
        itemDescription,
        itemPicture,
      ];
}

@JsonSerializable()
class SentBid extends Equatable {
  const SentBid({
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
  final BidPost? post;

  final String? itemName;

  final String? itemDescription;

  final String? itemPicture;
  final DateTime? createdAt;
  final int? v;

  factory SentBid.fromJson(json) => _$SentBidFromJson(json);
  Map<String, dynamic> toJson() => _$SentBidToJson(this);
  @override
  List<Object?> get props => [
        id,
        user,
        post,
        itemName,
        itemDescription,
        itemPicture,
        createdAt,
        v,
      ];
}

@JsonSerializable()
class BidPost extends Equatable {
  const BidPost({
    this.id,
    this.title,
    this.images,
  });

  @JsonKey(name: '_id')
  final String? id;
  final String? title;

  final List<String>? images;

  factory BidPost.fromJson(json) => _$BidPostFromJson(json);
  Map<String, dynamic> toJson() => _$BidPostToJson(this);
  @override
  List<Object?> get props => [
        id,
        title,
        images,
      ];
}
