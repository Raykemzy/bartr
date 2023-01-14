import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:bartr/features/profile/presentation/widgets/profile_header_text.dart';
import 'package:flutter/material.dart';

class ProfileHeaderTextRow extends StatelessWidget {
  const ProfileHeaderTextRow({
    Key? key,
    required this.posts,
    required this.bartrUser,
  }) : super(key: key);

  final List<Post> posts;
  final BartrUser bartrUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 42),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ProfileHeaderText(
            count: posts.length,
            text: posts.length > 1 ? "  Posts" : "  Post",
          ),
          const ProfileDot(),
          InkWell(
            onTap: () => context.router.push(
              FollowUnfollowViewRoute(
                currentIndex: 0,
                userId: bartrUser.id!,
                username: bartrUser.username!,
              ),
            ),
            child: ProfileHeaderText(
              count: bartrUser.followers!.length,
              text: bartrUser.followers!.length == 1
                  ? "  Follower"
                  : "  Followers",
            ),
          ),
          const ProfileDot(),
          InkWell(
            onTap: () => context.router.push(
              FollowUnfollowViewRoute(
                currentIndex: 1,
                userId: bartrUser.id!,
                username: bartrUser.username!,
              ),
            ),
            child: ProfileHeaderText(
              count: bartrUser.following!.length,
              text: bartrUser.following!.length > 1
                  ? "  Following"
                  : "  Following",
            ),
          ),
          //const ProfileDot()
        ],
      ),
    );
  }
}

class ProfileDot extends StatelessWidget {
  const ProfileDot({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 4,
      width: 4,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: BartrColors.grey,
      ),
    );
  }
}
