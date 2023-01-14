import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/router/routes.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/general_widgets/bartr_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/textstyles.dart';
import '../../../../general_widgets/retry_widget.dart';
import '../../../home/data/post_repository_impl.dart';
import '../widgets/profile_header_delegate.dart';
import '../widgets/profile_header_text_row.dart';
import '../widgets/profile_tab_bar.dart';
import '../widgets/profile_tabbar_view.dart';

class OtherUserProfile extends ConsumerStatefulWidget {
  const OtherUserProfile({
    Key? key,
    @PathParam() required this.userId,
    required this.username,
  }) : super(key: key);
  final String userId;
  final String username;
  @override
  ConsumerState<OtherUserProfile> createState() => _OtherUserProfileState();
}

class _OtherUserProfileState extends ConsumerState<OtherUserProfile>
    with SingleTickerProviderStateMixin {
  final _controller = ScrollController();
  late TabController _tabController;
  final notifier =
      StateNotifierProvider.autoDispose<ProfileNotifier, ProfileState>(
    (_) => ProfileNotifier(
      _.read(postsRepository),
      _.read(userRepository),
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _onRefresh(username: widget.username, userId: widget.userId);
    _tabController = TabController(
      length: 2,
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
  }

  Future<void> _onRefresh(
      {required String username, required String userId}) async {
    ref.read(notifier.notifier).getUserProfile(username: username);
    ref.read(notifier.notifier).fetchUserPosts(userId: username, page: 1);
  }

  @override
  Widget build(BuildContext context) {
    final currentuser = ref.watch(currentUserProvider);
    final model = ref.read(notifier.notifier);
    final state = ref.watch(notifier);
    return RefreshIndicator(
      onRefresh: () =>
          _onRefresh(userId: widget.userId, username: widget.username),
      child: Scaffold(
        body: state.profileLoadState == LoadState.loading
            ? const BartrLoader(
                color: BartrColors.primary,
              )
            : (state.profileLoadState == LoadState.error &&
                    state.bartrUser == null &&
                    state.errorMessage != null)
                ? RetryWidget(
                    retryText: "Go back",
                    errorMessage: state.errorMessage,
                    onRetry: () => Navigator.pop(context),
                  )
                : NestedScrollView(
                    controller: _controller,
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverPersistentHeader(
                          pinned: true,
                          floating: false,
                          delegate: ProfileHeaderDelegate(
                            isUserProfile: false,
                            user: state.bartrUser!,
                            currentUser: currentuser,
                            mintExtent: 60,
                            maxtExtent: 290,
                          ),
                        ),
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          pinned: true,
                          title: ProfileHeaderTextRow(
                            posts: state.posts,
                            bartrUser: state.bartrUser!,
                          ),
                          backgroundColor: Colors.white,
                          bottom: PreferredSize(
                            preferredSize: const Size.fromHeight(100),
                            child: Column(
                              children: [
                                if (currentuser.id != state.bartrUser!.id)
                                  ProfileFollowButton(
                                    user: state.bartrUser!,
                                    notifier: notifier,
                                  ),
                                ProfileTabBar(
                                  currentIndex: _tabController.index,
                                  onTap1: () {
                                    _tabController.animateTo(0);
                                  },
                                  onTap2: () {
                                    _tabController.animateTo(1);
                                  },
                                )
                              ],
                            ),
                          ),
                        )
                      ];
                    },
                    body: ProfileTabBody(
                      onRefresh: () => _onRefresh(
                          userId: widget.userId, username: widget.username),
                      controller: _tabController,
                      state: state,
                      model: model,
                      userId: state.bartrUser!.id!,
                    ),
                  ),
      ),
    );
  }
}

class ProfileFollowButton extends HookConsumerWidget {
  const ProfileFollowButton({
    Key? key,
    required this.user,
    required this.notifier,
  }) : super(key: key);
  final BartrUser user;
  final AutoDisposeStateNotifierProvider<ProfileNotifier, ProfileState>
      notifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.read(notifier.notifier);
    final currentuser = ref.watch(currentUserProvider);

    ValueNotifier<BartrUser> postState = useState(user);
    BartrUser postuser = postState.value;

    ValueNotifier<bool> isFollowing = useState(
      user.followers!.any((element) => element.id == currentuser.id),
    );

    void changeLikeStatus() {
      if (!isFollowing.value) {
        isFollowing.value = true;
      } else {
        isFollowing.value = false;
      }
    }

    void followAndUnfollow() async {
      changeLikeStatus();
      final res = await model.followOrUnfollow(postuser.id!);
      if (!res) {
        changeLikeStatus();
        return;
      }
      ref.read(notifier.notifier).getUserProfile(username: user.username!);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: followAndUnfollow,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 100,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: isFollowing.value
                  ? BartrColors.lightGrey
                  : BartrColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              isFollowing.value ? "Following" : "Follow",
              style: Styles.w400(
                size: 12,
                color: !isFollowing.value
                    ? BartrColors.lightGrey
                    : BartrColors.primary,
              ),
              textScaleFactor: 1,
            ),
          ),
        ),
        // Container(
        //   padding: const EdgeInsets.all(5),
        //   decoration: BoxDecoration(
        //     shape: BoxShape.circle,
        //     border: Border.all(
        //       color: isFollowing.value
        //           ? BartrColors.lightGrey
        //           : BartrColors.primary,
        //     ),
        //   ),
        //   child: SvgPicture.asset("assets/icons/sms.svg"),
        // )
      ],
    );
  }
}
