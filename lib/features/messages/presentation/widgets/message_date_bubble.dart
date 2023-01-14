import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:flutter/material.dart';

class MessageDateBubble extends StatelessWidget {
  final String header;
  const MessageDateBubble({
    Key? key,
    required this.header,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: BartrColors.bubbleGrey,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            header,
            style: Styles.w400(
              size: 10,
              color: BartrColors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
