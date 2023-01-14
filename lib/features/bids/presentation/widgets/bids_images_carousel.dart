import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/home/presentation/widgets/carousel_indicator.dart';
import 'package:bartr/general_widgets/cached_network_image_display.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BidImagesCarousel extends ConsumerStatefulWidget {
  const BidImagesCarousel({
    Key? key,
    required this.postImages,
    this.radius = 20,
    this.aspectRatio = 1,
    this.isProfile = false,
    this.numOfBids,
  }) : super(key: key);

  final List<String> postImages;
  final double aspectRatio, radius;
  final bool isProfile;
  final int? numOfBids;

  @override
  ConsumerState<BidImagesCarousel> createState() => _BidImagesCarouselState();
}

class _BidImagesCarouselState extends ConsumerState<BidImagesCarousel> {
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
            itemCount: widget.postImages.length,
            itemBuilder: (context, index, second) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkDisplay(
                    radius: widget.radius,
                    url: widget.postImages[index],
                    width: double.infinity,
                  ),
                  if (widget.postImages.length > 1 && !widget.isProfile)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Carouselindicator(
                        slides: widget.postImages,
                        controller: _carouselController,
                        currentindex: currentIndex,
                        millisec: 300,
                      ),
                    ),
                  if (widget.numOfBids != null)
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        alignment: Alignment.center,
                        width: 31,
                        height: 24,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: BartrColors.primary,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          widget.numOfBids.toString(),
                          style: Styles.w400(
                            size: 12,
                            color: BartrColors.white,
                          ),
                        ),
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
