
class BidWithConversation {
  final String conversationId;
  final String currentUID;
  final String otherUID;
  BidWithConversation({
    required this.conversationId,
    required this.currentUID,
    required this.otherUID,
  });

  BidWithConversation copyWith({
    String? conversationId,
    String? currentUID,
    String? otherUID,
  }) {
    return BidWithConversation(
      conversationId: conversationId ?? this.conversationId,
      currentUID: currentUID ?? this.currentUID,
      otherUID: otherUID ?? this.otherUID,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'conversationId': conversationId,
      'currentUID': currentUID,
      'otherUID': otherUID,
    };
  }

  factory BidWithConversation.fromJson(Map<String, dynamic> map) {
    return BidWithConversation(
      conversationId: map['conversationId'] as String,
      currentUID: map['currentUID'] as String,
      otherUID: map['otherUID'] as String,
    );
  }
}
