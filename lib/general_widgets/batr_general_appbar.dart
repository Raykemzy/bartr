import 'package:bartr/core/utils/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BartrAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BartrAppBar({
    Key? key,
    required this.title,
    this.hasLeading = true,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.elevation,
  }) : super(key: key);
  final bool hasLeading;
  final String title;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final double? elevation;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      centerTitle: true,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: !hasLeading
          ? null
          : GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset(
                "assets/icons/arrow_back.svg",
                color: Colors.black,
                fit: BoxFit.scaleDown,
              ),
            ),
      title: Text(
        title,
        style: Styles.w500(
          size: 16,
          color: Colors.black,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
