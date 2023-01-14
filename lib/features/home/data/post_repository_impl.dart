import 'dart:async';
import 'dart:convert';

import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/config/exception/app_exception.dart';
import 'package:bartr/core/config/exception/logger.dart';
import 'package:bartr/core/config/response/base_response.dart';
import 'package:bartr/core/helpers/extensions.dart';
import 'package:bartr/core/services/local_database/abstract_class_hivestorage.dart';
import 'package:bartr/core/services/local_database/hive_keys.dart';
import 'package:bartr/core/services/network/rest_client.dart';
import 'package:bartr/domain/repositories/posts_repository.dart';
import 'package:bartr/features/create_post/domain/dtos/create_post_dto.dart';
import 'package:bartr/features/create_post/domain/dtos/report_post_dto.dart';
import 'package:bartr/features/edit_post/domain/edit_post_dto.dart';
import 'package:bartr/features/make_a_bid/domain/dtos/make_a_bid_dto.dart';
import 'package:bartr/features/post_and_comments/domain/dtos/comment_dto.dart';
import 'package:bartr/features/post_and_comments/domain/models/comments_response.dart';
import 'package:bartr/features/post_and_comments/domain/models/single_post_model.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../search/domain/models/searched_users_model.dart';
import '../domain/models/posts_response.dart';

class PostRepositoryImpl implements PostsRepository {
  final RestClient _client;
  final AbstractHive _storage;

  PostRepositoryImpl(this._client, this._storage);
  @override
  Future<BaseResponse<PostResponse>> getAllPosts(int page) async {
    try {
      var data = await _client.getAllPosts({
        "page": page,
      });
      if (data.data != null && data.data!.posts.isNotEmpty) {
        savePostsLocally(data.data!.posts);
      }
      return data;
    } on DioError catch (e) {
      var localposts = getPostsLocally();
      return AppException.handleError(
        e,
        data: PostResponse(posts: localposts),
      );
    }
  }

  @override
  Future<BaseResponse<SinglePost>> getSinglePost(String postId) async {
    try {
      final post = await _client.getSinglePost(postId);
      _broadcastingPostsControllers[postId]?.add(post.data!);
      return post;
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  Future<BaseResponse> likeAndUnlikePost(String postId) async {
    try {
      return await _client.likeandUnlikePost(postId);
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  Future<BaseResponse> createPost(CreatePostDto data) async {
    try {
      return await _client.createPost(
        category: data.category,
        title: data.title,
        description: data.description,
        hours: data.hours,
        minutes: data.minutes,
        postType: data.postType.name.capiTalizeFirst(),
        images: data.images,
        visibility: data.visibility.name.capiTalizeFirst(),
      );
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  Future<BaseResponse> editPost(EditPostDto data, String postID) async {
    try {
      return await _client.editPost(
        postID,
        category: data.category!,
        title: data.title!,
        description: data.description!,
        hours: data.hours!,
        minutes: data.minutes!,
        postType: data.postType!.name.capiTalizeFirst(),
        // postImages: data.images!,
        visibility: data.visibility!.name.capiTalizeFirst(),
        status: data.status!,
      );
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  Future<BaseResponse> commentOnPost({
    required String postId,
    required CommentDto data,
  }) async {
    try {
      return await _client.commentOnPost(postId, data);
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  Future<BaseResponse> reportPost({required ReportPostDto data}) async {
    try {
      return await _client.reportPost(data);
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  Future<BaseResponse<PostResponse>> getUserPosts({
    required String userId,
    required int page,
  }) async {
    try {
      return await _client.getUserPosts(userId, {
        "page": page,
      });
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  Future<BaseResponse> likeAndUnlikeComment(String commentId) async {
    try {
      return await _client.likeComment(commentId);
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  Future<BaseResponse> makeAbid({required MakeAbidDto data}) async {
    try {
      return await _client.makeAbid(
          itemName: data.itemName,
          itemDescription: data.itemDescription,
          itemPicture: data.itemPicture,
          bidId: data.bidId);
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  List<Post> getPostsLocally() {
    var data = _storage.get(HiveKeys.generalPosts) ?? [];
    List newdata = json.decode(data);
    var posts = List<Post>.from(newdata.map((e) => Post.fromJson(e))).toList();
    return posts;
  }

  @override
  void savePostsLocally(List<Post> posts) async {
    await _storage.put(HiveKeys.generalPosts, json.encode(posts));
  }

  @override
  Future<BaseResponse<List<Post>>> searchPosts(String query) async {
    try {
      return await _client.searchPosts({
        "title": query,
      });
    } on DioError catch (e) {
      return AppException.handleError(
        e,
        data: getPostsLocally(),
      );
    }
  }

  @override
  List<Post> getSearchedPostsLocally() {
    var data = _storage.get(HiveKeys.searchedPosts) ?? [];
    List newdata = data is String ? json.decode(data) : data;
    var posts = List<Post>.from(newdata.map((e) => Post.fromJson(e))).toList();
    return posts;
  }

  @override
  void saveSearchedPostsLocally(List<Post> posts) async {
    await _storage.put(HiveKeys.searchedPosts, json.encode(posts));
  }

  @override
  List<SearchedUser> getSearchedUsersLocally() {
    var data = _storage.get(HiveKeys.searchedUsers) ?? [];
    List newdata = data is String ? json.decode(data) : data;
    var users =
        List<SearchedUser>.from(newdata.map((e) => SearchedUser.fromJson(e)))
            .toList();
    return users;
  }

  @override
  void saveSearchedUsersLocally(List<SearchedUser> users) async {
    await _storage.put(HiveKeys.searchedUsers, json.encode(users));
  }

  final _broadcastingPostsControllers =
      <String, StreamController<SinglePost>>{};

  @override
  Stream<SinglePost> postCommentsCreateBroadcast(String postId) {
    if (!_broadcastingPostsControllers.containsKey(postId)) {
      _broadcastingPostsControllers[postId] =
          StreamController.broadcast(onCancel: () {
        _broadcastingPostsControllers[postId]?.close();
        _broadcastingPostsControllers.remove(postId);
        debugLog("CLOSED STREAM");
      });
    }
    return _broadcastingPostsControllers[postId]!.stream.asBroadcastStream();
  }

  @override
  Future<BaseResponse<CommentsResponse>> fetchPostComments({
    required String postId,
    required int page,
  }) async {
    try {
      return await _client.fetchPostComments(postId, {
        "page": page,
      });
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  Future<BaseResponse> deletePost(String postId) async {
    try {
      return await _client.deletePost(
        postId,
      );
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }
}

final postsRepository = Provider<PostsRepository>(
  (_) => PostRepositoryImpl(
    _.read(restClient),
    _.read(localDb),
  ),
);
