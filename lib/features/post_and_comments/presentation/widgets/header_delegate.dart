import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/features/home/presentation/widgets/post_app_bar_carousel.dart';
import 'package:bartr/features/post_and_comments/domain/models/single_post_model.dart';
import 'package:bartr/features/post_and_comments/presentation/widgets/post_appbar.dart';
import 'package:flutter/material.dart';

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  const MyHeaderDelegate({
    required this.post,
    required this.onDeletePost,
  });
  final SinglePost post;
  final void Function() onDeletePost;
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final progress = shrinkOffset / maxExtent;

    return Material(
      elevation: progress > 0.5 ? 1 : 0,
      color: BartrColors.white,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 150),
            opacity: 1 - progress,
            child: PostAppBarCarousel(
              post: post,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                PostAppBar(
                  onDeletePost: onDeletePost,
                  singlePost: post,
                  progress: progress,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 300;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
