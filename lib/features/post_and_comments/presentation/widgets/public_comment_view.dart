import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/features/post_and_comments/domain/models/single_post_model.dart';
import 'package:bartr/features/post_and_comments/presentation/notifier/post_notifier.dart';
import 'package:bartr/features/post_and_comments/presentation/notifier/post_state.dart';
import 'package:bartr/features/post_and_comments/presentation/widgets/comment_list.dart';
import 'package:bartr/general_widgets/bartr_loader.dart';
import 'package:bartr/general_widgets/retry_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/colors.dart';
import 'no_comment.dart';
import 'post_delegate.dart';

class PublicCommentView extends ConsumerStatefulWidget {
  const PublicCommentView({
    required this.notifierProvider,
    this.isCommentView = false,
    super.key,
  });
  final StateNotifierProvider<PostNotifier, PostState>
      notifierProvider;
  final bool isCommentView;

  @override
  ConsumerState<PublicCommentView> createState() => _PublicCommentViewState();
}

class _PublicCommentViewState extends ConsumerState<PublicCommentView> {
  late PostNotifier _model;
  @override
  void initState() {
    super.initState();
    _model = ref.read(widget.notifierProvider.notifier);
    ref.listenManual<PostState>(widget.notifierProvider, (previous, next) {
      if (next.commentLoadState == LoadState.success) {
        page = 1;
      }
    });
  }

  int page = 1;
  bool _loadMore(PostState state, ScrollEndNotification not, SinglePost? post) {
    if (state.fetchCommentLoadState == LoadState.done) {
      return true;
    } else {
      if (not.metrics.pixels == not.metrics.maxScrollExtent &&
          not.metrics.axisDirection == AxisDirection.down) {
        setState(() {
          page = page + 1;
        });
        _model.fetchComments(
          loadmore: true,
          page: page,
          postId: post!.id!,
        );
        return false;
      } else {
        return true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.notifierProvider);
    return (state.fetchCommentLoadState == LoadState.loading)
        ? const BartrLoader(
            size: 50,
            color: BartrColors.primary,
          )
        : (state.fetchCommentLoadState == LoadState.error)
            ? Center(
                child: RetryWidget(
                  onRetry: () => _model.fetchComments(
                    postId: state.currentPost!.id!,
                    page: 1,
                    retry: true,
                  ),
                ),
              )
            : state.comments.isEmpty
                ? _emptyCommentView(state, state.currentPost)
                : widget.isCommentView
                    ? NotificationListener<ScrollEndNotification>(
                        onNotification: (not) {
                          return _loadMore(state, not, state.currentPost);
                        },
                        child: CommentsList(
                          post: state.currentPost,
                          comments: state.comments,
                          isLoadingmore:
                              state.fetchCommentLoadState == LoadState.loadmore,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (state.currentPost != null)
                            NotificationListener<ScrollEndNotification>(
                              onNotification: (not) {
                                return _loadMore(state, not, state.currentPost);
                              },
                              child: CommentsList(
                                post: state.currentPost,
                                comments: state.comments,
                                isLoadingmore: state.fetchCommentLoadState ==
                                    LoadState.loadmore,
                              ),
                            ),
                        ],
                      );
  }
}

SingleChildScrollView _emptyCommentView(PostState state, SinglePost? post) {
  return SingleChildScrollView(
    child: Column(
      children: [
        if (state.currentPost != null) PostDelegate(post: post!),
        const NoComment(),
      ],
    ),
  );
}
