import 'package:bartr/core/helpers/helper_functions.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:flutter/material.dart';

class FeedBackTextField extends StatelessWidget {
  const FeedBackTextField(
      {Key? key,
      this.label,
      required this.controller,
      required this.validateFunction,
      this.minLines,
      this.minLength,
      this.hintText,
      this.onChanged})
      : super(key: key);
  final String? label;
  final String? hintText;
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
            style: Styles.w500(
              size: 12,
              color: BartrColors.black,
            ),
          ),
        if (label != null) const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validateFunction,
          onChanged: onChanged,
          maxLines: minLines ?? 3,
          maxLength: minLength ?? 200,
          decoration: Helpers.inputdecor(hintText: hintText),
        ),
      ],
    );
  }
}
