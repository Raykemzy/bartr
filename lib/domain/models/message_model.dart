// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:bartr/domain/models/chat_message_model.dart';

class Message extends Equatable {
  final String senderName;
  final List<ChatMessage> chats;
  final String senderImageUrl;
  final DateTime timeSent;

  const Message({
    required this.senderName,
    required this.chats,
    required this.senderImageUrl,
    required this.timeSent,
  });


  @override
  List<Object> get props => [senderName, chats, senderImageUrl, timeSent];
}
