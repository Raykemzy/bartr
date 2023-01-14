import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/helpers/mixins.dart';
import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/home/data/post_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../login/domain/models/login_model.dart';
import 'package:share_plus/share_plus.dart';

class PostActionRow extends HookConsumerWidget with PostMixin {
  const PostActionRow({
    Key? key,
    required this.poste,
    required this.index,
  }) : super(key: key);
  final Post poste;
  final int index;

  void sharePost(String id) {
    Share.share(
      "https://web.mybartr.com/post/$id",
      subject: "Check out this post by @${poste.user?.username} on Bartr.",
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    ValueNotifier<Post> postState = useState(poste);
    Post post = postState.value;
    ValueNotifier<int> count = useState(postState.value.likes!);
    ValueNotifier<bool> isLiked = useState(post.likedBy!.contains(user.id));

    void setPost(Post value) {
      postState.value = value;
    }

    void incrementLikeCount(int counter) {
      setPost(poste.copyWith(likes: (counter)));
      count.value = counter;
    }

    useEffect(
      () {
        final sub = ref
            .read(postsRepository)
            .postCommentsCreateBroadcast(post.id!)
            .listen((event) {
          if (event.likes! != count.value) {
            incrementLikeCount(event.likes ?? 0);
            setPost(post.copyWith(likes: event.likes));
          }
        });
        return () => sub.cancel();
      },
    );

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
      final res = await likePost(post, ref);
      if (!res) {
        changeLikeCount();
        changeLikeStatus();
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CommentsIcon(
                post: post,
              ),
              PostActionButton(
                isLiked: isLiked.value,
                icon: "clap",
                height: 25,
                onTap: () => likeAndUnlikePost(),
                count: count.value,
              ),
              if (post.postType == PostType.Barter && poste.user!.id != user.id)
                PostActionButton(
                  icon: "barter",
                  onTap: () => context.router.push(
                    MakeABidRoute(
                      bidId: post.id!,
                    ),
                  ),
                ),
            ],
          ),
          PostActionButton(
            icon: "share",
            onTap: () {
              sharePost(post.id!);
            },
          ),
        ],
      ),
    );
  }
}

class CommentsIcon extends HookConsumerWidget with NavigationMixin {
  const CommentsIcon({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ValueNotifier<Post> postState = useState(post);
    Post poste = postState.value;
    void setPost(Post value) {
      postState.value = value;
    }

    void incrementCommentCount() =>
        setPost(post.copyWith(totalComments: (post.totalComments ?? 0) + 1));

    useEffect(
      () {
        final sub = ref
            .read(postsRepository)
            .postCommentsCreateBroadcast(post.id!)
            .listen((event) {
          if (event.totalComments! != poste.totalComments!) {
            incrementCommentCount();
            setPost(poste.copyWith(totalComments: event.totalComments));
          }
        });
        return () => sub.cancel();
      },
    );
    return PostActionButton(
      icon: "comments",
      onTap: () {
        navigateToComment(
          context: context,
          post: post,
        );

        ///THIS CHECK HERE IS FOR NESTED NAVIGATION
        ///IF THE USER IS ON THE PROFILE PAGE, IT NAVIGATES TO THE
        ///PROFILECOMMENTSCREEN FROM THE PROFILE AND VICE VERSA
      },
      count: postState.value.totalComments,
    );
  }
}

class PostActionButton extends StatelessWidget {
  const PostActionButton({
    Key? key,
    this.onTap,
    required this.icon,
    this.count,
    this.isLiked = false,
    this.height = 20,
  }) : super(key: key);
  final Function()? onTap;
  final String icon;
  final int? count;
  final bool isLiked;
  final double height;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          AnimatedContainer(
            curve: Curves.bounceInOut,
            duration: const Duration(milliseconds: 100),
            child: SvgPicture.asset(
              "assets/icons/${isLiked ? "clap_fill" : icon}.svg",
              height: height,
            ),
          ),
          const SizedBox(width: 9.0),
          if (count != null)
            Text(
              "$count",
              style: Styles.w600(
                size: 16,
                color: BartrColors.grey,
              ),
            ),
          if (count != null) const SizedBox(width: 34.0),
        ],
      ),
    );
  }
}
