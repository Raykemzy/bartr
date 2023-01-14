import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/general_widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoComment extends StatelessWidget {
  const NoComment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 70.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/comment.svg"),
            const SizedBox(
              height: 30,
            ),
            Text(
              Strings.noComment,
              style: Styles.w600(size: 24, color: BartrColors.black),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              Strings.firstToComment,
              style: Styles.w400(size: 16, color: BartrColors.grey),
            )
          ],
        ),
      ),
    );
  }
}

class NoPost extends StatelessWidget {
  const NoPost({
    Key? key,
    this.isUser = true,
    required this.postType,
  }) : super(key: key);
  final bool isUser;
  final PostType postType;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/${postType == PostType.Barter ? "nobids" : "gift"}.png",
            width: 70,
            color: BartrColors.lightGrey,
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            isUser ? "You have no posts yet" : "No posts yet",
            style: Styles.w500(size: 14, color: BartrColors.black),
          ),
          const SizedBox(
            height: 20,
          ),
          if (isUser)
            AppButton(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 30,
              textSize: 12,
              padding: EdgeInsets.zero,
              text: postType == PostType.Barter
                  ? "Create first post"
                  : "Do a giveaway",
              onTap: () => context.router.push(const CreatePostRoute()),
            ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
