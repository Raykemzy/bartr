import 'package:bartr/features/post_and_comments/domain/models/single_post_model.dart';
import 'package:bartr/features/post_and_comments/presentation/widgets/no_comment.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/config/configure_dependencies.dart';
import 'comment_list.dart';
import 'post_delegate.dart';
import 'private_widget.dart';

class CommentViewWidget extends ConsumerWidget {
  const CommentViewWidget({
    Key? key,
    required this.post,
    required this.comments,
    required this.isLoadingMore,
  }) : super(key: key);

  final List<SinglePostComment>? comments;
  final SinglePost? post;
  final bool isLoadingMore;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    bool isPrivateWithCurrentUserComment =
        (comments!.any((element) => element.user?.id == user.id) ||
            post?.user?.id == user.id);

    bool currentUserHasAccess = (user.id == post?.user?.id);

    return (comments!.isEmpty)
        ? Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  PostDelegate(post: post!),
                  if (!currentUserHasAccess)
                    const PrivateWidget()
                  else
                    const NoComment(),
                ],
              ),
            ),
          )
        : currentUserHasAccess
            ? CommentsList(
                isLoadingmore: isLoadingMore,
                post: post,
                comments: comments,
              )
            : isPrivateWithCurrentUserComment
                ? CommentsList(
                    isLoadingmore: isLoadingMore,
                    post: post,
                    comments: comments!
                        .where((element) => element.user!.id == user.id)
                        .toList(),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          PostDelegate(post: post!),
                          const PrivateWidget(),
                        ],
                      ),
                    ),
                  );
  }
}
