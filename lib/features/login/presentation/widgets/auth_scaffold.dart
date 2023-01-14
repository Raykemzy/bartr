import 'package:bartr/general_widgets/bartr_scaffold.dart';
import 'package:flutter/material.dart';

import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:flutter_svg/svg.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    Key? key,
    this.resizeToAvoidBottomInset,
    required this.child,
    required this.title,
  }) : super(key: key);
  final Widget child;
  final String title;

  final bool? resizeToAvoidBottomInset;
  @override
  Widget build(BuildContext context) {
    return BartrScaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 16, right: 16),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/logoonly.svg",
                    fit: BoxFit.scaleDown,
                    height: 72,
                  ),
                  const SizedBox(height: 14.0),
                  Text(
                    title,
                    style: Styles.w500(
                      size: 30,
                      color: BartrColors.primary,
                    ),
                  ),
                  const SizedBox(height: 60.0),
                  child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
