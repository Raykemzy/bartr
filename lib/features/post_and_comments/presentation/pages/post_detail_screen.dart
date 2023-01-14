import 'package:bartr/core/helpers/helper_functions.dart';
import 'package:bartr/core/router/routes.dart' hide Comment;
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/features/post_and_comments/presentation/widgets/header_delegate.dart';
import 'package:bartr/features/post_and_comments/presentation/widgets/comment_textfield.dart';
import 'package:bartr/features/post_and_comments/presentation/widgets/private_comment_view.dart';
import 'package:bartr/general_widgets/bartr_loader.dart';
import 'package:bartr/general_widgets/retry_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../home/data/post_repository_impl.dart';
import '../../../home/presentation/notifier/home_notifier.dart';
import '../../../messages/data/conversation_repositpry_impl.dart';
import '../widgets/public_comment_view.dart';

class PostDetail extends ConsumerStatefulWidget {
  const PostDetail({
    Key? key,
    @PathParam() required this.postId,
  }) : super(key: key);
  final String postId;
  @override
  ConsumerState<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends ConsumerState<PostDetail> {
  final notifier = StateNotifierProvider<PostNotifier, PostState>(
    (_) => PostNotifier(
      _.read(postsRepository),
      _.read(conversationRepository),
    ),
  );
  late FocusNode _focusNode;
  late MentionKey controller;
  late ScrollController _scrollController;
  late PostNotifier _model;

  @override
  void dispose() {
    if (!mounted) {
      _focusNode.dispose();
    }

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _model = ref.read(notifier.notifier);
    _scrollController = ScrollController();
    controller = MentionKey();
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
          if (state.postLoadState == LoadState.success)
            NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
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
              body: (post?.visibility == PostVisiblility.Public)
                  ? PublicCommentView(
                      notifierProvider: notifier,
                    )
                  : PrivateCommentView(
                      notifierProvider: notifier,
                    ),
            ),
          Consumer(
            builder: (context, ref, child) {
              _showSnack(ref, context, widget.postId);
              final newstate =
                  ref.watch(notifier.select((value) => value.commentLoadState));
              final newmodel = ref.read(notifier.notifier);
              return CommentTextField(
                mentionKey: controller,
                isLoading: newstate == LoadState.loading,
                focus: false,
                onTap: () => _comment(newmodel),
                focusNode: _focusNode,
              );
            },
          ),
        ],
      ),
    );
  }

  void _comment(PostNotifier newmodel) {
    newmodel.commentOnPost(
      postId: widget.postId,
      commentText: controller.currentState?.controller?.text ?? '',
    );
  }

  void _showSnack(WidgetRef ref, BuildContext context, String postId) {
    ref.listen<PostState>(notifier, (previous, next) {
      if (next.commentLoadState == LoadState.success) {
        controller.currentState?.controller?.clear();
        FocusScope.of(context).unfocus();

        showSuccess(text: next.message!, context: context);
        _model.fetchComments(postId: widget.postId, page: 1);
        _model.getSinglePost(postId: widget.postId);
      } else if (next.commentLoadState == LoadState.error) {
        showError(text: next.errorMessage!, context: context);
      }
    });
  }
}
