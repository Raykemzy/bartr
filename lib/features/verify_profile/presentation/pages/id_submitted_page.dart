import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/router/routes.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/general_widgets/app_button.dart';
import 'package:flutter/material.dart';

class IDSubmittedPage extends StatelessWidget {
  const IDSubmittedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/check_icon.png",
              fit: BoxFit.none,
            ),
            const SizedBox(height: 10),
            Text(
              Strings.idSubmitted,
              style: Styles.bold(
                size: 18,
                color: BartrColors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              Strings.thanksforID,
              style: Styles.w300(
                size: 14,
                color: BartrColors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            AppButton(
              onTap: () => context.router.replaceAll(
                [const BartrDashBoardRoute()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
