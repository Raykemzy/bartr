import 'package:bartr/core/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../core/helpers/helper_functions.dart';

class CachedNetworkDisplay extends StatelessWidget {
  const CachedNetworkDisplay({
    Key? key,
    this.height,
    this.width,
    required this.url,
    this.radius = 20,
    this.isProfile = false,
    this.fit = BoxFit.cover,
    this.memCacheHeight,
    this.memCacheWidth,
  }) : super(key: key);
  final String url;
  final double? width, height, radius;
  final bool isProfile;
  final BoxFit fit;
  final int? memCacheHeight;
  final int? memCacheWidth;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius!),
      child: url.isEmpty
          ? Icon(
              Icons.account_circle_sharp,
              size: height,
            )
          : CachedNetworkImage(
              memCacheHeight: memCacheHeight,
              memCacheWidth: memCacheWidth,
              imageUrl: url,
              fit: fit,
              height: height,
              width: width,
              errorWidget: (context, url, error) {
                return isProfile
                    ? Icon(
                        Icons.account_circle_sharp,
                        size: height,
                      )
                    : AspectRatio(
                        aspectRatio: Helpers.height(context) *
                            0.5 /
                            Helpers.width(context),
                        child: Container(
                          height: Helpers.height(context) * 0.4,
                          decoration: const BoxDecoration(
                            color: BartrColors.greyFill,
                          ),
                        ),
                      );
              },
            ),
    );
  }
}
