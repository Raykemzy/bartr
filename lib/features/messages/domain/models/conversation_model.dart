import 'package:json_annotation/json_annotation.dart';
part 'conversation_model.g.dart';

@JsonSerializable()
class Conversation {
  Conversation({
    required this.id,
    required this.members,
    required this.createdAt,
    required this.v,
  });

  @JsonKey(name: "_id")
  final String id;

  final List<Member> members;

  final DateTime createdAt;
  @JsonKey(name: "__v")
  final int v;

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);
  Map<String, dynamic> toJson() => _$ConversationToJson(this);
}

@JsonSerializable()
class Member {
  Member({
    required this.id,
    required this.fullName,
    required this.username,
    required this.profilePicture,
    required this.fcmPushToken,
  });

  @JsonKey(name: "_id")
  final String id;

  final String fullName;

  final String username;

  final String profilePicture;

  final String? fcmPushToken;

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
  Map<String, dynamic> toJson() => _$MemberToJson(this);
}

@JsonSerializable()
class MessageConversation {
  MessageConversation({
    required this.id,
    required this.members,
    required this.createdAt,
    required this.v,
  });

  @JsonKey(name: "_id")
  final String id;
  final List<String> members;
  final DateTime createdAt;
  @JsonKey(name: "__v")
  final int v;

  factory MessageConversation.fromJson(Map<String, dynamic> json) =>
      _$MessageConversationFromJson(json);
  Map<String, dynamic> toJson() => _$MessageConversationToJson(this);
}
