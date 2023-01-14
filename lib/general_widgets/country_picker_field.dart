import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/material.dart';

class CountryPickerField extends StatelessWidget {
  const CountryPickerField({
    Key? key,
    required this.country,
    this.onTap,
    this.labelColor,
    this.labelSize,
  }) : super(key: key);
  final Country country;
  final void Function()? onTap;
  final double? labelSize;
  final Color? labelColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.selectLoc,
          style: Styles.w400(
            size: labelSize ?? 12,
            color: labelColor,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.only(right: 18),
            height: 54,
            decoration: BoxDecoration(
              color: BartrColors.greyFill,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: BartrColors.lightGrey, width: 0.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Image.asset(
                        country.flag,
                        package: countryCodePackageName,
                        width: 90,
                        height: 16,
                      ),
                      Text(country.name, style: Styles.w400(size: 14)),
                    ],
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: BartrColors.primary,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
