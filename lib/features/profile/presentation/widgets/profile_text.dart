import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:flutter/material.dart';

class ProfileText extends StatelessWidget {
  const ProfileText({
    Key? key,
    required this.progress,
    required this.user,
  }) : super(key: key);

  final double progress;
  final BartrUser user;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.bounceInOut,
      duration: const Duration(milliseconds: 100),
      padding: EdgeInsets.lerp(
        EdgeInsets.zero,
        const EdgeInsets.only(bottom: 16),
        progress,
      ),
      alignment: Alignment.lerp(
        Alignment.bottomCenter,
        Alignment.center,
        progress,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            user.fullName ?? "",
            style: TextStyle.lerp(
              TextStyle.lerp(
                const TextStyle(
                  fontSize: 16,
                  color: BartrColors.primary,
                  fontWeight: FontWeight.w500,
                  // shadows: [
                  //   Shadow(
                  //     color: BartrColors.deepgrey,
                  //     blurRadius: 10,
                  //   ),
                  // ],
                ),
                const TextStyle(
                  fontSize: 14,
                  color: BartrColors.white,
                  fontWeight: FontWeight.w500,
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                    ),
                  ],
                ),
                progress,
              ),
              const TextStyle(
                fontSize: 14,
                color: BartrColors.white,
                fontWeight: FontWeight.w500,
                shadows: [
                  Shadow(
                    blurRadius: 10,
                  ),
                ],
              ),
              progress,
            ),
          ),
          Text(
            "@${user.username}",
            style: TextStyle.lerp(
              Styles.w400(size: 10, color: BartrColors.black),
              const TextStyle(
                fontSize: 14,
                color: BartrColors.white,
                fontWeight: FontWeight.w400,
                shadows: [
                  Shadow(
                    blurRadius: 10,
                  ),
                ],
              ),
              progress,
            ),
          ),
        ],
      ),
    );
  }
}
