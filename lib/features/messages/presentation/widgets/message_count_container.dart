import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:flutter/material.dart';

class MessageCountContainer extends StatelessWidget {
  final int count;
  const MessageCountContainer({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: BartrColors.primaryFade,
      ),
      child: Center(
        child: Text(
          (count > 9) ? Strings.ninePlus : count.toString(),
          style: Styles.w400(
            size: 12,
            color: BartrColors.white,
          ),
        ),
      ),
    );
  }
}
