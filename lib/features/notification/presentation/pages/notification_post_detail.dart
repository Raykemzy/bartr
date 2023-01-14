import 'package:bartr/core/router/routes.dart' hide Comment;
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/features/home/presentation/notifier/home_notifier.dart';
import 'package:bartr/features/post_and_comments/presentation/widgets/comment_card.dart';
import 'package:bartr/features/post_and_comments/presentation/widgets/header_delegate.dart';
import 'package:bartr/general_widgets/bartr_loader.dart';
import 'package:bartr/general_widgets/retry_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../home/data/post_repository_impl.dart';
import '../../../messages/data/conversation_repositpry_impl.dart';
import '../../../post_and_comments/presentation/widgets/post_delegate.dart';

class NotificationPostDetail extends ConsumerStatefulWidget {
  const NotificationPostDetail({
    Key? key,
    @PathParam() required this.postId,
    required this.senderId,
  }) : super(key: key);
  final String postId;
  final String senderId;
  @override
  ConsumerState<NotificationPostDetail> createState() =>
      _NotificationPostDetailState();
}

class _NotificationPostDetailState
    extends ConsumerState<NotificationPostDetail> {
  final notifier = StateNotifierProvider<PostNotifier, PostState>(
    (_) => PostNotifier(
      _.read(postsRepository),
      _.read(conversationRepository),
    ),
  );
  late FocusNode _focusNode;
  late TextEditingController controller;
  late ScrollController _scrollController;
  late PostNotifier _model;
  @override
  void dispose() {
    if (!mounted) {
      _focusNode.dispose();
      controller.dispose();
    }

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _model = ref.read(notifier.notifier);
    _scrollController = ScrollController();
    controller = TextEditingController();
    _focusNode = FocusNode();
    _model.getSinglePost(postId: widget.postId);
    _model.fetchComments(postId: widget.postId, page: 1);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notifier);
    final post = state.currentPost;

    return Scaffold(
      body: Stack(
        children: [
          NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                if (state.postLoadState == LoadState.success)
                  SliverPersistentHeader(
                    floating: false,
                    pinned: true,
                    delegate: MyHeaderDelegate(
                      post: post!,
                      onDeletePost: () async {
                        final res = await _model.deletePost(post.id!);
                        if (res) {
                          ref.read(homeNotifier.notifier).fetchPosts(page: 1);
                          context.router.pop();
                        }
                      },
                    ),
                  ),
              ];
            },
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (state.postLoadState == LoadState.success && post != null)
                  PostDelegate(post: post),
                if (state.fetchCommentLoadState != LoadState.error &&
                    state.comments.isNotEmpty &&
                    post != null)
                  PostCommentCard(
                    comment: state.comments.firstWhere(
                      (element) => element.user!.id == widget.senderId,
                    ),
                    post: post,
                  ),
              ],
            ),
          ),
          if (state.postLoadState == LoadState.loading)
            const BartrLoader(
              size: 50,
              color: BartrColors.primary,
            ),
          if (state.postLoadState == (LoadState.error) ||
              state.postLoadState == (LoadState.other))
            Center(
              child: RetryWidget(
                canRetry: state.postLoadState == (LoadState.error),
                errorMessage: state.errorMessage,
                onRetry: () => ref.read(notifier.notifier).getSinglePost(
                      postId: widget.postId,
                      retry: true,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
