import 'package:bartr/core/helpers/helper_functions.dart';
import 'package:bartr/core/utils/app_urls.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/strings.dart';

class TandCWidget extends StatelessWidget {
  const TandCWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: Strings.disclaimer1,
        style: Styles.w400(color: BartrColors.grey, size: 12),
        children: [
          TextSpan(
            text: Strings.tandt,
            style: Styles.w400(color: BartrColors.primary, size: 12),
            recognizer: TapGestureRecognizer()
              ..onTap = () => launchLink(AppUrl.termsandConditions, context),
          ),
          TextSpan(
            text: " \nand ",
            style: Styles.w400(color: BartrColors.grey, size: 12),
          ),
          TextSpan(
            text: Strings.pp,
            style: Styles.w400(color: BartrColors.primaryLight, size: 12),
            recognizer: TapGestureRecognizer()
              ..onTap = () => launchLink(AppUrl.privacyPolicy, context),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
