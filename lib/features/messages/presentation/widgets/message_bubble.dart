import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final Timestamp timeSent;
  const MessageBubble({
    Key? key,
    required this.message,
    required this.isMe,
    required this.timeSent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: (isMe) ? BartrColors.senderBubble : BartrColors.receiverBubble,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            (isMe) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              message,
              style: Styles.w400(
                size: 14,
                color: (isMe) ? BartrColors.primary : BartrColors.black,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                formatDateTime(timeSent),
                style: Styles.w400(
                  size: 10,
                  color: BartrColors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String formatDateTime(Timestamp dateTime) {
  var time = DateFormat.jm().format(dateTime.toDate());
  return '$time ';
}
