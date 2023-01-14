import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/helpers/mixins.dart';
import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:bartr/general_widgets/app_button.dart';
import 'package:bartr/general_widgets/cached_network_image_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/config/configure_dependencies.dart';

class PostUserHeader extends HookConsumerWidget with NavigationMixin {
  PostUserHeader({
    Key? key,
    required this.post,
    required this.onDeletePost,
  }) : super(key: key);

  final Post post;
  final void Function() onDeletePost;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    ValueNotifier<String> valueChoose = useState("");
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            //THIS CHECK IS TO ENSURE A USER CAN ONLY ACCESS THEIR OWN
            ///PROFILE FROM THE PROFILE TAB.
            if (post.user!.id! == currentUser.id) {
              // AutoTabsRouter.of(context).setActiveIndex(4);
              null;
            } else {
              navigateToProfile(
                context: context,
                userId: post.user!.id!,
                username: post.user!.username!,
              );
            }
          },
          child: Row(
            children: [
              CachedNetworkDisplay(
                height: 40,
                width: 40,
                url: post.user!.profilePicture ?? "",
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        post.user!.fullName ?? "",
                        style: Styles.w500(size: 16),
                      ),
                      const SizedBox(width: 8),
                      if (post.user?.verified != null && post.user!.verified!)
                        SvgPicture.asset("assets/icons/verified.svg",
                            height: 15)
                    ],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "@${post.user!.username ?? ""}",
                    style: Styles.w400(size: 12, color: BartrColors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          children: [
            // if (currentUser.id != post.user!.id)
            //   FollowButton(
            //     user: post.user!,
            //   ),
            const SizedBox(
              width: 16,
            ),
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: BartrColors.greyFill,
              ),
              child: PopupMenuButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.zero,
                  position: PopupMenuPosition.under,
                  icon: const Icon(
                    Icons.more_horiz,
                  ),
                  color: Colors.white,
                  elevation: 20,
                  enabled: true,
                  onSelected: (String value) {
                    valueChoose.value = value;
                  },
                  itemBuilder: (currentUser.id != post.user!.id &&
                          (post.postType == PostType.Barter))
                      ? (context) => [
                            PopupMenuItem(
                              value: "first",
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text("Make A Bid"),
                              ),
                              onTap: () => context.router.push(
                                MakeABidRoute(
                                  bidId: post.id!,
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              value: "Second",
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Report Post",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                              onTap: () => context.router.push(
                                FeedBackViewRoute(postID: post.id),
                              ),
                            ),
                          ]
                      : (context) => [
                            if (currentUser.id != post.user!.id &&
                                (post.postType == PostType.Giveaway))
                              PopupMenuItem(
                                value: "First",
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Report Post",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                onTap: () => context.router.push(
                                  FeedBackViewRoute(postID: post.id),
                                ),
                              ),
                            if (currentUser.id == post.user!.id)
                              PopupMenuItem(
                                value: "Second",
                                child: const Text(
                                  "Edit Post",
                                  textAlign: TextAlign.center,
                                ),
                                onTap: () => context.router.push(
                                  EditPostPageRoute(post: post),
                                ),
                              ),
                            if (currentUser.id == post.user!.id)
                              PopupMenuItem(
                                value: "third",
                                child: Text(
                                  "Delete post",
                                  textAlign: TextAlign.center,
                                  style: Styles.w500(color: BartrColors.red),
                                ),
                                onTap: () => _delete(context, post.id ?? ""),
                              ),
                          ]),
            ),
          ],
        ),
      ],
    );
  }

  Future<Object?> _delete(BuildContext context, String postId) {
    return showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, anim, anim2, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(anim),
          child: child,
        );
      },
      pageBuilder: (context, anim, anim2) {
        return DeletePostDialog(
          postId: postId,
          onDeletePost: onDeletePost,
        );
      },
      context: context,
    );
  }
}

class DeletePostDialog extends StatelessWidget {
  const DeletePostDialog({
    super.key,
    required this.postId,
    required this.onDeletePost,
  });
  final String postId;
  final void Function() onDeletePost;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Are you sure you want to delete this post?",
              style: Styles.w700(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: "No",
                    radius: 10,
                    height: 45,
                    color: BartrColors.green,
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: AppButton(
                    radius: 10,
                    height: 45,
                    text: "Yes",
                    textColor: BartrColors.red,
                    color: BartrColors.redLight,
                    onTap: () {
                      onDeletePost();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
