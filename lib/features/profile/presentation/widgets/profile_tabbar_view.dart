import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/helpers/mixins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/enums.dart';
import '../notifier/profile_notifier.dart';
import '../notifier/profile_state.dart';
import 'profile_barter_gridview.dart';
import 'profile_giveaway_gridview.dart';

class ProfileTabBody extends ConsumerStatefulWidget {
  const ProfileTabBody({
    Key? key,
    required this.state,
    required this.model,
    required this.userId,
    required this.controller,
    required this.onRefresh,
  }) : super(key: key);

  final ProfileState state;
  final ProfileNotifier model;
  final String userId;
  final TabController controller;
  final Future<void> Function() onRefresh;

  @override
  ConsumerState<ProfileTabBody> createState() => _ProfileTabBodyState();
}

class _ProfileTabBodyState extends ConsumerState<ProfileTabBody> with PostMixin{
  int page = 1;
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);
    return NotificationListener<ScrollEndNotification>(
      onNotification: (not) {
        if (widget.state.postLoadState == LoadState.done) {
          return true;
        } else {
          if (not.metrics.pixels == not.metrics.maxScrollExtent &&
              not.metrics.axisDirection == AxisDirection.down) {
            setState(() {
              page = page + 1;
            });
            widget.model.fetchUserPosts(
              page: page,
              loadmore: true,
              userId: widget.userId,
            );
            return false;
          } else {
            return true;
          }
        }
      },
      child: TabBarView(
        controller: widget.controller,
        children: [
          RefreshIndicator(
            onRefresh: widget.onRefresh,
            child: ProfileBarterGrid(
              ondeletePost: widget.model.deletePost,
              isUser: widget.userId == currentUser.id,
              loadState: widget.state.postLoadState,
              onRefresh: widget.onRefresh,
              posts: widget.state.barterPosts,
              barterPosts: widget.state.barterPosts,
              giveAwayPosts: widget.state.giveAwayPosts,
            ),
          ),
          RefreshIndicator(
            onRefresh: widget.onRefresh,
            child: ProfileGiveAwayGrid(
                 ondeletePost: widget.model.deletePost,
              isUser: widget.userId == currentUser.id,
              loadState: widget.state.postLoadState,
              onRefresh: widget.onRefresh,
              posts: widget.state.giveAwayPosts,
              barterPosts: widget.state.barterPosts,
              giveAwayPosts: widget.state.giveAwayPosts,
            ),
          ),
        ],
      ),
    );
  }
}
