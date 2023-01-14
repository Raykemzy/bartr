// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class UserMessage {
  final String text;
  final String sender;
  final Timestamp? createdAt;
  UserMessage({
    required this.text,
    required this.sender,
    required this.createdAt,
  });

  static Map<String, dynamic> toFireStore(
      {required String text,
      required String sender,
      required DateTime createdAt}) {
    return <String, dynamic>{
      'text': text,
      'sender': sender,
      'createdAt': createdAt,
    };
  }

  factory UserMessage.fromMap(Map<String, dynamic> map) {
    return UserMessage(
      text: map['text'] ?? "",
      sender: map['sender'] ?? "",
      createdAt: map['createdAt'],
    );
  }

  @override
  String toString() =>
      'UserMessage(text: $text, sender: $sender, createdAt: $createdAt)';
}
