import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:flutter/cupertino.dart';

class PassCriteria extends StatelessWidget {
  const PassCriteria(
      {Key? key,
      required this.has6t020,
      required this.hasLettersNumbersAndSpecial})
      : super(key: key);
  final bool has6t020;
  final bool hasLettersNumbersAndSpecial;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.passwordMust,
            style: Styles.w500(
              size: 12,
              color: BartrColors.primaryFade,
            ),
            textAlign: TextAlign.center,
          ),
          Row(
            children: [
              Image.asset(
                "assets/images/successmark.png",
                width: 10,
                color: !has6t020 ? BartrColors.grey : null,
              ),
              const SizedBox(width: 5.0),
              Text(
                Strings.passLength,
                style: Styles.w300(
                  size: 12,
                  color: BartrColors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Row(
            children: [
              Image.asset(
                "assets/images/successmark.png",
                width: 10,
                color: !hasLettersNumbersAndSpecial ? BartrColors.grey : null,
              ),
              const SizedBox(width: 5.0),
              Text(
                Strings.passChar,
                style: Styles.w300(
                  size: 12,
                  color: BartrColors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
