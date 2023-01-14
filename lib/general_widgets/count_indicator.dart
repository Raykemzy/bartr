import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../core/utils/colors.dart';

class CountIndicator extends StatelessWidget {
  const CountIndicator({
    Key? key,
    required this.isSelected,
    required this.count,
  }) : super(key: key);

  final bool isSelected;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15,
      width: 15,
      decoration: BoxDecoration(
        color: AutoTabsRouter.of(context).activeIndex == 2
            ? Colors.transparent
            : BartrColors.primary,
        shape: BoxShape.circle,
      ),
      child: Text(
        "$count",
        style: TextStyle(
          fontSize: 10,
          color: !isSelected
              ? BartrColors.greyFill
              : AutoTabsRouter.of(context).activeIndex == 2
                  ? Colors.transparent
                  : BartrColors.primary,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
