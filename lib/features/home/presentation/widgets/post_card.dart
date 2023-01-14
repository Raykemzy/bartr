import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/home/presentation/widgets/post_card_subtitle_row.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:timeago_flutter/timeago_flutter.dart' as timeago;

import '../../../../core/utils/colors.dart';
import 'post_action_row.dart';
import 'post_header.dart';
import 'posts_images_carousel.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    Key? key,
    required this.post,
    required this.index,
    required this.onDeletePost,
  }) : super(key: key);
  final void Function() onDeletePost;
  final Post post;
  final int index;
  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);

    return InkWell(
      onTap: () => _navigateNested(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: BartrColors.grey, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostUserHeader(
              onDeletePost: onDeletePost,
              post: post,
            ),
            const SizedBox(height: 8),
            PostImagesCarousel(
              post: post,
            ),
            const SizedBox(height: 18.25),
            PostActionRow(
              poste: post,
              index: index,
            ),
            const SizedBox(height: 30.25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  const PostDot(),
                  const SizedBox(width: 10),
                  Text(
                    "${post.title}",
                    maxLines: 1,
                    style: Styles.w500(
                      size: 14,
                      color: BartrColors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "${post.description}",
                maxLines: 1,
                style: Styles.w400(
                  size: 14,
                  color: BartrColors.deepgrey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
              child: Text(
                "Posted ${timeago.format(post.createdAt!, locale: locale.countryCode)}",
                maxLines: 1,
                style: Styles.w400(
                  size: 12,
                  color: BartrColors.deepgrey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 17),
            PostCardSubtitleRow(post: post)
          ],
        ),
      ),
    );
  }

  void _navigateNested(BuildContext context) {
    context.router.push(
      PostDetailRoute(
        key: ValueKey(post.id),
        postId: post.id!,
      ),
    );
  }
}
