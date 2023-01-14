import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/colors.dart';

class NetworkErrorWidget extends StatelessWidget {
  const NetworkErrorWidget({
    Key? key,
    this.onTap,
    this.errorMessage,
  }) : super(key: key);
  final void Function()? onTap;
  final String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: BartrColors.redLight,
            borderRadius: BorderRadius.circular(12)),
        padding:
            const EdgeInsets.only(left: 20, top: 12, bottom: 12, right: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset("assets/icons/error.svg"),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    errorMessage ?? Strings.postsArentLoading,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    Strings.tap,
                    textAlign: TextAlign.center,
                    style: Styles.w600(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
