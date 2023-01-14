import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/textstyles.dart';

class PostCardSubtitleRow extends StatelessWidget {
  const PostCardSubtitleRow({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            "assets/icons/${post.postType == PostType.Barter ? "barter" : "giveaway"}.svg",
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              "${post.category}, ${post.postType == PostType.Barter ? "Barter." : "Giveaway."}",
              maxLines: 5,
              style: Styles.w500(
                size: 12,
                color: BartrColors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 16),
          const PostDot(),
          const SizedBox(width: 16),
          SvgPicture.asset(
            "assets/icons/location.svg",
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              "${post.location}.",
              maxLines: 2,
              style: Styles.w500(
                size: 12,
                color: BartrColors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class PostDot extends StatelessWidget {
  const PostDot({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: 8,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: BartrColors.black,
      ),
    );
  }
}
