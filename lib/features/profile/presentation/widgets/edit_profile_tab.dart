import 'package:bartr/features/home/presentation/widgets/home_tab_bar.dart';
import 'package:bartr/features/home/presentation/widgets/tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppTabBar extends ConsumerWidget {
  const AppTabBar({
    required this.title1,
    required this.title2,
    required this.changeIndex0,
    required this.changeIndex1,
    required this.currentIndex,
    Key? key,
  }) : super(key: key);
  final void Function(int) changeIndex0, changeIndex1;
  final int currentIndex;
  final String title1, title2;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          children: [
            TabRow(
              hasIcon: false,
              onTap: () => changeIndex0(0),
              text: title1,
              index: 0,
              currentIndex: currentIndex,
            ),
            TabRow(
              hasIcon: false,
              onTap: () => changeIndex1(1),
              text: title2,
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
