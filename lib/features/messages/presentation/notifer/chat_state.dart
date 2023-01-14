import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/features/messages/domain/models/conversation_model.dart';

class ChatState {
  final LoadState messageLoadState;
  final List<Conversation> conversations;

  ChatState({
    required this.messageLoadState,
    required this.conversations,
  });

  factory ChatState.initial() {
    return ChatState(
      messageLoadState: LoadState.loading,
      conversations: [],
    );
  }

  ChatState copyWith({
    final LoadState? messageLoadState,
    final List<Conversation>? conversations,
  }) {
    return ChatState(
      messageLoadState: messageLoadState ?? this.messageLoadState,
      conversations: conversations ?? this.conversations,
    );
  }
}
