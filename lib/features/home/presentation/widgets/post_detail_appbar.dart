import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PostAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PostAppBar({
    Key? key,
    required this.imageCarousel,
    this.onMenuTap,
  }) : super(key: key);
  final Widget imageCarousel;
  final void Function()? onMenuTap;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      expandedHeight: 400,
      centerTitle: true,
      floating: true,
      pinned: true,
      elevation: 1,
      forceElevated: false,
      flexibleSpace: imageCarousel,
      actions: [
        GestureDetector(
          onTap: onMenuTap,
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 25),
            padding: const EdgeInsets.all(7),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset("assets/icons/menu.svg"),
          ),
        ),
      ],
      leading: GestureDetector(
        onTap: () => context.router.pop(),
        child: Container(
          margin: const EdgeInsets.only(left: 25),
          padding: EdgeInsets.zero,
          decoration:
              const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: const Icon(Icons.arrow_back_sharp),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
