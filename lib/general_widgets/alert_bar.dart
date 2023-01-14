import 'package:another_flushbar/flushbar.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Alert {
  static void showNotification({
    int notificationType = 0,
    String message = "",
    required BuildContext context,
    void Function()? onFinished,
  }) {
    Flushbar(
      onStatusChanged: (status) {
        if (status == FlushbarStatus.DISMISSED) {
          if (onFinished != null) {
            onFinished();
          }
        }
      },
      margin: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor:
          notificationType == 1 ? BartrColors.redLight : BartrColors.lightGreen,
      maxWidth: MediaQuery.of(context).size.width * 0.85,
      isDismissible: true,
      duration: const Duration(seconds: 3),
      showProgressIndicator: false,
      icon: SvgPicture.asset(
        "assets/icons/error.svg",
        color: notificationType == 1 ? BartrColors.red : BartrColors.green,
      ),
      messageText: Text(
        message,
        style: TextStyle(
          fontSize: 13.0,
          color: notificationType == 1 ? BartrColors.black : BartrColors.green,
          fontWeight: FontWeight.w400,
        ),
      ),
    ).show(context);
  }
}
