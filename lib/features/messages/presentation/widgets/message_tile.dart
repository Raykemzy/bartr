import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/helpers/helper_functions.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/messages/presentation/notifer/user_message.dart';
import 'package:bartr/general_widgets/cached_network_image_display.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

import '../../domain/models/conversation_model.dart';
import '../notifer/chat_list_notifier.dart';

class MessageTile extends ConsumerWidget {
  final Member user;
  final String chatId;
  final VoidCallback onTap;
  const MessageTile({
    Key? key,
    required this.user,
    required this.onTap,
    required this.chatId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<DocumentSnapshot<Map<String, dynamic>>>? chatPreview;
    AsyncValue<QuerySnapshot<Map<String, dynamic>>> unreadMessages =
        ref.watch(unreadMessageProvider);
    if (chatId.isNotEmpty) {
      chatPreview = ref.watch(lastMessageProvider(chatId));
    }

    final currentuser = ref.watch(currentUserProvider);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CachedNetworkDisplay(
                  url: user.profilePicture,
                  width: 45,
                  height: 45,
                  radius: 70,
                ),
                SizedBox(
                  width: Helpers.width(context) * 0.03,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.47,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        user.username,
                        style: Styles.w600(
                          size: 16,
                          color: BartrColors.black,
                        ),
                      ),
                      if (chatPreview == null)
                        Text(
                          "Start conversation",
                          style: Styles.w400(
                            size: 12,
                            color: BartrColors.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      if (chatPreview != null)
                        chatPreview.when(data: (data) {
                          String message = (data.data() != null)
                              ? data["sender"] == currentuser.id
                                  ? "You: ${data["text"]}"
                                  : data["text"]
                              : "Start Conversation";
                          return Text(
                            message,
                            style: Styles.w400(
                              size: 12,
                              color: BartrColors.grey,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          );
                        }, error: (obj, st) {
                          return const Text("...");
                        }, loading: () {
                          return const Text("...");
                        }),
                    ],
                  ),
                ),
              ],
            ),
            if (chatPreview != null)
              chatPreview.when(data: (data) {
                var time = data.data() != null ? data["createdAt"] : "";
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    time is String
                        ? Text(
                            time,
                            style: Styles.w400(
                              size: 12,
                              color: BartrColors.grey,
                            ),
                          )
                        : Timeago(
                            locale: "en_short",
                            date: time.toDate(),
                            builder: (context, value) {
                              return Text(
                                value,
                                style: Styles.w400(
                                  size: 10,
                                  color: BartrColors.grey,
                                ),
                              );
                            },
                          ),
                    const SizedBox(height: 10),
                    unreadMessages.when(data: (data) {
                      if (data.docs.isNotEmpty) {
                        for (var element in data.docs) {
                          List<UserMessage> usermessages = data.docs
                              .map((e) => UserMessage.fromMap(e.data()))
                              .toList();
                          var message = UserMessage.fromMap(element.data());
                          if (message.sender == user.id) {
                            return Container(
                              height: 15,
                              width: 15,
                              decoration: const BoxDecoration(
                                color: BartrColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                "${usermessages.where((element) => element.sender == user.id).length}",
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: BartrColors.greyFill,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                        }
                      }
                      return const SizedBox();
                    }, error: (obj, st) {
                      return const Text("..");
                    }, loading: () {
                      return const Text("..");
                    })
                  ],
                );
              }, error: (obj, st) {
                return const Text("...");
              }, loading: () {
                return const Text("...");
              }),
          ],
        ),
      ),
    );
  }
}
