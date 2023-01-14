import 'package:flutter/material.dart';

class BartrScaffold extends StatelessWidget {
  const BartrScaffold({
    Key? key,
    required this.child,
    this.resizeToAvoidBottomInset,
    this.appbar,
  }) : super(key: key);
  final Widget child;
  final bool? resizeToAvoidBottomInset;
  final PreferredSizeWidget? appbar;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: appbar,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          body: child,),
    );
  }
}