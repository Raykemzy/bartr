// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotficationDto _$NotficationDtoFromJson(Map<String, dynamic> json) =>
    NotficationDto(
      to: json['to'] as String,
      notification:
          Notification.fromJson(json['notification'] as Map<String, dynamic>),
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotficationDtoToJson(NotficationDto instance) =>
    <String, dynamic>{
      'to': instance.to,
      'notification': instance.notification,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      conversationId: json['conversationId'] as String,
      id: json['_id'] as String,
      fullName: json['fullName'] as String,
      username: json['username'] as String,
      profilePicture: json['profilePicture'] as String,
      fcmPushToken: json['fcmPushToken'] as String,
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      receiverId: json['receiverId'] as String,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'conversationId': instance.conversationId,
      '_id': instance.id,
      'fullName': instance.fullName,
      'username': instance.username,
      'receiverId': instance.receiverId,
      'profilePicture': instance.profilePicture,
      'fcmPushToken': instance.fcmPushToken,
      'type': _$NotificationTypeEnumMap[instance.type]!,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.comment: 'comment',
  NotificationType.bid: 'bid',
  NotificationType.post: 'post',
  NotificationType.message: 'message',
  NotificationType.user: 'user',
};

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      title: json['title'] as String,
      body: json['body'] as String,
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
    };
