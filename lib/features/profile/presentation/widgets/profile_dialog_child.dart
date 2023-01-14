import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/helpers/helper_functions.dart';
import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/router/routes.dart';
import 'package:bartr/core/utils/app_urls.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/colors.dart';

class ProfileDialogWidget extends ConsumerWidget {
  const ProfileDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // TextButton(
        //   onPressed: () {
        //     //TODO: implement share profile
        //   },
        //   child: Text(
        //     "Share profile",
        //     style: Styles.w600(
        //       size: 14,
        //       color: BartrColors.black,
        //     ),
        //   ),
        // ),
        TextButton(
          onPressed: () {
            context.router.pop();
            context.router.push(const VerifyProfilePageRoute());
          },
          child: Text(
            "Verify Profile",
            style: Styles.w600(
              size: 14,
              color: BartrColors.primaryLight,
            ),
          ),
        ),
        TextButton(
          onPressed: () => launchLink(AppUrl.privacyPolicy, context),
          child: Text(
            "Privacy",
            style: Styles.w600(
              size: 14,
              color: BartrColors.black,
            ),
          ),
        ),
        TextButton(
          onPressed: () => launchLink(AppUrl.termsandConditions, context),
          child: Text(
            "Terms & Conditions",
            style: Styles.w600(
              size: 14,
              color: BartrColors.black,
            ),
          ),
        ),
        TextButton(
          onPressed: () => launchLink(AppUrl.feedBackUrl, context),
          child: Text(
            "Leave Us Feedback",
            style: Styles.w600(
              size: 14,
              color: BartrColors.black,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            context.router.replaceAll([
              const SplashScreenRoute(),
            ]);
            ref.read(localDb).clear();
          },
          child: Text(
            "Logout",
            style: Styles.w600(
              size: 14,
              color: BartrColors.red,
            ),
          ),
        ),
        const Divider(),
        TextButton(
          onPressed: () => context.router.push(const DeleteAccountRoute()),
          child: Text(
            "Delete my account",
            style: Styles.w600(
              size: 14,
              color: BartrColors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
