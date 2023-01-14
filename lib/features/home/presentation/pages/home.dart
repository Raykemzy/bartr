import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/services/firebase/firestor_service.dart';
import 'package:bartr/features/dashboard/widgets/bartr_fab.dart';
import 'package:bartr/features/home/presentation/notifier/home_notifier.dart';
import 'package:bartr/features/home/presentation/widgets/bartr_searchbar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../widgets/bartr_home_appbar.dart';
import '../widgets/home_tab_bar.dart';

class Home extends StatefulHookConsumerWidget {
  const Home(
      {required this.bartrScrollController,
      required this.giveAwayScrollController,
      Key? key})
      : super(key: key);
  final ScrollController bartrScrollController;
  final ScrollController giveAwayScrollController;
  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  int page = 1;
  late TabController _tabController;

  void _updateActivityStatusListener(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.read(homeNotifier.notifier).fetchPosts(
            page: page,
          );
      _updateActivity(true);
    } else if (state == AppLifecycleState.detached ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _updateActivity(false);
    }
  }

  void _updateActivity(bool isOnline) {
    ref.read(fireStoreServiceProvider).updateActiveStatus(
      userID: ref.read(currentUserProvider).id!,
      data: {
        "isOnline": isOnline,
        "last_seen": DateTime.now(),
        "user_id": ref.read(currentUserProvider).id!,
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      animationDuration: const Duration(milliseconds: 10),
    );
    ref.read(homeNotifier.notifier).fetchPosts(
          page: page,
        );

    _updateActivity(true);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _updateActivityStatusListener(state);
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeNotifier);

    return Scaffold(
      appBar: BartrHomeAppBar(
        controller1: widget.bartrScrollController,
        controller2: widget.giveAwayScrollController,
      ),
      body: Scaffold(
        appBar: BartrHomeSearchBar(
          tabController: _tabController,
        ),
        body: HomeTab(
          bartrScrollController: widget.bartrScrollController,
          giveAwayScrollController: widget.giveAwayScrollController,
          tabController: _tabController,
          barterPosts: state.barterPosts,
          giveAwayPosts: state.giveAwayPosts,
          currentIndex: _tabController.index,
          loadState: state.homeLoadState,
          onRefresh: () =>
              ref.read(homeNotifier.notifier).fetchPosts(page: page),
        ),
      ),
      // ),
      floatingActionButton: const BartrFab(),
    );
  }
}
