import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:flutter/cupertino.dart';

class NoBids extends StatelessWidget {
  const NoBids({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.5),
      child: Center(
        child: Column(
          children: [
            Image.asset(
              "assets/images/nobids.png",
              width: 70,
            ),
            const SizedBox(height: 40),
            Text(
              Strings.noBids,
              style: Styles.w500(
                size: 16,
                color: BartrColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
