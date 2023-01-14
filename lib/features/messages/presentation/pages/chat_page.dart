import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/bids/domain/user_bids_model.dart';
import 'package:bartr/features/messages/domain/models/conversation_model.dart';
import 'package:bartr/features/messages/presentation/notifer/chat_list_notifier.dart';
import 'package:bartr/features/messages/presentation/widgets/message_body_view.dart';
import 'package:bartr/general_widgets/cached_network_image_display.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

import '../../../../core/router/router.dart';
import '../../../../core/utils/enums.dart';

class ChatPage extends ConsumerWidget {
  final Member user;
  final String chatRoomId;
  final PostBid? postBid;

  const ChatPage({
    super.key,
    required this.user,
    required this.chatRoomId,
    this.postBid,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<DocumentSnapshot<Map<String, dynamic>>> lastSeen =
        ref.watch(lastSeenProvider(user.id));
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: ChatPageHeader(user: user, lastSeen: lastSeen),
      ),
      body: MessageBodyView(
        chatRoomId: chatRoomId,
        otherUser: user,
        postBid: postBid,
      ),
    );
  }
}

class ChatPageHeader extends StatelessWidget {
  const ChatPageHeader({
    Key? key,
    required this.user,
    required this.lastSeen,
  }) : super(key: key);

  final Member user;
  final AsyncValue<DocumentSnapshot<Map<String, dynamic>>> lastSeen;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => context.router.pop(),
          child: Image.asset(
            "assets/images/backarrow.png",
            scale: 4,
          ),
        ),
        const SizedBox(width: 20),
        InkWell(
          onTap: () => _navigateNested(context, NavigationViewType.messages),
          child: Row(
            children: [
              CachedNetworkDisplay(
                url: user.profilePicture,
                height: 40,
                width: 40,
                radius: 70,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.username,
                    style: Styles.w600(
                      size: 16,
                      color: BartrColors.black,
                    ),
                  ),
                  lastSeen.when(data: (data) {
                    return (data.data() == null)
                        ? Text(
                            "Inactive",
                            style: Styles.w400(
                              size: 10,
                              color: BartrColors.grey,
                            ),
                          )
                        : data["isOnline"] == true
                            ? Text(
                                "Online",
                                style: Styles.w400(
                                  size: 10,
                                  color: BartrColors.grey,
                                ),
                              )
                            : Timeago(
                                date: data["last_seen"].toDate(),
                                builder: (context, value) {
                                  return Text(
                                    "Last seen $value",
                                    style: Styles.w400(
                                      size: 10,
                                      color: BartrColors.grey,
                                    ),
                                  );
                                },
                              );
                  }, error: (obj, st) {
                    return const Text("..");
                  }, loading: () {
                    return const Text("..");
                  }),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _navigateNested(
    BuildContext context,
    NavigationViewType viewType,
  ) {
    context.router.push(
    
          OtherUserProfileRoute(
            userId: user.id,
            username: user.username,
          ),
      
    );
  }
}
