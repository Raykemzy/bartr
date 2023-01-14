import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/bids/presentation/notifier/bids_notifier.dart';
import 'package:bartr/features/bids/presentation/widgets/bids_page_tab_bar.dart';
import 'package:bartr/features/bids/presentation/widgets/bids_tab_bar_view.dart';
import 'package:bartr/general_widgets/bartr_loader.dart';
import 'package:bartr/general_widgets/retry_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BidsPage extends ConsumerStatefulWidget {
  const BidsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<BidsPage> createState() => _DiscoverState();
}

class _DiscoverState extends ConsumerState<BidsPage>
    with WidgetsBindingObserver {
  final _controller = ScrollController();
  bool hasFocus = false;
  late BidsNotifier _model;
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.read(bidsNotifier.notifier).fetchUserBids();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    super.initState();
    _model = ref.read(bidsNotifier.notifier);
    WidgetsBinding.instance.addObserver(this);
    _model.fetchUserBids();
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.read(bidsNotifier.notifier);
    final state = ref.watch(bidsNotifier);
    return RefreshIndicator(
      onRefresh: () => _model.fetchUserBids(),
      child: Scaffold(
        body: NestedScrollView(
          controller: _controller,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                forceElevated: true,
                centerTitle: true,
                title: hasFocus
                    ? TextField(
                        onChanged: (val) {},
                        onSubmitted: (val) {
                          FocusScope.of(context).unfocus();
                        },
                      )
                    : Text(
                        Strings.myBids,
                        style: Styles.w500(
                          size: 16,
                          color: BartrColors.black,
                        ),
                      ),
                // actions: [
                //   if (hasFocus)
                //     GestureDetector(
                //       onTap: () {
                //         setState(() {
                //           hasFocus = false;
                //         });
                //       },
                //       child: Center(
                //         child: Padding(
                //           padding: const EdgeInsets.only(right: 10),
                //           child: Text(
                //             "Cancel",
                //             style: Styles.w500(size: 12),
                //             textAlign: TextAlign.center,
                //           ),
                //         ),
                //       ),
                //     ),
                //   if (!hasFocus)
                //     GestureDetector(
                //       onTap: () {
                //         setState(() {
                //           hasFocus = true;
                //         });
                //       },
                //       child: Padding(
                //         padding: const EdgeInsets.only(right: 10),
                //         child: Image.asset(
                //           "assets/images/searchicon.png",
                //           width: 20,
                //         ),
                //       ),
                //     ),
                // ],
              ),
              SliverAppBar(
                pinned: true,
                floating: true,
                titleSpacing: 0,
                elevation: 0,
                title: BidsTabBar(
                  changeIndex0: model.changeIndex,
                  changeIndex1: model.changeIndex,
                  currentIndex: state.currentIndex,
                ),
              ),
            ];
          },
          body: state.bidsLoadState == LoadState.error
              ? RetryWidget(
                  onRetry: () => _model.fetchUserBids(),
                )
              : state.bidsLoadState == LoadState.loading
                  ? const BartrLoader(
                      color: BartrColors.primary,
                    )
                  : BidsTabView(
                      viewType: NavigationViewType.bids,
                      controller: _controller,
                      onRefresh: () => _model.fetchUserBids(),
                      currentIndex: state.currentIndex,
                      receivedBids: state.receivedBids,
                      sentBids: state.sentBids,
                      isLoading: state.bidsLoadState == LoadState.loading,
                      changeIndex: model.changeIndex,
                    ),
        ),
      ),
    );
  }
}
