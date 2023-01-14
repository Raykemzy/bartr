import 'package:bartr/core/utils/colors.dart';
import 'package:flutter/material.dart';

class Styles {
  static TextStyle w300({
    final Color? color,
    final double? size,
  }) =>
      TextStyle(
        color: color ?? BartrColors.primary,
        fontWeight: FontWeight.w300,
        fontSize: size,
      );
  static TextStyle w400({
    final Color? color,
    final double? size,
  }) =>
      TextStyle(
        color: color ?? BartrColors.primary,
        fontWeight: FontWeight.w400,
        fontSize: size,
      );
  static TextStyle w500({
    final Color? color,
    final double? size,
  }) =>
      TextStyle(
        color: color ?? BartrColors.primary,
        fontWeight: FontWeight.w500,
        fontSize: size,
      );
  static TextStyle w600({
    final Color? color,
    final double? size,
    final TextDecoration? textDecoration,
  }) =>
      TextStyle(
        color: color ?? BartrColors.primary,
        fontWeight: FontWeight.w600,
        fontSize: size,
        decoration: textDecoration,
      );
  static TextStyle w700({
    final Color? color,
    final double? size,
    final TextDecoration? textDecoration,
  }) =>
      TextStyle(
        color: color ?? BartrColors.primary,
        fontWeight: FontWeight.w700,
        fontSize: size,
        decoration: textDecoration,
      );
  static TextStyle w800({
    final Color? color,
    final double? size,
    final TextDecoration? textDecoration,
  }) =>
      TextStyle(
        color: color ?? BartrColors.primary,
        fontWeight: FontWeight.w800,
        fontSize: size,
        decoration: textDecoration,
      );
  static TextStyle w900({
    final Color? color,
    final double? size,
    final TextDecoration? textDecoration,
  }) =>
      TextStyle(
        color: color ?? BartrColors.primary,
        fontWeight: FontWeight.w900,
        fontSize: size,
        decoration: textDecoration,
      );
  static TextStyle bold({
    final Color? color,
    final double? size,
    final TextDecoration? textDecoration,
  }) =>
      TextStyle(
        color: color ?? BartrColors.primary,
        fontWeight: FontWeight.bold,
        fontSize: size,
        decoration: textDecoration,
      );
}
