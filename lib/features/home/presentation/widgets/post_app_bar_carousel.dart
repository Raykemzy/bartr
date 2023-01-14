import 'package:bartr/features/post_and_comments/domain/models/single_post_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/utils/colors.dart';
import 'carousel_indicator.dart';
import 'post_images_view.dart';

class PostAppBarCarousel extends StatefulWidget {
  const PostAppBarCarousel({
    Key? key,
    required this.post,
  }) : super(key: key);
  final SinglePost post;
  @override
  State<PostAppBarCarousel> createState() => _PostAppBarCarouselState();
}

class _PostAppBarCarouselState extends State<PostAppBarCarousel> {
  final _carouselController = CarouselController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        fit: StackFit.expand,
        children: [
          CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: widget.post.images?.length,
            itemBuilder: (context, index, second) {
              return GestureDetector(
                onTap: () => _show(context),
                child: CachedNetworkImage(
                  imageUrl: widget.post.images![index],
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) {
                    return AspectRatio(
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
            },
            options: CarouselOptions(
              enableInfiniteScroll: false,
              scrollDirection: Axis.horizontal,
              disableCenter: true,
              viewportFraction: 1,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
              padEnds: false,
              onPageChanged: (index, reason) {
                setState(() {});
                currentIndex = index;
              },
            ),
          ),
          if (widget.post.images!.length > 1)
            Align(
              alignment: Alignment.bottomCenter,
              child: Carouselindicator(
                controller: _carouselController,
                slides: widget.post.images!,
                currentindex: currentIndex,
                millisec: 300,
              ),
            ),
        ],
      ),
    );
  }

  Future<Object?> _show(BuildContext context) {
    return showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, anim, anim2, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(anim),
          child: child,
        );
      },
      pageBuilder: (context, anim, anim2) {
        return PostImagesView(post: widget.post);
      },
      context: context,
    );
  }
}
