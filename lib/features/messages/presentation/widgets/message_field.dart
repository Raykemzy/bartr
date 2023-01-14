import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:bartr/features/messages/domain/dtos/notification_dto.dart';
import 'package:bartr/features/messages/domain/models/conversation_model.dart';
import 'package:bartr/features/messages/presentation/notifer/chat_list_notifier.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MessageField extends StatefulWidget {
  final String otherUserId;
  final String chatRoomId;
  final String senderImageUrl;
  final DateTime timeSent;
  final Member otherUser;
  const MessageField({
    Key? key,
    required this.chatRoomId,
    required this.otherUserId,
    required this.senderImageUrl,
    required this.timeSent,
    required this.otherUser,
  }) : super(key: key);

  @override
  State<MessageField> createState() => _MessageFieldState();
}

class _MessageFieldState extends State<MessageField> {
  late TextEditingController chatController;
  bool isEmpty = true;
  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    chatController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        border: Border(
          top: BorderSide(
            color: BartrColors.lightGrey,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        // height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: BartrColors.lightGrey,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: Strings.typeSom,
                  hintStyle: Styles.w400(color: BartrColors.grey, size: 14),
                ),
                controller: chatController,
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                final currentuser = ref.watch(currentUserProvider);
                final msg = ref.read(chatListProvider.notifier);
                return InkWell(
                  onTap: chatController.text.isEmpty
                      ? null
                      : () => _sendMessage(msg, currentuser),
                  child: Image.asset(
                    "assets/images/sendbutton.png",
                    width: 20,
                    color:
                        chatController.text.isEmpty ? BartrColors.grey : null,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage(ChatListNotifier msg, BartrUser currentuser) {
    msg.sendMessage(
      otherUserId: widget.otherUserId,
      currentUserId: currentuser.id!,
      messageText: chatController.text,
      chatRoomId: widget.chatRoomId,
    );
    msg.sendUnreadMessages(
      otherUserId: widget.otherUserId,
      currentUserId: currentuser.id!,
      messageText: chatController.text,
      chatRoomId: widget.otherUserId,
    );
    msg
        .sendLastMessage(
      otherUserId: widget.otherUserId,
      currentUserId: currentuser.id!,
      messageText: chatController.text,
      chatRoomId: widget.chatRoomId,
    )
        .then((value) {
      chatController.clear();
    });
    if (widget.otherUser.fcmPushToken != null) {
      final NotficationDto dto = NotficationDto(
        to: widget.otherUser.fcmPushToken!,
        notification: Notification(
          body: "@${currentuser.username} sent you a message",
          title: "New message",
        ),
        data: Data(
          receiverId: widget.otherUser.id,
          type: NotificationType.message,
          conversationId: widget.chatRoomId,
          fcmPushToken: currentuser.fcmPushToken!,
          fullName: currentuser.fullName!,
          id: currentuser.id!,
          profilePicture: currentuser.profilePicture!,
          username: currentuser.username!,
        ),
      );

      msg.sendPushNotification(dto);
    }
  }
}
