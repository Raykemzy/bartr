import 'package:bartr/core/helpers/helper_functions.dart';
import 'package:bartr/core/router/routes.dart';
import 'package:bartr/features/post_and_comments/presentation/widgets/comment_textfield.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/colors.dart';
import '../../../../general_widgets/bartr_loader.dart';
import '../../../../general_widgets/retry_widget.dart';
import '../../../home/data/post_repository_impl.dart';
import '../../../messages/data/conversation_repositpry_impl.dart';
import '../widgets/post_delegate.dart';
import '../widgets/private_comment_view.dart';
import '../widgets/public_comment_view.dart';

class CommentScreen extends StatefulHookConsumerWidget {
  const CommentScreen({
    Key? key,
    @PathParam() required this.postId,
  }) : super(key: key);
  final String postId;
  @override
  ConsumerState<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends ConsumerState<CommentScreen> {
  final postNotifier = StateNotifierProvider<PostNotifier, PostState>(
    (_) => PostNotifier(
      _.read(postsRepository),
      _.read(conversationRepository),
    ),
  );
  late FocusNode _focusNode;
  late MentionKey controller;
  late PostNotifier _model;
  int page = 1;
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
    _model = ref.read(postNotifier.notifier);
    controller = MentionKey();
    _focusNode = FocusNode();
    _model.getSinglePost(postId: widget.postId);
    _model.fetchComments(postId: widget.postId, page: 1);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(postNotifier);
    final post = ref.watch(postNotifier).currentPost;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.only(left: 25),
            padding: EdgeInsets.zero,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back_sharp),
          ),
        ),
        title: Text(
          'Comment',
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (state.postLoadState == LoadState.error)
                Center(
                  child: RetryWidget(
                    onRetry: () {
                      _model.getSinglePost(
                        postId: widget.postId,
                        retry: true,
                      );
                      _model.fetchComments(
                        postId: widget.postId,
                        page: 1,
                      );
                    },
                  ),
                ),
              if (state.postLoadState == LoadState.loading)
                const Center(
                  child: BartrLoader(
                    size: 50,
                    color: BartrColors.primary,
                  ),
                ),
              if (state.currentPost != null &&
                  state.fetchCommentLoadState == LoadState.loading)
                PostDelegate(post: post!),
              if (state.fetchCommentLoadState == LoadState.error)
                Center(
                  child: RetryWidget(
                    onRetry: () => _model.fetchComments(
                      postId: widget.postId,
                      page: 1,
                      retry: true,
                    ),
                  ),
                ),
              (post?.visibility == PostVisiblility.Public)
                  ? PublicCommentView(
                      notifierProvider: postNotifier,
                      isCommentView: true,
                    )
                  : PrivateCommentView(
                      notifierProvider: postNotifier,
                      isCommentView: true,
                    ),
            ],
          ),
          Consumer(
            builder: (context, ref, child) {
              _showSnack(ref, context, widget.postId);
              final newstate = ref.watch(
                  postNotifier.select((value) => value.commentLoadState));
              final newmodel = ref.read(postNotifier.notifier);
              return CommentTextField(
                mentionKey: controller,
                isLoading: newstate == LoadState.loading,
                focus: true,
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
    ref.listen<PostState>(postNotifier, (previous, next) {
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
