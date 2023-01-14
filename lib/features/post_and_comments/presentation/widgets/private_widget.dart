import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/textstyles.dart';

class PrivateWidget extends StatelessWidget {
  const PrivateWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset("assets/icons/comment.svg"),
            const SizedBox(height: 30),
            Text(
              "This post is private",
              style: Styles.w600(size: 24, color: BartrColors.black),
            ),
            const SizedBox(height: 24),
            Text(
              "But you can leave a comment",
              style: Styles.w400(size: 16, color: BartrColors.deepgrey),
            )
          ],
        ),
      ),
    );
  }
}
