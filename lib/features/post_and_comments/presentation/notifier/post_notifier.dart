import 'package:bartr/core/helpers/extensions.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/domain/repositories/conversation_repository.dart';
import 'package:bartr/domain/repositories/posts_repository.dart';
import 'package:bartr/features/bids/domain/bid_with_conversation.dart';
import 'package:bartr/features/messages/domain/dtos/conversation_dto.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/dtos/comment_dto.dart';
import 'post_state.dart';

class PostNotifier extends StateNotifier<PostState> {
  PostNotifier(
    this.postsRepository,
    this.conversationRepository,
  ) : super(PostState.initial());
  final PostsRepository postsRepository;
  final ConversationRepository conversationRepository;

  Future<void> getSinglePost({
    bool retry = false,
    required String postId,
  }) async {
    if (retry) {
      state = state.copyWith(postLoadState: LoadState.loading);
    }
    try {
      final res = await postsRepository.getSinglePost(postId);
      if (res.status) {
        state = state.copyWith(
          currentPost: res.data,
          postLoadState: LoadState.success,
          // comments: res.data!.comments,
        );
        return;
      }
      if (res.error == "Post not found") {
        state = state.copyWith(
            postLoadState: LoadState.other, errorMessage: "Post not found");
        return;
      }
      state = state.copyWith(postLoadState: LoadState.error);
    } catch (e) {
      state = state.copyWith(postLoadState: LoadState.error);
    }
  }

  Future<void> commentOnPost({
    required String postId,
    required String commentText,
  }) async {
    Set<String> mentionedUsers = {};
    for (var element in commentText.split(" ")) {
      if (element.startsWith("@")) {
        mentionedUsers.add(element.removeTag());
      }
    }
    state = state.copyWith(commentLoadState: LoadState.loading);
    try {
      final res = await postsRepository.commentOnPost(
        postId: postId,
        data: CommentDto(
          commentText: commentText,
          mentionedUsers: mentionedUsers.toList(),
        ),
      );
      if (res.status) {
        state = state.copyWith(
          commentLoadState: LoadState.success,
          message: res.message,
        );
        state = state.copyWith(commentLoadState: LoadState.idle);
        return;
      }
      state = state.copyWith(
        commentLoadState: LoadState.error,
        errorMessage: res.error,
      );
      state = state.copyWith(commentLoadState: LoadState.idle);
    } catch (e) {
      state = state.copyWith(
        commentLoadState: LoadState.error,
        errorMessage: e.toString(),
      );
      state = state.copyWith(commentLoadState: LoadState.idle);
    }
  }

  Future<String?> createConversation({
    required ConversationDto data,
    required String otherUID,
    required String currentUID,
  }) async {
    state = state.copyWith(conversationLoadState: LoadState.loading);
    try {
      List<BidWithConversation> localconVo =
          conversationRepository.fetchBidsWithConversations();
      if (localconVo.isNotEmpty &&
          localconVo.any((element) => element.otherUID == otherUID)) {
        state = state.copyWith(conversationLoadState: LoadState.success);
        return localconVo
            .firstWhere((element) => element.otherUID == otherUID)
            .conversationId;
      }
      final res = await conversationRepository.createConversation(data);
      if (res.status) {
        conversationRepository.saveBidsConversations(
          BidWithConversation(
            otherUID: otherUID,
            currentUID: currentUID,
            conversationId: res.data!.id,
          ),
        );
        state = state.copyWith(conversationLoadState: LoadState.success);
        return res.data!.id;
      }
      state = state.copyWith(conversationLoadState: LoadState.error);
      state = state.copyWith(conversationLoadState: LoadState.idle);
      return null;
    } catch (e) {
      state = state.copyWith(conversationLoadState: LoadState.error);
      state = state.copyWith(conversationLoadState: LoadState.idle);
      rethrow;
    }
  }

  void fetchComments({
    required int page,
    required String postId,
    bool loadmore = false,
    bool retry = false,
  }) async {
    if (retry) {
      state = state.copyWith(fetchCommentLoadState: LoadState.loading);
    }
    if (loadmore) {
      state = state.copyWith(fetchCommentLoadState: LoadState.loadmore);
    }
    try {
      final res =
          await postsRepository.fetchPostComments(postId: postId, page: page);

      if (res.status) {
        if (!loadmore) {
          state = state.copyWith(
            fetchCommentLoadState: LoadState.success,
            comments: [...res.data!.comments],
          );
        } else {
          state = state.copyWith(
            comments: [...state.comments, ...res.data!.comments],
            fetchCommentLoadState: LoadState.success,
          );
        }
        if (!res.data!.pagination.hasNextPage!) {
          state = state.copyWith(fetchCommentLoadState: LoadState.done);
        }
        return;
      }
      state = state.copyWith(fetchCommentLoadState: LoadState.error);
    } catch (e) {
      state = state.copyWith(fetchCommentLoadState: LoadState.error);
    }
  }

  Future<bool> deletePost(String postId) async {
    try {
      final res = await postsRepository.deletePost(postId);
      return res.status;
    } catch (e) {
      return false;
    }
  }
}
