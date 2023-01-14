import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/helpers/extensions.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VerifyEmailTexts extends StatelessWidget {
  const VerifyEmailTexts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 40.0,
        ),
        Text(
          Strings.verify,
          style: Styles.w500(color: BartrColors.primary, size: 18),
        ),
        const SizedBox(
          height: 40.0,
        ),
        Image.asset(
          "assets/images/email.png",
        ),
        const SizedBox(
          height: 16.0,
        ),
        Consumer(
          builder: (context, ref, child) {
            var user = ref.watch(currentUserProvider);
            return Column(
              children: [
                Text(
                  "${user.fullName!.split(" ")[0]}  ${Strings.almostThere}",
                  style: Styles.w700(color: BartrColors.primary, size: 18),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  "${Strings.enter6Digit} ${user.email!.obscuredMail()}",
                  style: Styles.w400(
                    color: BartrColors.black,
                    size: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        ),
        const SizedBox(
          height: 40.0,
        ),
        Text(
          Strings.enterCode,
          style: Styles.w400(color: BartrColors.black, size: 14),
        ),
        const SizedBox(
          height: 8.0,
        ),
      ],
    );
  }
}
