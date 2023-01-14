import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/helpers/mixins.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/post_and_comments/domain/models/single_post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CommentLike extends HookConsumerWidget with PostMixin {
  const CommentLike({Key? key, required this.comment}) : super(key: key);

  final SinglePostComment comment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    ValueNotifier<SinglePostComment> postState = useState(comment);
    SinglePostComment comments = postState.value;
    ValueNotifier<int> count = useState(postState.value.likedBy!.length);
    ValueNotifier<bool> isLiked = useState(comments.likedBy!.contains(user.id));

    void changeLikeCount() {
      if (isLiked.value) {
        count.value == 0 ? count.value = 0 : count.value -= 1;
      } else {
        count.value += 1;
      }
    }

    void changeLikeStatus() {
      if (!isLiked.value) {
        isLiked.value = true;
      } else {
        isLiked.value = false;
      }
    }

    void likeAndUnlikePost() async {
      changeLikeCount();
      changeLikeStatus();
      final res = await likeComment(comment.id!, ref);
      if (!res) {
        changeLikeCount();
        changeLikeStatus();
      }
    }

    return Column(
      children: [
        InkWell(
          onTap: likeAndUnlikePost,
          child: AnimatedContainer(
            curve: Curves.bounceInOut,
            duration: const Duration(milliseconds: 100),
            child: Column(
              children: [
                SvgPicture.asset(
                  "assets/icons/${isLiked.value ? "clap_fill" : "clap"}.svg",
                  height: 15,
                ),
                const SizedBox(height: 6),
                Text(
                  "${count.value}",
                  style: Styles.w400(size: 10),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
