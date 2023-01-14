// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bartr/core/helpers/mixins.dart';
import 'package:bartr/features/post_and_comments/domain/models/single_post_model.dart';
import 'package:flutter/material.dart';

import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/general_widgets/cached_network_image_display.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/config/configure_dependencies.dart';
import '../../../../core/helpers/helper_functions.dart';

class PostDelegate extends ConsumerWidget with NavigationMixin {
  const PostDelegate({
    Key? key,
    required this.post,
  }) : super(key: key);
  final SinglePost post;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = Helpers.width(context);
    final currentuser = ref.watch(currentUserProvider);

    return InkWell(
      onTap: post.user!.id! == currentuser.id
          ? null
          : () => navigateToProfile(
                context: context,
                userId: post.user!.id!,
                username: post.user!.username!,
              ),
      child: Container(
        margin: const EdgeInsets.only(top: 28, left: 20, right: 20),
        decoration: const BoxDecoration(
          color: BartrColors.white,
          border: Border(
            bottom: BorderSide(
              color: BartrColors.deepgrey,
              width: 0.3,
            ),
          ),
        ),
        padding: const EdgeInsets.only(bottom: 30, left: 5, right: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CachedNetworkDisplay(
              height: 40,
              width: 40,
              url: post.user!.profilePicture ?? "",
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "@${post.user!.username ?? ""}",
                  style: Styles.w500(
                    size: 16,
                    color: BartrColors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: width * 0.65,
                  child: Text(
                    post.description ?? "",
                    style: Styles.w400(
                      size: 14,
                      color: BartrColors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}
