import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/router/routes.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/general_widgets/bartr_loader.dart';

import '../widgets/profile_header_delegate.dart';
import '../widgets/profile_header_text_row.dart';
import '../widgets/profile_tab_bar.dart';
import '../widgets/profile_tabbar_view.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({
    Key? key,
  }) : super(key: key);
  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile>
    with TickerProviderStateMixin {
  final _controller = ScrollController();
  late TabController _tabController;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    final currentuser = ref.read(currentUserProvider);

    _onRefresh(currentuser: currentuser);
    super.initState();
  }

  Future<void> _onRefresh({required BartrUser currentuser}) async {
    ref
        .read(profileNotifier.notifier)
        .getUserProfile(username: currentuser.username!);
    ref
        .read(profileNotifier.notifier)
        .fetchUserPosts(userId: currentuser.username!, page: 1);
  }

  @override
  Widget build(BuildContext context) {
    final currentuser = ref.watch(currentUserProvider);

    final model = ref.read(profileNotifier.notifier);
    final state = ref.watch(profileNotifier);
    return RefreshIndicator(
      onRefresh: () => _onRefresh(currentuser: currentuser),
      child: Scaffold(
        body: NestedScrollView(
          controller: _controller,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: ProfileHeaderDelegate(
                  isUserProfile: true,
                  user: currentuser,
                  currentUser: currentuser,
                  mintExtent: 60,
                  maxtExtent: 290,
                ),
              ),
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                title: state.profileLoadState == LoadState.loading
                    ? const BartrLoader(
                        color: BartrColors.primary,
                      )
                    : state.profileLoadState == LoadState.error
                        ? const SizedBox()
                        : ProfileHeaderTextRow(
                            posts: state.posts,
                            bartrUser: state.bartrUser!,
                          ),
                backgroundColor: Colors.white,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(50),
                  child: ProfileTabBar(
                    currentIndex: _tabController.index,
                    onTap1: () {
                      _tabController.animateTo(0);
                    },
                    onTap2: () {
                      _tabController.animateTo(1);
                    },
                  ),
                ),
              )
            ];
          },
          body: ProfileTabBody(
              onRefresh: () => _onRefresh(currentuser: currentuser),
            controller: _tabController,
            state: state,
            model: model,
            userId: currentuser.id!,
          ),
        ),
      ),
    );
  }
}
