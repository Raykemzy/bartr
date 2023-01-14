import 'package:bartr/core/utils/textstyles.dart';
import 'package:flutter/material.dart';

class ProfileHeaderText extends StatelessWidget {
  const ProfileHeaderText({
    Key? key,
    required this.count,
    required this.text,
  }) : super(key: key);

  final int count;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: count.toString(),
        style: Styles.w700(
          size: 12,
        ),
        children: [
          TextSpan(
            text: text,
            style: Styles.w400(
              size: 12,
            ),
          ),
        ],
      ),
    );
  }
}