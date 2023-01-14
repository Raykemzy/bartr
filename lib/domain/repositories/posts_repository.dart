import 'package:bartr/core/router/routes.dart';
import 'package:bartr/features/create_post/domain/dtos/create_post_dto.dart';
import 'package:bartr/features/create_post/domain/dtos/report_post_dto.dart';
import 'package:bartr/features/edit_post/domain/edit_post_dto.dart';
import 'package:bartr/features/make_a_bid/domain/dtos/make_a_bid_dto.dart';
import 'package:bartr/features/post_and_comments/domain/dtos/comment_dto.dart';
import 'package:bartr/features/post_and_comments/domain/models/single_post_model.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';

import '../../core/config/response/base_response.dart';
import '../../features/home/domain/models/posts_response.dart';
import '../../features/post_and_comments/domain/models/comments_response.dart';
import '../../features/search/domain/models/searched_users_model.dart';

abstract class PostsRepository {
  Future<BaseResponse<PostResponse>> getAllPosts(int page);
  Future<BaseResponse<List<Post>>> searchPosts(String query);
  Future<BaseResponse<SinglePost>> getSinglePost(String postId);
  Future<BaseResponse> likeAndUnlikePost(String postId);
  Future<BaseResponse<CommentsResponse>> fetchPostComments({
    required String postId,
    required int page,
  });
  Future<BaseResponse> likeAndUnlikeComment(String commentId);
  Future<BaseResponse> createPost(CreatePostDto data);
  Future<BaseResponse> editPost(EditPostDto data, String postId);
  Future<BaseResponse> reportPost({required ReportPostDto data});
  Future<BaseResponse> commentOnPost({
    required String postId,
    required CommentDto data,
  });
  Future<BaseResponse> makeAbid({required MakeAbidDto data});
  Future<BaseResponse<PostResponse>> getUserPosts({
    required String userId,
    required int page,
  });
  void savePostsLocally(List<Post> posts);
  List<Post> getPostsLocally();
  void saveSearchedPostsLocally(List<Post> posts);
  List<Post> getSearchedPostsLocally();
  List<SearchedUser> getSearchedUsersLocally();
  void saveSearchedUsersLocally(List<SearchedUser> posts);
  Stream<SinglePost> postCommentsCreateBroadcast(String postId);
  Future<BaseResponse> deletePost(String postId);
}
