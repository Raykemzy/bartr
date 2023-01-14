import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:bartr/features/profile/presentation/widgets/followers_lists.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FollowTabView extends StatefulHookConsumerWidget {
  const FollowTabView({
    Key? key,
    required this.controller,
    required this.onRefresh,
    required this.loadState,
    required this.currentIndex,
    required this.followers,
    required this.following,
  }) : super(key: key);
  final ScrollController controller;
  final Future<void> Function() onRefresh;
  final bool loadState;
  final int currentIndex;
  final List<Follow> followers;
  final List<Follow> following;
  @override
  ConsumerState<FollowTabView> createState() => _HomeTabState();
}

class _HomeTabState extends ConsumerState<FollowTabView> {
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
          FollowersLists(
            followers: widget.followers,
            controller: _scrollController,
            loadState: widget.loadState,
          ),
          FollowersLists(
            followers: widget.following,
            controller: _scrollController2,
            loadState: widget.loadState,
          ),
        ],
      ),
    );
  }
}
