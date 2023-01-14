import 'package:bartr/core/utils/enums.dart';
import 'package:json_annotation/json_annotation.dart';
part 'notification_dto.g.dart';

@JsonSerializable()
class NotficationDto {
  NotficationDto({
    required this.to,
    required this.notification,
    required this.data,
  });

  final String to;
  final Notification notification;
  final Data data;

  Map<String, dynamic> toJson() => _$NotficationDtoToJson(this);

  factory NotficationDto.fromJson(Map<String, dynamic> json) =>
      _$NotficationDtoFromJson(json);
}

@JsonSerializable()
class Data {
  Data({
    required this.conversationId,
    required this.id,
    required this.fullName,
    required this.username,
    required this.profilePicture,
    required this.fcmPushToken,
    required this.type,
    required this.receiverId,
  });

  final String conversationId;
  @JsonKey(name: "_id")
  final String id;
  final String fullName;
  final String username;
  final String receiverId;
  final String profilePicture;
  final String fcmPushToken;
  final NotificationType type;

  Map<String, dynamic> toJson() => _$DataToJson(this);

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@JsonSerializable()
class Notification {
  Notification({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;

  Map<String, dynamic> toJson() => _$NotificationToJson(this);

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
}
