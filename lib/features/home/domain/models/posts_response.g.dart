// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostResponse _$PostResponseFromJson(Map<String, dynamic> json) => PostResponse(
      posts: (json['data'] as List<dynamic>)
          .map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination']),
    );

Map<String, dynamic> _$PostResponseToJson(PostResponse instance) =>
    <String, dynamic>{
      'data': instance.posts,
      'pagination': instance.pagination,
    };

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      totalResult: json['total_result'] as int?,
      totalPages: json['total_pages'] as int?,
      currentPage: json['current_page'] as int?,
      nextPage: json['next_page'] as int?,
      hasNextPage: json['has_next_page'] as bool?,
      hasPrevPage: json['has_prev_page'] as bool?,
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'total_result': instance.totalResult,
      'total_pages': instance.totalPages,
      'current_page': instance.currentPage,
      'next_page': instance.nextPage,
      'has_next_page': instance.hasNextPage,
      'has_prev_page': instance.hasPrevPage,
    };
