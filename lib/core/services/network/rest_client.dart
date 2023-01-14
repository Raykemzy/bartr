import 'dart:io';

import 'package:bartr/core/config/response/base_response.dart';
import 'package:bartr/features/bids/domain/user_bids_model.dart';
import 'package:bartr/features/create_post/domain/dtos/report_post_dto.dart';
import 'package:bartr/features/dashboard/domain/dtos/fcm_dto.dart';
import 'package:bartr/features/forgot_password/domain/dtos/forgot_password_dto.dart';
import 'package:bartr/features/forgot_password/domain/dtos/reset_password_dto.dart';
import 'package:bartr/features/messages/domain/dtos/conversation_dto.dart';
import 'package:bartr/features/messages/domain/models/conversation_model.dart';
import 'package:bartr/features/notification/domain/notification_model.dart';
import 'package:bartr/features/post_and_comments/domain/dtos/comment_dto.dart';
import 'package:bartr/features/post_and_comments/domain/models/single_post_model.dart';
import 'package:bartr/features/login/domain/dtos/login_dto.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:bartr/features/profile/domain/dtos/change_password_dto.dart';
import 'package:bartr/features/registration/domain/dtos/register_dto.dart';
import 'package:bartr/features/registration/domain/models/register_model.dart';
import 'package:bartr/features/search/domain/models/searched_users_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../features/home/domain/models/posts_response.dart';
import '../../../features/post_and_comments/domain/models/comments_response.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST('/user/auth/login')
  Future<BaseResponse<UserResponse>> login(@Body() LoginDto loginDto);

  @PUT('/user/forgot_password')
  Future<BaseResponse> forgotPassword(
    @Body() ForgotPasswordDto forgotPasswordDto,
  );

  @PUT('/user/reset_password')
  Future<BaseResponse> resetPassword(@Body() ResetPasswordDto resetPasswordDto);
  @POST('/user/signup')
  @MultiPart()
  Future<BaseResponse> register({
    @Part() required File profilePicture,
    @Part() required String fullName,
    @Part() required String email,
    @Part() required String password,
    @Part() required String username,
    @Part() required String country,
  });

  @PUT('/user/verify_email')
  Future<BaseResponse<RegisterResponse>> verifyEmail(
    @Body() VerifyEmailDto data,
  );
  @PUT('/user/resend_code')
  Future<BaseResponse> resendVerificationCode(
    @Body() ResendCodeDto data,
  );

  @GET('/post')
  Future<BaseResponse<PostResponse>> getAllPosts(
    @Queries() Map<String, dynamic> queries,
  );
  @GET('/post/search/query')
  Future<BaseResponse<List<Post>>> searchPosts(
      @Queries() Map<String, dynamic> queries);
  @GET('/user/search?username={username}')
  Future<BaseResponse<List<SearchedUser>>> searchUsers(@Path() String username);
  @GET('/post/{postId}')
  Future<BaseResponse<SinglePost>> getSinglePost(@Path() String postId);
  @GET('/comment/post/{postId}')
  Future<BaseResponse<CommentsResponse>> fetchPostComments(
      @Path() String postId, @Queries() Map<String, dynamic> queries);
  @GET('/bid/post/{postId}')
  Future<BaseResponse<PostBidResponse>> getPostBids(@Path() String postId);
  @GET('/bid/user')
  Future<BaseResponse<UserBid>> getUserBids();
  @PUT('/post/{postId}/like')
  Future<BaseResponse> likeandUnlikePost(@Path() String postId);

  @MultiPart()
  @POST('/post')
  Future<BaseResponse> createPost({
    @Part() required List<File> images,
    @Part() required String title,
    @Part() required String description,
    @Part() required String category,
    @Part() required String postType,
    @Part() required String hours,
    @Part() required String minutes,
    @Part() required String visibility,
  });
  @MultiPart()
  @PUT('/post/{postId}/edit')
  Future<BaseResponse> editPost(
    @Path() String postId, {
    // @Part(name: "post_images") required List<String> postImages,
    @Part() required String title,
    @Part() required String description,
    @Part() required String category,
    @Part() required String postType,
    @Part() required String hours,
    @Part() required String minutes,
    @Part() required String visibility,
    @Part() required String status,
  });

  @MultiPart()
  @POST('/verification')
  Future<BaseResponse> verifyProfile({
    @Part() required File idImage,
    @Part() required String idType,
  });

  @MultiPart()
  @POST('/bid/{bidId}')
  Future<BaseResponse> makeAbid({
    @Part() required List<File> itemPicture,
    @Path() required String bidId,
    @Part() required String itemName,
    @Part() required String itemDescription,
  });
  @GET('/post/user/{userId}')
  Future<BaseResponse<PostResponse>> getUserPosts(
    @Path() String userId,
    @Queries() Map<String, dynamic> queries,
  );
  @PUT('/comment/{commentId}/like')
  Future<BaseResponse> likeComment(@Path() String commentId);
  @GET('/user/profile/{username}')
  Future<BaseResponse<BartrUser>> getUserProfile(@Path() String username);
  @PUT('/user/follow/{userId}')
  Future<BaseResponse> followOrUnfollowUser(@Path() String userId);
  @POST('/comment/{postId}')
  Future<BaseResponse<SinglePost>> commentOnPost(
    @Path() String postId,
    @Body() CommentDto data,
  );
  @PUT('/user/edit')
  @MultiPart()
  Future<BaseResponse> editProfile({
    @Part() File? profilePicture,
    @Part() required String name,
    @Part() required String username,
    @Part() required String country,
  });

  @PUT('/user/cover_photo')
  @MultiPart()
  Future<BaseResponse> changeCoverPhoto({
    @Part() required File coverPhoto,
  });

  @PUT("/user/store_fcmtoken")
  Future<BaseResponse> storeFcmToken(@Body() FcmTokenDto data);
  @POST("/chat")
  Future<BaseResponse<MessageConversation>> createConversation(
      @Body() ConversationDto data);
  @PUT("/post/report")
  Future<BaseResponse<MessageConversation>> reportPost(
      @Body() ReportPostDto data);
  @DELETE("/post/{postId}")
  Future<BaseResponse> deletePost(
    @Path() String postId,
  );
  @PUT("/user/report")
  Future<BaseResponse<MessageConversation>> reportUser(
      @Body() ReportPostDto data);
  @GET("/chat")
  Future<BaseResponse<List<Conversation>>> fetchConversations();
  @GET("/notification")
  Future<BaseResponse<NotificationResponse>> getNotifications(
    @Queries() Map<String, dynamic> queries,
  );
  @DELETE("/user")
  Future<BaseResponse> deleteAccount();
  @PUT("/user/change_password")
  Future<BaseResponse> changePassword(@Body() ChangePasswordDto data);
}
