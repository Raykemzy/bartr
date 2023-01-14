import 'package:bartr/core/utils/colors.dart';
import 'package:flutter/material.dart';

class TabIndicator extends StatelessWidget {
  const TabIndicator({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: currentIndex == 0 ? 2 : 1,
              color: currentIndex == 0
                  ? BartrColors.primary
                  : BartrColors.lightGrey,
            ),
          ),
          Expanded(
              child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: currentIndex == 1 ? 2 : 1,
            color:
                currentIndex == 1 ? BartrColors.primary : BartrColors.lightGrey,
          ),),
        ],
      ),
    );
  }
}
