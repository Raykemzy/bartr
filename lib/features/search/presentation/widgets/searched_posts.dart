import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/router.dart';
import '../../../../core/utils/colors.dart';
import '../../../../general_widgets/cached_network_image_display.dart';
import '../../../login/domain/models/login_model.dart';
import '../notifier/search_notifier.dart';

class SearchedPostListView extends ConsumerWidget {
  const SearchedPostListView({
    Key? key,
    required this.posts,
  }) : super(key: key);
  final List<Post> posts;

  _navigate(Post post, BuildContext context, WidgetRef ref) {
    context.router.push(
      PostDetailRoute(
        postId: post.id!,
      ),
    );
    ref.read(searchNotifier.notifier).saveClickedPost(post);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      // padding: const EdgeInsets.only(top: 20),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var post = posts[index];
        return ListTile(
          onTap: () => _navigate(post, context, ref),
          leading: CachedNetworkDisplay(
            memCacheHeight: 150,
            memCacheWidth: 150,
            height: 40,
            width: 40,
            url: post.images!.first,
            // "https://media.istockphoto.com/photos/professional-mechanic-working-on-the-engine-of-the-car-in-the-garage-picture-id1409304203",
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title!,
                style: Styles.w500(
                  size: 16,
                  color: Colors.black,
                ),
              ),
              Text(
                post.postType == PostType.Barter ? "Barter" : "Giveaway",
                style: Styles.w400(
                  size: 12,
                  color: BartrColors.grey,
                ),
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 5,
        );
      },
      itemCount: posts.length,
    );
  }
}
