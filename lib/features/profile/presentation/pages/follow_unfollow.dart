import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/profile/presentation/notifier/profile_notifier.dart';
import 'package:bartr/features/profile/presentation/pages/follow_tab_view.dart';
import 'package:bartr/features/profile/presentation/widgets/follow_unfollow_tab.dart';
import 'package:bartr/general_widgets/bartr_loader.dart';
import 'package:bartr/general_widgets/bartr_scaffold.dart';
import 'package:bartr/general_widgets/retry_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/config/configure_dependencies.dart';
import '../../../home/data/post_repository_impl.dart';
import '../notifier/profile_state.dart';

class FollowUnfollowView extends ConsumerStatefulWidget {
  const FollowUnfollowView({
    Key? key,
    @PathParam() required this.currentIndex,
    required this.userId,
    required this.username,
  }) : super(key: key);
  final int currentIndex;
  final String userId;
  final String username;
  @override
  ConsumerState<FollowUnfollowView> createState() => _FollowUnfollowViewState();
}

class _FollowUnfollowViewState extends ConsumerState<FollowUnfollowView> {
  final notifier =
      StateNotifierProvider.autoDispose<ProfileNotifier, ProfileState>(
    (_) => ProfileNotifier(
      _.read(postsRepository),
      _.read(userRepository),
    ),
  );
  final _controller = ScrollController();
  int currentIndex = 0;
  void changeIndex(int newIndex) {
    setState(() {
      currentIndex = newIndex;
    });
  }

  late ProfileNotifier model;
  @override
  void initState() {
    model = ref.read(notifier.notifier);
    model.getUserProfile(username: widget.username);
    currentIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notifier);

    return BartrScaffold(
      child: state.profileLoadState == LoadState.loading
          ? const BartrLoader(
              color: BartrColors.primary,
            )
          : NestedScrollView(
              controller: _controller,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  automaticallyImplyLeading: true,
                  forceElevated: true,
                  centerTitle: true,
                  title: Text(
                    state.profileLoadState == LoadState.success
                        ? state.bartrUser!.fullName!
                        : "",
                    style: Styles.w500(
                      size: 16,
                      color: BartrColors.black,
                    ),
                  ),
                ),
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  titleSpacing: 0,
                  elevation: 0,
                  title: FollowUnfollowTabBar(
                    changeIndex0: changeIndex,
                    changeIndex1: changeIndex,
                    currentIndex: currentIndex,
                  ),
                ),
              ],
              body: state.profileLoadState == LoadState.error
                  ? RetryWidget(
                      onRetry: () => ref
                          .read(notifier.notifier)
                          .getUserProfile(username: widget.username),
                    )
                  : FollowTabView(
                      followers: state.followers,
                      following: state.following,
                      controller: _controller,
                      onRefresh: () => ref
                          .read(notifier.notifier)
                          .getUserProfile(username: widget.username),
                      loadState: state.profileLoadState == LoadState.loading,
                      currentIndex: currentIndex,
                    ),
            ),
    );
  }
}
