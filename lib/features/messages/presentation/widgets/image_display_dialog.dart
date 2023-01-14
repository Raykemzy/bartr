import 'dart:io';

import 'package:bartr/general_widgets/cached_network_image_display.dart';
import 'package:flutter/material.dart';

class ImageDisplayDialog extends StatelessWidget {
  const ImageDisplayDialog({
    Key? key,
    this.image,
    this.child,
  }) : super(key: key);

  final File? image;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.zero,
      content: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: image == null
            ? child
            : CachedNetworkDisplay(
                url: image!.path,
                radius: 5,
              ),
      ),
    );
  }
}
