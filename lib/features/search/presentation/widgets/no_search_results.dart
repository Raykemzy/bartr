import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoSearchWidget extends StatelessWidget {
  const NoSearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/search-status.svg",
            // height: 200,
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            Strings.noSearchResults,
            style: Styles.w600(
              size: 24,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            Strings.diffKeyword,
            style: Styles.w400(
              size: 16,
              color: BartrColors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
