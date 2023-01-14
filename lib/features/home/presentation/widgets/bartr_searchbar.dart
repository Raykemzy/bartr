import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../notifier/home_notifier.dart';

class BartrHomeSearchBar extends ConsumerWidget implements PreferredSizeWidget {
  const BartrHomeSearchBar({
    Key? key,
    required this.tabController,
  }) : super(key: key);
  final TabController tabController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeNotifier);

    return AppBar(
      centerTitle: true,
      elevation: 1,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Column(
          children: [
            TabBar(
              indicatorColor: BartrColors.primary,
              controller: tabController,
              tabs: [
                TabRowed(
                  onTap: () {
                    tabController.animateTo(0);
                  },
                  text: "Barter",
                  icon: "barter",
                  index: 0,
                  currentIndex: state.currentIndex,
                ),
                TabRowed(
                  onTap: () {
                    tabController.animateTo(1);
                  },
                  text: "Giveaway",
                  icon: "giveaway",
                  index: 1,
                  currentIndex: state.currentIndex,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    this.onChanged,
    this.onFilter,
    this.onTap,
    this.autoFocus = false,
    this.height = 48,
    this.suffix,
    this.hintText = "Search ...",
    this.margin,
    this.readOnly = false,
  }) : super(key: key);
  final void Function(String?)? onChanged;
  final void Function()? onFilter, onTap;
  final bool autoFocus;
  final double height;
  final Widget? suffix;
  final String hintText;
  final EdgeInsetsGeometry? margin;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: 8),
      height: height,
      child: Center(
        child: TextField(
          readOnly: readOnly,
          autofocus: autoFocus,
          onTap: onTap,
          onChanged: onChanged,
          textAlign: TextAlign.justify,
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: SvgPicture.asset(
              "assets/icons/search-normal.svg",
              color: BartrColors.black,
              height: 24,
              width: 24,
              fit: BoxFit.scaleDown,
            ),
            suffixIcon: suffix ??
                InkWell(
                  onTap: onFilter,
                  child: SvgPicture.asset(
                    "assets/icons/filter.svg",
                    color: BartrColors.black,
                    height: 24,
                    width: 24,
                    fit: BoxFit.scaleDown,
                  ),
                ),
            hintStyle: const TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 14,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: const BorderSide(color: BartrColors.grey, width: 0.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: const BorderSide(color: BartrColors.grey, width: 0.5),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide:
                  const BorderSide(color: BartrColors.greyFill, width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide:
                  const BorderSide(color: BartrColors.primary, width: 0.5),
            ),
          ),
        ),
      ),
    );
  }
}

class TabRowed extends StatelessWidget {
  const TabRowed({
    Key? key,
    required this.onTap,
    required this.text,
    this.icon,
    required this.index,
    required this.currentIndex,
    this.hasIcon = true,
  }) : super(key: key);
  final void Function()? onTap;
  final String text;
  final String? icon;
  final int index, currentIndex;
  final bool hasIcon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          0,
          icon == null ? 15 : 10,
          0,
          icon == null ? 15 : 20,
        ),
        child: icon == null
            ? Center(
                child: Text(
                  text,
                  style: Styles.w700(
                    size: 14,
                    color: currentIndex == index ? null : BartrColors.grey,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    "assets/icons/$icon.svg",
                    color: currentIndex == index
                        ? BartrColors.primary
                        : BartrColors.grey,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    text,
                    style: Styles.w700(
                      size: 14,
                      color: currentIndex == index ? null : BartrColors.grey,
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
