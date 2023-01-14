import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/home/presentation/widgets/carousel_indicator.dart';
import 'package:bartr/features/home/presentation/widgets/count_down_widget.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:bartr/general_widgets/cached_network_image_display.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostImagesCarousel extends StatefulWidget {
  const PostImagesCarousel({
    Key? key,
    required this.post,
    this.radius = 20,
    this.aspectRatio = 1,
    this.isProfile = false,
  }) : super(key: key);

  final Post post;
  final double aspectRatio, radius;
  final bool isProfile;

  @override
  State<PostImagesCarousel> createState() => _PostImagesCarouselState();
}

class _PostImagesCarouselState extends State<PostImagesCarousel> {
  final _carouselController = CarouselController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: widget.post.images?.length,
            itemBuilder: (context, index, second) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkDisplay(
                    radius: widget.radius,
                    url: widget.post.images![index],
                    width: double.infinity,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.all(15),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: widget.post.status != "Available"
                            ? BartrColors.white
                            : BartrColors.primary,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          if (widget.post.status != "Available")
                            const BoxShadow(
                                blurRadius: 5, color: BartrColors.lightGrey),
                        ],
                      ),
                      child: Text(
                        "${widget.post.status}",
                        style: Styles.w400(
                          color: widget.post.status != "Available"
                              ? BartrColors.primary
                              : BartrColors.white,
                          size: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  if (widget.post.expireDate != null)
                    CountDownWidget(post: widget.post),
                  if (widget.post.images!.length > 1 && !widget.isProfile)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Carouselindicator(
                        slides: widget.post.images!,
                        controller: _carouselController,
                        currentindex: currentIndex,
                        millisec: 300,
                      ),
                    ),
                  if (widget.post.images!.length > 1 && widget.isProfile)
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: BartrColors.white,
                        ),
                        child: SvgPicture.asset("assets/icons/copy.svg"),
                      ),
                    ),
                ],
              );
            },
            options: CarouselOptions(
              enableInfiniteScroll: false,
              scrollDirection: Axis.horizontal,
              aspectRatio: widget.aspectRatio,
              viewportFraction: 1,
              enlargeCenterPage: false,
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
              padEnds: false,
              onPageChanged: (index, reason) {
                setState(() {});
                currentIndex = index;
              },
            ),
          ),
        ],
      ),
    );
  }
}
