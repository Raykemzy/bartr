import 'package:json_annotation/json_annotation.dart';

import '../../../login/domain/models/login_model.dart';
part 'posts_response.g.dart';

@JsonSerializable()
class PostResponse {
  @JsonKey(name: "data")
  final List<Post> posts;
  final Pagination? pagination;
  PostResponse({
    required this.posts,
    this.pagination,
  });

  factory PostResponse.fromJson(json) => _$PostResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PostResponseToJson(this);
}

@JsonSerializable()
class Pagination {
  Pagination({
    this.totalResult,
    this.totalPages,
    this.currentPage,
    this.nextPage,
    this.hasNextPage,
    this.hasPrevPage,
  });

  @JsonKey(name: "total_result")
  final int? totalResult;
  @JsonKey(name: "total_pages")
  final int? totalPages;
  @JsonKey(name: "current_page")
  final int? currentPage;
  @JsonKey(name: "next_page")
  final int? nextPage;
  @JsonKey(name: "has_next_page")
  final bool? hasNextPage;
  @JsonKey(name: "has_prev_page")
  final bool? hasPrevPage;

  factory Pagination.fromJson(json) => _$PaginationFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
