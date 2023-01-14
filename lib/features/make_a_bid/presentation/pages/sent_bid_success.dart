import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/router/routes.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/general_widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BidSentSuccessScreen extends ConsumerWidget {
  const BidSentSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: BartrColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/check_icon.png",
              fit: BoxFit.none,
            ),
            const SizedBox(height: 10),
            Text(
              'Bid Sent!',
              style: Styles.bold(
                size: 18,
                color: BartrColors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Your bid has been sent to the owner of the product. You’ll receive a notification if they want to proceed with your bid. ',
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
