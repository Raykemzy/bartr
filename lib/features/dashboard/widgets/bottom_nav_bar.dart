import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/router/routes.dart';
import 'package:bartr/core/services/firebase/firestor_service.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/domain/models/bar_item.dart';
import 'package:bartr/features/messages/presentation/notifer/chat_list_notifier.dart';
import 'package:bartr/general_widgets/cached_network_image_display.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../general_widgets/count_indicator.dart';
import '../../messages/presentation/notifer/user_message.dart';

class BartrBottomNavBar extends HookConsumerWidget {
  final List<BarItem> barItems;
  final Function(int) onBarTap;
  final int tabIndex;
  const BartrBottomNavBar({
    Key? key,
    required this.barItems,
    required this.tabIndex,
    required this.onBarTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final user = ref.watch(currentUserProvider);
    final selectedBarIndex = useState(0);
    bool largeScreen = MediaQuery.of(context).size.width > 800 ? true : false;
    final fireservice = ref.read(fireStoreServiceProvider);
    AsyncValue<QuerySnapshot<Map<String, dynamic>>> unreadMessages =
        ref.watch(unreadMessageProvider);

    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: const Offset(0, 5),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      height: 83,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildBarItems(
          selectedBarIndex: selectedBarIndex,
          largeScreen: largeScreen,
          user: user,
          unreadMessages: unreadMessages,
          fireservice: fireservice,
          context: context,
        ),
      ),
    );
  }

  List<Widget> _buildBarItems({
    required ValueNotifier<int> selectedBarIndex,
    required bool largeScreen,
    required BartrUser user,
    required BuildContext context,
    required FirestoreService fireservice,
    required AsyncValue<QuerySnapshot<Map<String, dynamic>>> unreadMessages,
  }) {
    List<Widget> bottombaritem = [];
    for (int i = 0; i < barItems.length; i++) {
      BarItem item = barItems[i];
      bool isSelected = tabIndex == i;
      bottombaritem.add(
        Expanded(
          child: MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              selectedBarIndex.value = i;
              onBarTap(selectedBarIndex.value);
            },
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (item.text == "Profile" && user.profilePicture != null)
                        ? CachedNetworkDisplay(
                            url: user.profilePicture!,
                            height: 30,
                            width: 30,
                          )
                        : SvgPicture.asset(
                            isSelected ? item.selectedicon : item.icon,
                          ),
                    const SizedBox(height: 8),
                    Text(
                      item.text,
                      style: TextStyle(
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: BartrColors.primary,
                        fontSize: 10,
                      ),
                      textScaleFactor: 1,
                    )
                  ],
                ),
                if (i == 2)
                  unreadMessages.when(
                    data: (data) {
                      if (data.docs.isNotEmpty) {
                        Set<String> unreadIds = {};
                        data.docs.map((e) {
                          unreadIds.add(e.data()["sender"]);
                          return UserMessage.fromMap(e.data());
                        }).toList();
                        return Positioned(
                          right: 11,
                          top: 11,
                          child: CountIndicator(
                            isSelected: isSelected,
                            count: unreadIds.length,
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                    error: (error, stackTrace) {
                      return const SizedBox();
                    },
                    loading: () {
                      return const SizedBox();
                    },
                  ),
              ],
            ),
          ),
        ),
      );
    }
    return bottombaritem;
  }
}
