class ChatMessage {
  final String chatMessage;
  final DateTime timeSent;
  final String messageType;
  final String readStatus;

  ChatMessage({
    required this.chatMessage,
    required this.timeSent,
    required this.messageType,
    required this.readStatus,
  });
}
