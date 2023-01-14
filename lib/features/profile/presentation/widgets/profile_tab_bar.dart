import 'package:flutter/material.dart';

import '../../../home/presentation/widgets/home_tab_bar.dart';
import '../../../home/presentation/widgets/tab_indicator.dart';

class ProfileTabBar extends StatelessWidget {
  const ProfileTabBar({
    Key? key,
    this.onTap1,
    this.onTap2,
    required this.currentIndex,
  }) : super(key: key);
  final void Function()? onTap1, onTap2;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TabRow(
              onTap: onTap1,
              text: "Barter",
              icon: "barter",
              index: 0,
              currentIndex: currentIndex,
            ),
            TabRow(
              onTap: onTap2,
              text: "Giveaway",
              icon: "giveaway",
              index: 1,
              currentIndex: currentIndex,
            ),
          ],
        ),
        TabIndicator(
          currentIndex: currentIndex,
        ),
      ],
    );
  }
}