import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/features/bids/domain/user_bids_model.dart';
import 'package:bartr/features/bids/presentation/widgets/bids_received_grid.dart';
import 'package:bartr/features/bids/presentation/widgets/bids_sent_grid.dart';
import 'package:bartr/features/bids/presentation/widgets/no_bids.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BidsTabView extends StatefulHookConsumerWidget {
  final ScrollController controller;
  final Future<void> Function() onRefresh;
  final int currentIndex;
  final NavigationViewType viewType;
  final void Function(int) changeIndex;
  final List<ReceivedBid> receivedBids;
  final List<SentBid> sentBids;
  final bool isLoading;
  const BidsTabView({
    Key? key,
    required this.controller,
    required this.onRefresh,
    required this.currentIndex,
    required this.viewType,
    required this.changeIndex,
    required this.isLoading,
    required this.receivedBids,
    required this.sentBids,
  }) : super(key: key);

  @override
  ConsumerState<BidsTabView> createState() => _BidsTabViewState();
}

class _BidsTabViewState extends ConsumerState<BidsTabView> {
  late ScrollController _scrollController;
  late ScrollController _scrollController2;

  @override
  void dispose() {
    _scrollController2.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        widget.controller.jumpTo(_scrollController.position.pixels);
      });
    _scrollController2 = ScrollController()
      ..addListener(() {
        widget.controller.jumpTo(_scrollController2.position.pixels);
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: IndexedStack(
        index: widget.currentIndex,
        children: [
          (!widget.isLoading && widget.receivedBids.isEmpty)
              ? const Center(child: NoBids())
              : BidsReceivedGrid(
                  bids: widget.receivedBids,
                  viewType: widget.viewType,
                  isLoading: widget.isLoading,
                  scrollController: _scrollController,
                  currentIndex: widget.currentIndex,
                  changeIndex: widget.changeIndex,
                ),
          (!widget.isLoading && widget.sentBids.isEmpty)
              ? const Center(child: NoBids())
              : BidsSentGrid(
                  bids: widget.sentBids,
                  viewType: widget.viewType,
                  isLoading: widget.isLoading,
                  scrollController: _scrollController2,
                  currentIndex: widget.currentIndex,
                  changeIndex: widget.changeIndex,
                )
        ],
      ),
    );
  }
}
