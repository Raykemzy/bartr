// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_bids_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bid2 _$Bid2FromJson(Map<String, dynamic> json) => Bid2(
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

Map<String, dynamic> _$Bid2ToJson(Bid2 instance) => <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'post': instance.post,
      'itemName': instance.itemName,
      'itemDescription': instance.itemDescription,
      'itemPicture': instance.itemPicture,
      'createdAt': instance.createdAt?.toIso8601String(),
      '__v': instance.v,
    };

PostBidUser _$PostBidUserFromJson(Map<String, dynamic> json) => PostBidUser(
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

Map<String, dynamic> _$PostBidUserToJson(PostBidUser instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fullName': instance.fullName,
      'username': instance.username,
      'country': instance.country,
      'profilePicture': instance.profilePicture,
      'createdAt': instance.createdAt?.toIso8601String(),
      'fcmPushToken': instance.fcmPushToken,
    };

UserBid _$UserBidFromJson(Map<String, dynamic> json) => UserBid(
      receivedBids: (json['receivedBids'] as List<dynamic>?)
          ?.map((e) => ReceivedBid.fromJson(e))
          .toList(),
      sentBids: (json['sentBids'] as List<dynamic>?)
          ?.map((e) => SentBid.fromJson(e))
          .toList(),
    );

Map<String, dynamic> _$UserBidToJson(UserBid instance) => <String, dynamic>{
      'receivedBids': instance.receivedBids,
      'sentBids': instance.sentBids,
    };

ReceivedBid _$ReceivedBidFromJson(Map<String, dynamic> json) => ReceivedBid(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      postType: json['postType'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      bids: (json['bids'] as List<dynamic>?)
          ?.map((e) => Bid2.fromJson(e))
          .toList(),
      totalBids: json['totalBids'] as int?,
    );

Map<String, dynamic> _$ReceivedBidToJson(ReceivedBid instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'postType': instance.postType,
      'images': instance.images,
      'bids': instance.bids,
      'totalBids': instance.totalBids,
    };

PostBidResponse _$PostBidResponseFromJson(Map<String, dynamic> json) =>
    PostBidResponse(
      posts: (json['data'] as List<dynamic>)
          .map((e) => PostBid.fromJson(e))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination']),
    );

Map<String, dynamic> _$PostBidResponseToJson(PostBidResponse instance) =>
    <String, dynamic>{
      'data': instance.posts,
      'pagination': instance.pagination,
    };

PostBid _$PostBidFromJson(Map<String, dynamic> json) => PostBid(
      id: json['_id'] as String?,
      user: json['user'] == null
          ? null
          : PostBidUser.fromJson(json['user'] as Map<String, dynamic>),
      post: json['post'] as String?,
      itemName: json['itemName'] as String?,
      itemDescription: json['itemDescription'] as String?,
      itemPicture: json['itemPicture'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      v: json['__v'] as int?,
    );

Map<String, dynamic> _$PostBidToJson(PostBid instance) => <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'post': instance.post,
      'itemName': instance.itemName,
      'itemDescription': instance.itemDescription,
      'itemPicture': instance.itemPicture,
      'createdAt': instance.createdAt?.toIso8601String(),
      '__v': instance.v,
    };

SentBid _$SentBidFromJson(Map<String, dynamic> json) => SentBid(
      id: json['_id'] as String?,
      user: json['user'] as String?,
      post: json['post'] == null ? null : BidPost.fromJson(json['post']),
      itemName: json['itemName'] as String?,
      itemDescription: json['itemDescription'] as String?,
      itemPicture: json['itemPicture'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      v: json['v'] as int?,
    );

Map<String, dynamic> _$SentBidToJson(SentBid instance) => <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'post': instance.post,
      'itemName': instance.itemName,
      'itemDescription': instance.itemDescription,
      'itemPicture': instance.itemPicture,
      'createdAt': instance.createdAt?.toIso8601String(),
      'v': instance.v,
    };

BidPost _$BidPostFromJson(Map<String, dynamic> json) => BidPost(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$BidPostToJson(BidPost instance) => <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'images': instance.images,
    };
