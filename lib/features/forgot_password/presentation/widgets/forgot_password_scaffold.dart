import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/textstyles.dart';

class ForgotPasswordScaffold extends StatelessWidget {
  const ForgotPasswordScaffold(
      {Key? key,
      this.resizeToAvoidBottomInset,
      required this.child,
      required this.title,
      this.titleBottomPadding,
      required this.ctx,})
      : super(key: key);
  final Widget child;
  final String title;
  final double? titleBottomPadding;
  final bool? resizeToAvoidBottomInset;
  final BuildContext ctx;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 16, right: 16),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (() => ctx.router.pop()),
                          child: Image.asset(
                            "assets/images/backarrow.png",
                            width: 24,
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 4),
                        Image.asset(
                          "assets/images/bartr.png",
                          width: 100,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  Text(
                    title,
                    style: Styles.w500(
                      size: 18,
                      color: BartrColors.black,
                    ),
                  ),
                  SizedBox(height: titleBottomPadding ?? 60.0),
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
