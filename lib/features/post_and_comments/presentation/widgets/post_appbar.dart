import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/router/router.dart';
import 'package:bartr/features/post_and_comments/domain/models/single_post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/textstyles.dart';
import '../../../home/presentation/widgets/post_header.dart';

class PostAppBar extends HookConsumerWidget {
  final SinglePost singlePost;
  final double progress;
  final void Function() onDeletePost;
  const PostAppBar({
    Key? key,
    required this.singlePost,
    required this.progress,
    required this.onDeletePost
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.read(currentUserProvider);
    ValueNotifier<String> valueChoose = useState("");
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.fromLTRB(10, 16, 10, 0),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset("assets/icons/arrow-left.svg"),
          ),
        ),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 100),
          opacity: progress,
          child: Text(
            'Comments',
            style: TextStyle.lerp(
              Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Colors.white),
              Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Colors.black),
              progress,
            ),
          ),
        ),
        PopupMenuButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.zero,
            position: PopupMenuPosition.under,
            icon: Container(
              margin: const EdgeInsets.only(right: 15, top: 19),
              padding: const EdgeInsets.all(9),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset("assets/icons/menu.svg"),
            ),
            color: Colors.white,
            elevation: 20,
            enabled: true,
            onSelected: (String value) {
              valueChoose.value = value;
            },
            itemBuilder: (context) => [
                  if (currentUser.id != singlePost.user!.id)
                    PopupMenuItem(
                      value: "first",
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Report Post",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      onTap: () {
                        context.router.push(
                          FeedBackViewRoute(
                            postID: singlePost.id,
                          ),
                        );
                      },
                    ),
                  if (currentUser.id == singlePost.user!.id)
                    PopupMenuItem(
                      value: "first",
                      child: const Align(
                        child: Text(
                          "Edit Post",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onTap: () {
                        context.router
                            .push(EditPostPageRoute(singlePost: singlePost));
                      },
                    ),
                  if (currentUser.id == singlePost.user!.id)
                    PopupMenuItem(
                      value: "Second",
                      child: Align(
                        child: Text(
                          "Delete post",
                          textAlign: TextAlign.center,
                          style: Styles.w500(color: BartrColors.red),
                        ),
                      ),
                      onTap: () => _delete(context, singlePost.id ?? ""),
                    ),
                ]),
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
          onDeletePost: onDeletePost,
          postId: postId,
        );
      },
      context: context,
    );
  }
}
