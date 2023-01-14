import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:flutter/material.dart';
import 'profile_app_bar.dart';
import 'profile_cover_photo.dart';
import 'profile_picture.dart';
import 'profile_text.dart';

class ProfileHeaderDelegate extends SliverPersistentHeaderDelegate {
  const ProfileHeaderDelegate({
    required this.user,
    required this.currentUser,
    required this.maxtExtent,
    required this.mintExtent,
    required this.isUserProfile,
  });
  final BartrUser user;
  final BartrUser currentUser;
  final double maxtExtent, mintExtent;
  final bool isUserProfile;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = shrinkOffset / maxExtent;
    return Material(
      color: BartrColors.white,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          ProfileCoverPhoto(
            currentUser: currentUser,
            maxExtent: maxExtent,
            progress: progress,
            user: user,
            shrinkOffset: shrinkOffset,
          ),
          ProfileAppBar(
            isUserProfile: isUserProfile,
            user: user,
          ),
          ProfileImage(
            isUserProfile: isUserProfile,
            shrinkOffset: shrinkOffset,
            user: user,
            progress: progress,
            maxExtent: maxExtent,
          ),
          ProfileText(progress: progress, user: user),
        ],
      ),
    );
  }

  @override
  double get maxExtent => maxtExtent; // 253;

  @override
  double get minExtent => mintExtent; //75;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
