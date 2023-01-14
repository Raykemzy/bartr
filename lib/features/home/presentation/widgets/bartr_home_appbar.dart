import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../../core/router/router.dart';
import 'bartr_searchbar.dart';

class BartrHomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const BartrHomeAppBar({
    Key? key,
    required this.controller1,
    required this.controller2,
  }) : super(key: key);
  final ScrollController controller1;
  final ScrollController controller2;

  @override
  State<BartrHomeAppBar> createState() => _BartrHomeAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 80);
}

class _BartrHomeAppBarState extends State<BartrHomeAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool showAppbar = true;
  bool isScrollingDown = false;

  @override
  void dispose() {
    _animationController.dispose();
    widget.controller1.dispose();
    widget.controller2.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        value: 1, vsync: this, duration: const Duration(milliseconds: 100));
    _addListeners(widget.controller1);
    _addListeners(widget.controller2);

    _animationController.forward();
  }

  _addListeners(ScrollController controller) {
    controller.addListener(() {
      switch (controller.position.userScrollDirection) {
        case ScrollDirection.reverse:
          showAppbar = false;
          setState(() {});
          _animationController.reverse();
          break;
        case ScrollDirection.forward:
          showAppbar = true;
          setState(() {});
          _animationController.forward();
          break;
        case ScrollDirection.idle:
          break;
        default:
      }
      if (controller.position.pixels == controller.position.minScrollExtent) {
        showAppbar = true;

        setState(() {});
        appBarHeight = 56.0;
        searchBarHeight = 65.0;
        _animationController.value = 1;
      }
    });
  }

  double appBarHeight = 56.0;
  double searchBarHeight = 65.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          height: (appBarHeight * _animationController.value),
          duration: const Duration(milliseconds: 200),
          child: AppBar(
            centerTitle: false,
            elevation: 0.5,
            title: Image.asset(
              "assets/images/bartr.png",
              fit: BoxFit.cover,
              height: 62,
              width: 120,
            ),
          ),
        ),
        Visibility(
          visible: showAppbar,
          child: AnimatedContainer(
            curve: Curves.linear,
            height: (searchBarHeight * _animationController.value),
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: FadeTransition(
              opacity: (_animationController),
              child: Transform.scale(
                scale: (_animationController.value),
                child: Hero(
                  tag: "search",
                  child: SearchBar(
                    onFilter: () =>
                        context.router.push(const FilterPageRoute()),
                    readOnly: true,
                    onTap: () => context.router.push(const SearchPageRoute()),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
