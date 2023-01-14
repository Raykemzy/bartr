import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/general_widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RetryWidget extends StatelessWidget {
  const RetryWidget({
    Key? key,
    this.onRetry,
    this.canRetry = true,
    this.errorMessage,
    this.retryText,
  }) : super(key: key);
  final void Function()? onRetry;
  final bool canRetry;
  final String? errorMessage;
  final String? retryText;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/icons/networkrror.svg"),
          const SizedBox(
            height: 40,
          ),
          Text(
            errorMessage ?? Strings.connectionError,
            style: Styles.w500(
              size: 15,
              color: BartrColors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 70,
          ),
          if (canRetry)
            AppButton(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              onTap: onRetry,
              text: retryText ?? "Try again",
            ),
        ],
      ),
    );
  }
}
