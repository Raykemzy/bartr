import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'comment_dto.g.dart';

@JsonSerializable()
class CommentDto extends Equatable {
  final String commentText;
  final List<String> mentionedUsers;

  const CommentDto({
    required this.commentText,
    required this.mentionedUsers,
  });

  factory CommentDto.fromJson(Map<String, dynamic> json) =>
      _$CommentDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CommentDtoToJson(this);

  @override
  List<Object> get props => [commentText];
}
