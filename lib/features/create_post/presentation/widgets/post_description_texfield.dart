import 'package:bartr/core/helpers/helper_functions.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:flutter/material.dart';

class PostDescriptionTextField extends StatelessWidget {
  const PostDescriptionTextField({
    Key? key,
    this.label,
    required this.controller,
    required this.validateFunction,
    this.minLines,
    this.minLength,
    this.hintText,
    this.onChanged,
    this.currentValue,
  }) : super(key: key);
  final String? label;
  final String? hintText, currentValue;
  final int? minLines;
  final int? minLength;
  final TextEditingController controller;
  final String? Function(String?) validateFunction;
  final void Function(String)? onChanged;
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
        TextFormField(
          initialValue: currentValue,
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validateFunction,
          onChanged: onChanged,
          maxLines: minLines ?? 5,
          maxLength: minLength ?? 300,
          textAlign: TextAlign.left,
          scrollPadding:const EdgeInsets.only(left: 100),
          decoration: Helpers.inputdecor(
            hintText: hintText,
            // contentPadding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }
}
