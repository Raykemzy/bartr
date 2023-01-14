import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/general_widgets/bartr_loader.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    this.color,
    this.textColor,
    this.width,
    this.text,
    this.onTap,
    this.padding,
    this.margin,
    this.height = 56,
    this.onRetry,
    this.isLoading = false,
    this.isEnabled = true,
    this.hasError = false,
    this.hasBorder = false,
    this.radius = 45,
    this.textSize,
  }) : super(key: key);
  final Color? color, textColor;
  final String? text;
  final void Function()? onTap, onRetry;
  final double? width, height, textSize;
  final EdgeInsetsGeometry? padding, margin;
  final bool isLoading, isEnabled, hasError, hasBorder;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final bool hasFocus = FocusScope.of(context).hasFocus;

    return InkWell(
      onTap: hasError
          ? onRetry
          : isLoading
              ? null
              : (!isEnabled
                  ? null
                  : () {
                      if (hasFocus) {
                        FocusScope.of(context).unfocus();
                      }
                      onTap?.call();
                    }),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: height,
        // padding: padding ?? const EdgeInsets.symmetric(vertical: 15),
        margin:
            margin ?? const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        decoration: BoxDecoration(
          border: hasBorder ? Border.all(width: 0.5) : null,
          borderRadius: BorderRadius.circular(radius),
          color: color ??
              (!isEnabled ? BartrColors.primaryFade : BartrColors.primary),
        ),
        alignment: Alignment.center,
        width: width ?? double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isLoading)
              Text(
                text ?? Strings.continuE,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: textSize ?? 16,
                  color: textColor ?? BartrColors.white,
                ),
                textAlign: TextAlign.center,
              ),
            if (isLoading)
              BartrLoader(
                color: textColor ?? BartrColors.white,
              )
          ],
        ),
      ),
    );
  }
}
