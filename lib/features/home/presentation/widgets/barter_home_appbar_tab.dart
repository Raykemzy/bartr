import 'package:bartr/features/home/presentation/widgets/home_tab_bar.dart';
import 'package:bartr/features/home/presentation/widgets/tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BartrHomeTabBar extends ConsumerWidget {
  const BartrHomeTabBar({
    required this.changeIndex0,
    required this.changeIndex1,
    required this.currentIndex,
    Key? key,
  }) : super(key: key);
  final void Function(int) changeIndex0, changeIndex1;
  final int currentIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Column(
      children: [
        Row(
          children: [
            TabRow(
              onTap: () => changeIndex0(0),
              text: "Barter",
              icon: "barter",
              index: 0,
              currentIndex: currentIndex,
            ),
            TabRow(
              onTap: () => changeIndex1(1),
              text: "Giveaway",
              icon: "giveaway",
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
