// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Conversation _$ConversationFromJson(Map<String, dynamic> json) => Conversation(
      id: json['_id'] as String,
      members: (json['members'] as List<dynamic>)
          .map((e) => Member.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      v: json['__v'] as int,
    );

Map<String, dynamic> _$ConversationToJson(Conversation instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'members': instance.members,
      'createdAt': instance.createdAt.toIso8601String(),
      '__v': instance.v,
    };

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
      id: json['_id'] as String,
      fullName: json['fullName'] as String,
      username: json['username'] as String,
      profilePicture: json['profilePicture'] as String,
      fcmPushToken: json['fcmPushToken'] as String?,
    );

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      '_id': instance.id,
      'fullName': instance.fullName,
      'username': instance.username,
      'profilePicture': instance.profilePicture,
      'fcmPushToken': instance.fcmPushToken,
    };

MessageConversation _$MessageConversationFromJson(Map<String, dynamic> json) =>
    MessageConversation(
      id: json['_id'] as String,
      members:
          (json['members'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      v: json['__v'] as int,
    );

Map<String, dynamic> _$MessageConversationToJson(
        MessageConversation instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'members': instance.members,
      'createdAt': instance.createdAt.toIso8601String(),
      '__v': instance.v,
    };
