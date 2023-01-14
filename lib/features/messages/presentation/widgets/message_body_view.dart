import 'package:bartr/core/router/routes.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/features/messages/presentation/notifer/user_message.dart';
import 'package:bartr/features/messages/presentation/widgets/grouped_messages.dart';
import 'package:bartr/features/messages/presentation/widgets/message_field.dart';
import 'package:bartr/general_widgets/bartr_loader.dart';
import 'package:bartr/general_widgets/retry_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/config/configure_dependencies.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/services/local_database/hive_keys.dart';
import '../notifer/chat_list_notifier.dart';
import 'chat_item_bid_detail.dart';

class MessageBodyView extends StatefulHookConsumerWidget {
  const MessageBodyView({
    Key? key,
    required this.chatRoomId,
    required this.otherUser,
    this.postBid,
  }) : super(key: key);
  final String chatRoomId;

  final PostBid? postBid;
  final Member otherUser;

  @override
  ConsumerState<MessageBodyView> createState() => _MessageBodyViewState();
}

class _MessageBodyViewState extends ConsumerState<MessageBodyView> {
  final _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<QuerySnapshot<Map<String, dynamic>>> unreadMessages =
        ref.watch(unreadMessageProvider);
    final currentuser = ref.watch(currentUserProvider);
    AsyncValue<QuerySnapshot<Map<String, dynamic>>> msg =
        ref.watch(messageProvider(widget.chatRoomId));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        msg.when(
          data: (data) {
            unreadMessages.when(data: (data) {
              if (data.docs.isNotEmpty) {
                List<UserMessage> snapshots = data.docs
                    .map((e) => UserMessage.fromMap(e.data()))
                    .toList();
                for (var element in data.docs) {
                  var message = UserMessage.fromMap(element.data());
                  if (message.sender == widget.otherUser.id) {
                    ref.read(chatListProvider.notifier).deleteMessage(
                          senderid: widget.otherUser.id,
                          currentUserId: currentuser.id!,
                        );
                    FlutterAppBadger.isAppBadgeSupported().then((value) async {
                      if (value) {
                        int badgeCount =
                            Hive.box(HiveKeys.badge).get(HiveKeys.badgeCount) ??
                                0;
                        int newVal = badgeCount -
                            snapshots
                                .where((element) =>
                                    element.sender == widget.otherUser.id)
                                .toList()
                                .length;

                        await Hive.box(HiveKeys.badge)
                            .put(HiveKeys.badgeCount, newVal < 0 ? 0 : newVal);
                        FlutterAppBadger.updateBadgeCount(
                            newVal < 0 ? 0 : newVal);
                      }
                    });
                  }
                }
              }
              return const SizedBox();
            }, error: (obj, st) {
              return const Text("");
            }, loading: () {
              return const Text("");
            });
            List<UserMessage> snapshots = data.docs
                .map((e) => UserMessage.fromMap(e.data()))
                .toList()
                .reversed
                .toList();
            Groups<DateTime, UserMessage> groups = snapshots.groupBy(
              (p0) => DateTime.parse(p0.createdAt!.toDate().splitDateOnly()),
            );
            return (groups.keys.isEmpty && widget.postBid != null)
                ? Expanded(
                    child: SingleChildScrollView(
                        child: ChatItemBidsDetail(postBid: widget.postBid!)))
                : Expanded(
                    child: SingleChildScrollView(
                      reverse: true,
                      controller: _scrollController,
                      child: Column(
                        children: [
                          if (widget.postBid != null)
                            ChatItemBidsDetail(postBid: widget.postBid!),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            reverse: true,
                            padding: const EdgeInsets.only(
                              left: 14,
                              right: 14,
                              top: 10,
                            ),
                            shrinkWrap: true,
                            itemCount: groups.keys.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GroupedMessages(
                                    messages: groups.children[index],
                                    header: groups
                                        .keys[index].convertDateHeaderToString,
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
          },
          error: (error, stackTrace) => RetryWidget(onRetry: () {}),
          loading: () => const Expanded(
            child: BartrLoader(
              color: BartrColors.primary,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: MessageField(
            otherUserId: widget.otherUser.id,
            senderImageUrl: '',
            timeSent: DateTime.now(),
            chatRoomId: widget.chatRoomId,
            otherUser: widget.otherUser,
          ),
        ),
      ],
    );
  }
}
