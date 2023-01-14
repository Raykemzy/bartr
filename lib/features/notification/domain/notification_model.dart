import 'package:bartr/core/utils/enums.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../home/domain/models/posts_response.dart';
part 'notification_model.g.dart';

@JsonSerializable()
class NotificationResponse {
  @JsonKey(name: "data")
  final List<NotificationModel> notifications;
  final Pagination? pagination;
  NotificationResponse({
    required this.notifications,
    this.pagination,
  });

  factory NotificationResponse.fromJson(json) =>
      _$NotificationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationResponseToJson(this);
}

@JsonSerializable()
class NotificationModel {
  NotificationModel({
    this.id,
    this.sender,
    this.receiver,
    this.post,
    this.body,
    this.title,
    this.createdAt,
    this.v,
    required this.type,
  });

  @JsonKey(name: "_id")
  final String? id;
  final Sender? sender;
  final String? receiver;
  final String? post;
  final String? body;
  final String? title;
  final DateTime? createdAt;
  @JsonKey(name: "__v")
  final int? v;
  final NotificationType type;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}

@JsonSerializable()
class Sender {
  Sender({
    this.id,
    this.fullName,
    this.username,
    this.country,
    this.profilePicture,
    this.createdAt,
    this.fcmPushToken,
  });
  @JsonKey(name: "_id")
  final String? id;
  final String? fullName;
  final String? username;
  final String? country;
  final String? profilePicture;
  final DateTime? createdAt;
  final String? fcmPushToken;

  factory Sender.fromJson(Map<String, dynamic> json) => _$SenderFromJson(json);
  Map<String, dynamic> toJson() => _$SenderToJson(this);
}
