import 'package:bartr/features/post_and_comments/presentation/widgets/comment_list_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/enums.dart';
import '../../../../general_widgets/bartr_loader.dart';
import '../../../../general_widgets/retry_widget.dart';
import '../../domain/models/single_post_model.dart';
import '../notifier/post_notifier.dart';
import '../notifier/post_state.dart';

class PrivateCommentView extends ConsumerStatefulWidget {
  const PrivateCommentView({
    required this.notifierProvider,
    this.isCommentView = false,
    super.key,
  });
  final StateNotifierProvider<PostNotifier, PostState> notifierProvider;

  final bool isCommentView;
  @override
  ConsumerState<PrivateCommentView> createState() => _PrivateCommentViewState();
}

class _PrivateCommentViewState extends ConsumerState<PrivateCommentView> {
  late PostNotifier _model;
  int page = 1;
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
            : widget.isCommentView
                ? NotificationListener<ScrollEndNotification>(
                    onNotification: (not) {
                      return _loadMore(state, not, state.currentPost);
                    },
                    child: CommentViewWidget(
                      post: state.currentPost,
                      comments: state.comments,
                      isLoadingMore:
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
                          child: CommentViewWidget(
                            post: state.currentPost,
                            comments: state.comments,
                            isLoadingMore: state.fetchCommentLoadState ==
                                LoadState.loadmore,
                          ),
                        ),
                    ],
                  );
  }
}
