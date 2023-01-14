import 'dart:async';

import 'package:bartr/core/helpers/helper_functions.dart';
import 'package:bartr/core/router/router.dart';
import 'package:bartr/features/dashboard/notifier/dashboard_notifier.dart';
import 'package:bartr/features/dashboard/widgets/bottom_nav_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uni_links/uni_links.dart';

import '../../../core/config/configure_dependencies.dart';
import '../../../core/config/exception/logger.dart';
import '../../../core/router/routes.dart';
import '../../../core/services/local_database/hive_keys.dart';
import '../../../domain/models/bar_item.dart';
import '../../messages/domain/dtos/notification_dto.dart';

class BartrDashBoard extends StatefulHookConsumerWidget {
  const BartrDashBoard({Key? key}) : super(key: key);

  @override
  ConsumerState<BartrDashBoard> createState() => _BartrDashBoardState();
}

class _BartrDashBoardState extends ConsumerState<BartrDashBoard> {
  late ScrollController giveawayScrollController;
  late ScrollController bartrScrollController;
  StreamSubscription? sub;
  @override
  void dispose() {
    if (!mounted) {
      bartrScrollController.dispose();
      giveawayScrollController.dispose();
      sub?.cancel();
    }

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    giveawayScrollController = ScrollController();
    bartrScrollController = ScrollController();
    ref.read(dashboardNotifier.notifier).requestAndRegisterNotification();
    _listener();
    _deepLink();
  }

  void _deepLink() {
    // Attach a listener to the stream
    sub = uriLinkStream.listen((Uri? uri) async {
      if (uri != null) {
        if (uri.pathSegments.isNotEmpty) {
          if (uri.pathSegments[0] == 'post') {
            final newLocation = PostDetailRoute(
              postId: uri.pathSegments[1],
            );
            context.router.navigate(
              newLocation,
            );
          }
        }
      }
    }, onError: (err) {
      debugLog("Error opening app link: $err");
    });
  }

  void _listener() {
    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      debugLog(event);
      final data = Data.fromJson(event.data);
      if (data.receiverId == ref.read(currentUserProvider).id) {
        if (data.type == NotificationType.message) {
          Member member = Member(
            username: data.username,
            fcmPushToken: data.fcmPushToken,
            fullName: data.fullName,
            id: data.id,
            profilePicture: data.profilePicture,
          );
          context.router.navigate(
            MessageRouter(
              children: [
                const MessagesScreenRoute(),
                ChatPageRoute(
                  user: member,
                  chatRoomId: data.conversationId,
                )
              ],
            ),
          );
          FlutterAppBadger.isAppBadgeSupported().then((value) async {
            if (value) {
              int badgeCount =
                  Hive.box(HiveKeys.badge).get(HiveKeys.badgeCount) ?? 0;
              int newVal = badgeCount - 1;
              await Hive.box(HiveKeys.badge).put(HiveKeys.badgeCount, newVal);
              FlutterAppBadger.updateBadgeCount(newVal);
            }
          });
        }
      }
    });
  }

  int currentTab = 0;

  final List<BarItem> barItems = [
    BarItem(
      text: "Home",
      icon: 'assets/icons/home.svg',
      selectedicon: 'assets/icons/home_fill.svg',
    ),
    BarItem(
      text: "My bids",
      icon: 'assets/icons/discover.svg',
      selectedicon: 'assets/icons/discover_fill.svg',
    ),
    BarItem(
      text: "Messages",
      icon: 'assets/icons/sms.svg',
      selectedicon: 'assets/icons/sms_fill.svg',
    ),
    BarItem(
      text: "Notifications",
      icon: 'assets/icons/notification.svg',
      selectedicon: 'assets/icons/notification_fill.svg',
    ),
    BarItem(
      text: "Profile",
      icon: 'assets/icons/profile.svg',
      selectedicon: 'assets/icons/profile.svg',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    // useEffect(() {

    // });
    return AutoTabsRouter(
      routes: [
        HomeRouter(children: [
          HomeRoute(
              bartrScrollController: bartrScrollController,
              giveAwayScrollController: giveawayScrollController),
        ]),
        const BidsRouter(children: [BidsPageRoute()]),
        const MessageRouter(children: [MessagesScreenRoute()]),
        const NotificationRouter(children: [NotificationViewRoute()]),
        const ProfileRouter(children: [ProfileRoute()]),
      ],
      builder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    width: Helpers.width(context),
                    height: Helpers.height(context),
                    child: Stack(
                      children: <Widget>[
                        child,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BartrBottomNavBar(
            barItems: barItems,
            tabIndex: tabsRouter.activeIndex,
            onBarTap: (val) {
              if (val == tabsRouter.activeIndex && tabsRouter.canPop()) {
                tabsRouter.popTop();
              }
              _toTop(tabsRouter, val, bartrScrollController);
              _toTop(tabsRouter, val, giveawayScrollController);
              tabsRouter.setActiveIndex(val);
              if (tabsRouter.previousIndex == val) {
                tabsRouter.popTop();
              }
            },
          ),
        );
      },
    );
  }

  void _toTop(TabsRouter tabsRouter, int val, ScrollController controller) {
    if (tabsRouter.activeIndex == 0 &&
        val == 0 &&
        !tabsRouter.canPop() &&
        controller.hasClients &&
        controller.position.pixels != controller.position.minScrollExtent) {
      controller.animateTo(0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }
}
