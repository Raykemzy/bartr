import 'package:bartr/core/helpers/helper_functions.dart';
import 'package:bartr/core/helpers/mixins.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:bartr/general_widgets/cached_network_image_display.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/textstyles.dart';
import 'follow_unfollow_button.dart';

class FollowTile extends StatelessWidget with NavigationMixin {
  const FollowTile({
    Key? key,
    required this.user,
    required this.currentUser,
  }) : super(key: key);

  final Follow user;
  final BartrUser currentUser;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (user.id! == currentUser.id) {
          // AutoTabsRouter.of(context).setActiveIndex(4);
          null;
        } else {
          navigateToProfile(
            context: context,
            userId: user.id!,
            username: user.username!,
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CachedNetworkDisplay(
                  url: user.profilePicture!,
                  width: 40,
                  height: 40,
                  radius: 70,
                ),
                SizedBox(
                  width: Helpers.width(context) * 0.03,
                ),
                SizedBox(
                  width: Helpers.width(context) / 1.75,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName!,
                        style: Styles.w600(
                          size: 16,
                          color: BartrColors.black,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "@${user.username!}",
                        style: Styles.w400(
                          size: 12,
                          color: BartrColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (user.id! != currentUser.id)
              FollowUnfollowButton(
                user: user,
                currentuser: currentUser,
              ),
          ],
        ),
      ),
    );
  }
}
