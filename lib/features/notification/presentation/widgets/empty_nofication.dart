import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:flutter/cupertino.dart';

class EmptyNotification extends StatelessWidget {
  const EmptyNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/notification.png",
          ),
          const SizedBox(
            height: 42,
          ),
          Text(Strings.noNotification,
              style: Styles.w500(size: 14, color: BartrColors.black),),
        ],
      ),
    );
  }
}
