import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/home/presentation/notifier/home_notifier.dart';
import 'package:bartr/features/home/presentation/widgets/give_away_listview.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'home_list_view.dart';

class HomeTab extends StatefulHookConsumerWidget {
  const HomeTab({
    required this.bartrScrollController,
    required this.giveAwayScrollController,
    Key? key,
    required this.currentIndex,
    required this.barterPosts,
    required this.giveAwayPosts,
    required this.onRefresh,
    required this.loadState,
    required this.tabController,
  }) : super(key: key);

  final int currentIndex;
  final List<Post> barterPosts, giveAwayPosts;
  final Future<void> Function() onRefresh;
  final LoadState loadState;
  final TabController tabController;
  final ScrollController bartrScrollController;
  final ScrollController giveAwayScrollController;
  @override
  ConsumerState<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends ConsumerState<HomeTab> {
  int page = 1;

  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(() {
      ref.read(homeNotifier.notifier).changeIndex(widget.tabController.index);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeNotifier);
    final model = ref.read(homeNotifier.notifier);
    return NotificationListener<ScrollEndNotification>(
      onNotification: (not) {
        if (state.homeLoadState == LoadState.done) {
          return true;
        } else {
          if (not.metrics.pixels == not.metrics.maxScrollExtent &&
              not.metrics.axisDirection == AxisDirection.down) {
            setState(() {
              page = page + 1;
            });
            model.fetchPosts(
              page: page,
              loadmore: true,
            );
            return false;
          } else {
            return true;
          }
        }
      },
      child: TabBarView(
        controller: widget.tabController,
        children: [
          RefreshIndicator(
            onRefresh: () => model.fetchPosts(page: 1),
            child: HomeListView(
              onDeletePost: model.deletePost,
              onRetry: () => model.fetchPosts(page: 1),
              hasError: state.errorMessage != null &&
                  state.homeLoadState == LoadState.error,
              errorMessage: state.errorMessage,
              isLoadingMore: widget.loadState == LoadState.loadmore,
              scrollController: widget.bartrScrollController,
              isLoading: widget.loadState == LoadState.loading,
              posts: widget.barterPosts,
            ),
          ),
          RefreshIndicator(
            onRefresh: () => model.fetchPosts(page: 1),
            child: GiveAwayListView(
              onDeletePost: model.deletePost,
              onRetry: () => model.fetchPosts(page: 1),
              hasError: state.errorMessage != null &&
                  state.homeLoadState == LoadState.error,
              errorMessage: state.errorMessage,
              isLoadingMore: widget.loadState == LoadState.loadmore,
              scrollController: widget.giveAwayScrollController,
              isLoading: widget.loadState == LoadState.loading,
              posts: widget.giveAwayPosts,
            ),
          ),
        ],
      ),
    );
  }
}

class TabRow extends StatelessWidget {
  const TabRow({
    Key? key,
    required this.onTap,
    required this.text,
    this.icon,
    required this.index,
    required this.currentIndex,
    this.hasIcon = true,
  }) : super(key: key);
  final void Function()? onTap;
  final String text;
  final String? icon;
  final int index, currentIndex;
  final bool hasIcon;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            0,
            icon == null ? 15 : 10,
            0,
            icon == null ? 15 : 20,
          ),
          child: icon == null
              ? Center(
                  child: Text(
                    text,
                    style: Styles.w700(
                      size: 14,
                      color: currentIndex == index ? null : BartrColors.grey,
                    ),
                    textScaleFactor: 1,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/$icon.svg",
                      color: currentIndex == index
                          ? BartrColors.primary
                          : BartrColors.grey,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      text,
                      style: Styles.w700(
                        size: 14,
                        color: currentIndex == index ? null : BartrColors.grey,
                      ),
                      textScaleFactor: 1,
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
