import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/features/messages/presentation/notifer/user_message.dart';
import 'package:bartr/features/messages/presentation/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'message_date_bubble.dart';

class GroupedMessages extends ConsumerWidget {
  const GroupedMessages({
    Key? key,
    required this.messages,
    required this.header,
  }) : super(key: key);
  final String header;
  final List<UserMessage> messages;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentuser = ref.watch(currentUserProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: MessageDateBubble(
            header: header,
          ),
        ),
        ListView.builder(
          reverse: true,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(5),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            UserMessage message = messages[index];
            bool isMe = currentuser.id == message.sender;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Align(
                alignment: isMe ? Alignment.topRight : Alignment.topLeft,
                child: MessageBubble(
                  message: message.text,
                  isMe: isMe,
                  timeSent: message.createdAt!,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
