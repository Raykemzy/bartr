import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:bartr/general_widgets/cached_network_image_display.dart';
import 'package:flutter/material.dart';
// import 'dart:math' as math;

import 'package:flutter_svg/svg.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    Key? key,
    required this.user,
    required this.isUserProfile,
    required this.progress,
    required this.maxExtent,
    required this.shrinkOffset,
  }) : super(key: key);

  final BartrUser user;
  final bool isUserProfile;
  final double progress;
  final double maxExtent;
  final double shrinkOffset;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.bounceInOut,
      duration: const Duration(milliseconds: 100),
      padding: EdgeInsets.lerp(
        const EdgeInsets.only(
          bottom: 50,
        ),
        EdgeInsets.only(bottom: 10, left: isUserProfile ? 20 : 50, top: 10),
        progress,
      ),
      alignment: Alignment.lerp(
        Alignment.bottomCenter,
        Alignment.topLeft,
        progress,
      ),
      child: Stack(
        children: [
          AnimatedContainer(
            curve: Curves.bounceInOut,
            height: shrinkOffset >= (maxExtent.toInt() * 0.7)
                ? (maxExtent.toInt() * 0.13)
                : shrinkOffset < (maxExtent.toInt() * 0.6)
                    ? (maxExtent.toInt() * 0.4)
                    : shrinkOffset * 0.3,
            width: shrinkOffset >= (maxExtent.toInt() * 0.7)
                ? (maxExtent.toInt() * 0.13)
                : shrinkOffset < (maxExtent.toInt() * 0.6)
                    ? (maxExtent.toInt() * 0.4)
                    : shrinkOffset * 0.3,
            duration: const Duration(milliseconds: 100),
            child: CachedNetworkDisplay(
              url: user.profilePicture!,
              radius: 70,
            ),
          ),
          Visibility(
            visible: (progress < 0.3),
            child: Positioned(
              right: 5,
              bottom: 5,
              child: SvgPicture.asset(
                  "assets/icons/${(user.verified ?? false) ? 'verified' : 'unverified'}.svg"),
            ),
          )
        ],
      ),
    );
  }
}
