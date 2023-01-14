import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';

class CountDownWidget extends StatelessWidget {
  const CountDownWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: BartrColors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(blurRadius: 5, color: BartrColors.lightGrey),
          ],
        ),
        child: CountdownTimer(
          widgetBuilder: (context, time) {
            var remainingTime = time?.days != null ? (24 * time!.days!) : 0;
            return Text(
              time == null
                  ? "Closed"
                  : "${(time.hours ?? 0) + remainingTime}:${time.min ?? 0}:${time.sec ?? 0}",
              style: Styles.w400(
                color: BartrColors.black,
                size: 12,
              ),
              textAlign: TextAlign.center,
            );
          },
          endTime: post.expireDate!.millisecondsSinceEpoch,
        ),
      ),
    );
  }
}
