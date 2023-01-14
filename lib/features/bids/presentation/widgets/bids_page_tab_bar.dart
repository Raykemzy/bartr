import 'package:bartr/features/home/presentation/widgets/home_tab_bar.dart';
import 'package:bartr/features/home/presentation/widgets/tab_indicator.dart';
import 'package:flutter/material.dart';

class BidsTabBar extends StatelessWidget {
  final void Function(int) changeIndex0, changeIndex1;
  final int currentIndex;
  const BidsTabBar({
    Key? key,
    required this.changeIndex0,
    required this.changeIndex1,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TabRow(
              onTap: () => changeIndex0(0),
              text: "Received",
              index: 0,
              currentIndex: currentIndex,
            ),
            TabRow(
              onTap: () => changeIndex1(1),
              text: "Sent",
              index: 1,
              currentIndex: currentIndex,
            ),
          ],
        ),
        TabIndicator(currentIndex: currentIndex),
      ],
    );
  }
}
