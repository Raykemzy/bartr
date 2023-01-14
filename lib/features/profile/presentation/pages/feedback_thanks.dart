import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/router/routes.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:flutter/material.dart';

import '../../../../general_widgets/app_button.dart';

class FeedBackThanks extends StatelessWidget {
  const FeedBackThanks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/thanks.png'),
              const SizedBox(
                height: 16,
              ),
              Text(
                Strings.feeedbackThanks,
                style: Styles.w700(size: 16, color: BartrColors.black),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                Strings.thisWilHelp,
                style: Styles.w400(size: 14, color: BartrColors.black),
              ),
              const SizedBox(height: 40),
              AppButton(
                text: Strings.returnHome,
                onTap: () => context.router.replaceAll([
                  const BartrDashBoardRoute(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
