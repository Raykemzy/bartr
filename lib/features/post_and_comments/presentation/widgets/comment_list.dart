import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/config/configure_dependencies.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/enums.dart';
import '../../../../general_widgets/bartr_loader.dart';
import '../../domain/models/single_post_model.dart';
import 'comment_card.dart';
import 'no_comment.dart';
import 'post_delegate.dart';
import 'private_widget.dart';

class CommentsList extends ConsumerWidget {
  const CommentsList({
    Key? key,
    required this.post,
    required this.comments,
    required this.isLoadingmore,
  }) : super(key: key);

  final SinglePost? post;
  final List<SinglePostComment>? comments;
  final bool isLoadingmore;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    var newComments = comments;

    return (newComments)!.isEmpty
        ? const NoComment()
        : Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(top: 20, bottom: 150),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: newComments.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var comment = newComments[index];
                      return Column(
                        children: [
                          if (index == 0) PostDelegate(post: post!),
                          PostCommentCard(
                            key: ValueKey(comment.id!),
                            comment: comment,
                            post: post!,
                          ),
                          if (post?.visibility == PostVisiblility.Private &&
                              user.id != post?.user?.id &&
                              newComments[index] == newComments.last)
                            const PrivateWidget()
                        ],
                      );
                    },
                  ),
                ),
                if (isLoadingmore)
                  const BartrLoader(
                    color: BartrColors.primary,
                  ),
                if (isLoadingmore)
                  const SizedBox(
                    height: 100,
                  )
              ],
            ),
          );
  }
}
