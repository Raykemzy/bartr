import 'package:bartr/core/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../core/utils/colors.dart';
import '../core/utils/textstyles.dart';

class DropDownField<T> extends StatelessWidget {
  const DropDownField({
    Key? key,
    required this.values,
    this.onChanged,
    this.label,
    this.currentValue,
  }) : super(key: key);
  final List<T> values;
  final void Function(T?)? onChanged;
  final String? label;
  final T? currentValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: Styles.w400(
              size: 14,
              color: BartrColors.black,
            ),
          ),
        if (label != null) const SizedBox(height: 8),
        SizedBox(
          height: 55,
          child: DropdownButtonFormField<T>(
            style: Styles.w400(
              size: 14,
              color: BartrColors.black,
            ),
            icon: const Icon(Icons.keyboard_arrow_down),
            borderRadius: BorderRadius.circular(5),
            decoration: Helpers.inputdecor(),
            value: currentValue ?? values.first,
            autovalidateMode: AutovalidateMode.always,
            items: values
                .map(
                  (e) => DropdownMenuItem<T>(
                    value: e,
                    child: Text(e is String ? e : "$e"),
                  ),
                )
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
