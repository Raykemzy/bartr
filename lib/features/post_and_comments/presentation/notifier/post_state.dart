import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/features/post_and_comments/domain/models/single_post_model.dart';

class PostState {
  final LoadState postLoadState;
  final LoadState commentLoadState;
  final LoadState fetchCommentLoadState;
  final LoadState conversationLoadState;
    final LoadState deLetePostState;
  final String? message;
  final String? errorMessage;
  final SinglePost? currentPost;
  final List<SinglePostComment> comments;

  PostState({
    required this.postLoadState,
    required this.commentLoadState,
    required this.fetchCommentLoadState,
    required this.conversationLoadState,
    required this.deLetePostState,
    this.currentPost,
    this.message,
    this.errorMessage,
    required this.comments,
  });

  factory PostState.initial() {
    return PostState(
      postLoadState: LoadState.loading,
      commentLoadState: LoadState.idle,
      fetchCommentLoadState: LoadState.loading,
      conversationLoadState: LoadState.idle,
      currentPost: null,
      comments: [],
      deLetePostState: LoadState.idle,
    );
  }

  PostState copyWith({
    LoadState? postLoadState,
    LoadState? commentLoadState,
    SinglePost? currentPost,
    String? message,
    String? errorMessage,
    LoadState? conversationLoadState,
    LoadState? fetchCommentLoadState,
    List<SinglePostComment>? comments,
     LoadState? deLetePostState,
  }) {
    return PostState(
      currentPost: currentPost ?? this.currentPost,
      postLoadState: postLoadState ?? this.postLoadState,
      commentLoadState: commentLoadState ?? this.commentLoadState,
      errorMessage: errorMessage ?? this.errorMessage,
      message: message ?? this.message,
      conversationLoadState:
          conversationLoadState ?? this.conversationLoadState,
      fetchCommentLoadState:
          fetchCommentLoadState ?? this.fetchCommentLoadState,
      comments: comments ?? this.comments,
      deLetePostState: deLetePostState ?? this.deLetePostState,
    );
  }
}
