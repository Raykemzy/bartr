import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/features/bids/domain/user_bids_model.dart';
import 'package:bartr/features/bids/presentation/widgets/bids_images_carousel.dart';
import 'package:flutter/material.dart';

class BidsReceivedGrid extends StatelessWidget {
  final List<ReceivedBid> bids;
  final NavigationViewType viewType;
  final bool isLoading;
  final ScrollController scrollController;
  final int currentIndex;
  final void Function(int) changeIndex;
  const BidsReceivedGrid({
    Key? key,
    required this.bids,
    required this.viewType,
    required this.isLoading,
    required this.scrollController,
    required this.currentIndex,
    required this.changeIndex,
  }) : super(key: key);

  static const double aspectRatio = 0.8;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 9,
              mainAxisSpacing: 9,
              childAspectRatio: aspectRatio,
            ),
            controller: scrollController,
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            shrinkWrap: true,
            itemCount: bids.length,
            itemBuilder: (context, index) {
              var bid = bids[index];
              return InkWell(
                onTap: () {
                  context.router.push(ItemBidsPageRoute(postId: bid.id!));
                },
                child: BidImagesCarousel(
                  isProfile: true,
                  radius: 10,
                  aspectRatio: aspectRatio,
                  postImages: bid.images!,
                  numOfBids: bid.totalBids,
                ),
              );
            },
          );
  }
}
