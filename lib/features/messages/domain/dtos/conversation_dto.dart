import 'package:json_annotation/json_annotation.dart';
part "conversation_dto.g.dart";

@JsonSerializable()
class ConversationDto {
  final String userOne;
  final String userTwo;
  ConversationDto({
    required this.userOne,
    required this.userTwo,
  });

  Map<String, dynamic> toJson() => _$ConversationDtoToJson(this);

  factory ConversationDto.fromJson(Map<String, dynamic> json) =>
      _$ConversationDtoFromJson(json);
}
