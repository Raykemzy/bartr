import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/router/router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../features/home/data/post_repository_impl.dart';
import '../../features/login/domain/models/login_model.dart';
import '../config/configure_dependencies.dart';

mixin PostMixin {
  Future<bool> likePost(Post post, WidgetRef ref) async {
    try {
      final response =
          await ref.read(postsRepository).likeAndUnlikePost(post.id!);
      if (response.status) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> followOrUnfollow(String userId, WidgetRef ref) async {
    try {
      final response =
          await ref.read(userRepository).followOrUnfollowUser(userId);
      if (response.status) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> likeComment(String id, WidgetRef ref) async {
    try {
      final response = await ref.read(postsRepository).likeAndUnlikeComment(id);
      if (response.status) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}

mixin NavigationMixin {
  void navigateToComment({
    required BuildContext context,
    required Post post,
  }) {
    context.router.push(
      CommentScreenRoute(
        postId: post.id!,
      ),
    );
  }

  void navigateToPostDetail({
    required BuildContext context,
    required String postId,
  }) {
    context.router.push(
      PostDetailRoute(
        postId: postId,
      ),
    );
  }

  void navigateToProfile({
    required BuildContext context,
    required String userId,
    required String username,
  }) {
    context.router.push(
      OtherUserProfileRoute(
        userId: userId,
        username: username,
      ),
    );
  }
}
