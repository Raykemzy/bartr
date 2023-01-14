import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/utils/colors.dart';
import '../../../post_and_comments/domain/models/single_post_model.dart';

class PostImagesView extends StatelessWidget {
  const PostImagesView({
    Key? key,
    required this.post,
  }) : super(key: key);

  final SinglePost post;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        int sensitivity = 10;
        if (details.delta.dy > sensitivity || details.delta.dy < -sensitivity) {
          Navigator.of(context).pop();
        }
      },
      child: Dialog(
        backgroundColor: BartrColors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: EdgeInsets.zero,
        child: PageView(
            clipBehavior: Clip.antiAlias,
            children: List.generate(
              post.images!.length,
              (index) => ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: post.images![index],
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) {
                    return Container(
                      height: Helpers.height(context) * 0.4,
                      decoration: const BoxDecoration(
                        color: BartrColors.greyFill,
                      ),
                    );
                  },
                ),
              ),
            )),
      ),
    );
  }
}
