import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/router/routes.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/features/home/presentation/widgets/posts_images_carousel.dart';
import 'package:bartr/general_widgets/bartr_loader.dart';
import 'package:flutter/material.dart';

import '../../../post_and_comments/presentation/widgets/no_comment.dart';

class ProfileBarterGrid extends StatelessWidget {
  const ProfileBarterGrid({
    Key? key,
    required this.posts,
    required this.loadState,
    required this.onRefresh,
    required this.barterPosts,
    required this.giveAwayPosts,
    required this.isUser,
    required this.ondeletePost,
  }) : super(key: key);
  final List<Post> posts;
  final LoadState loadState;
  final List<Post> barterPosts;
  final List<Post> giveAwayPosts;
  final Future<void> Function() onRefresh;
  final Future<bool> Function(String) ondeletePost;
  final bool isUser;

  static const double aspectRatio = 0.8;
  @override
  Widget build(BuildContext context) {
    return loadState == LoadState.loading
        ? const BartrLoader(
            size: 80,
            color: BartrColors.primary,
          )
        : posts.isEmpty
            ? NoPost(
                isUser: isUser,
                postType: PostType.Barter,
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 9,
                  mainAxisSpacing: 9,
                  childAspectRatio: aspectRatio,
                ),
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 50),
                shrinkWrap: true,
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  var post = posts[index];
                  return InkWell(
                    onTap: () {
                      _navigateNested(context, index, post.id!);
                    },
                    child: PostImagesCarousel(
                      isProfile: true,
                      radius: 10,
                      post: post,
                      aspectRatio: aspectRatio,
                    ),
                  );
                },
              );
  }

  void _navigateNested(BuildContext context, int postIndex, String postId) {
    context.router.push(
      ProfilePostDetailRoute(
        ondeletePost: () {
          ondeletePost(postId).then((value) {
            if (value) {
              Navigator.pop(context);
            }
          });
        },
        postIndex: postIndex,
        index: 0,
        isUser: isUser,
        postType: PostType.Barter,
        posts: barterPosts,
        loadState: loadState,
        onRefresh: onRefresh,
      ),
    );
  }
}
