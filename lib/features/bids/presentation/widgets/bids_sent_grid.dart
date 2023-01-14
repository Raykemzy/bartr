import 'package:bartr/core/helpers/mixins.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/features/bids/domain/user_bids_model.dart';
import 'package:bartr/features/bids/presentation/widgets/bids_images_carousel.dart';
import 'package:flutter/material.dart';

class BidsSentGrid extends StatelessWidget with NavigationMixin {
  final List<SentBid> bids;
  final NavigationViewType viewType;
  final bool isLoading;
  final ScrollController scrollController;
  final int currentIndex;
  final void Function(int) changeIndex;
  const BidsSentGrid({
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
        return InkWell(
          onTap: () => navigateToPostDetail(
            context: context,
            postId: bids[index].post!.id!,
          ),
          child: BidImagesCarousel(
            isProfile: true,
            radius: 10,
            aspectRatio: aspectRatio,
            postImages:
                bids[index].post != null ? bids[index].post!.images! : [],
          ),
        );
      },
    );
  }
}
