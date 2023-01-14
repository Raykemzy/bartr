// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bartr/features/post_and_comments/domain/models/single_post_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../home/domain/models/posts_response.dart';
part 'comments_response.g.dart';

@JsonSerializable()
class CommentsResponse {
  @JsonKey(name: "data")
  final List<SinglePostComment> comments;
  final Pagination pagination;
  CommentsResponse({
    required this.comments,
    required this.pagination,
  });

  factory CommentsResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CommentsResponseToJson(this);
}
