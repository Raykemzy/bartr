import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:flutter/material.dart';

class BartrFab extends StatelessWidget {
  const BartrFab({
    Key? key,
    this.onTap,
  }) : super(key: key);
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.router.push(const CreatePostRoute()),
      child: Container(
        height: 55,
        width: 55,
        decoration: const BoxDecoration(
          color: BartrColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              spreadRadius: 4,
              blurRadius: 5,
              color: BartrColors.lightGrey,
            )
          ],
        ),
        child: const Icon(
          Icons.add,
          color: BartrColors.white,
        ),
      ),
    );
  }
}
