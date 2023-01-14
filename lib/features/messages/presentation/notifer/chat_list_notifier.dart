import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/config/exception/logger.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/domain/repositories/conversation_repository.dart';
import 'package:bartr/features/messages/data/conversation_repositpry_impl.dart';
import 'package:bartr/features/messages/domain/dtos/notification_dto.dart';
import 'package:bartr/features/messages/presentation/notifer/chat_state.dart';
import 'package:bartr/features/messages/presentation/notifer/user_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/services/firebase/firestor_service.dart';

final messageProvider =
    StreamProvider.family<QuerySnapshot<Map<String, dynamic>>, String>(
        (ref, chatRoomId) {
  final fireStore = ref.read(fireStoreServiceProvider);
  return fireStore.fetchMessages(
    docPath: chatRoomId,
    collection1: 'messages',
    collection2: 'usersMessages',
  )!;
});

final unreadMessageProvider =
    StreamProvider<QuerySnapshot<Map<String, dynamic>>>(
  (ref) {
    final fireStore = ref.read(fireStoreServiceProvider);
    final currentuser = ref.watch(currentUserProvider);
    return fireStore.fetchMessages(
      docPath: currentuser.id!,
      collection1: 'unreadmessages',
      collection2: 'unread${currentuser.id}',
    )!;
  },
);

final lastMessageProvider =
    StreamProvider.family<DocumentSnapshot<Map<String, dynamic>>, String>(
        (ref, chatRoomId) {
  final fireStore = ref.read(fireStoreServiceProvider);
  return fireStore.fetchLastMessages(docPath: chatRoomId)!;
});

final lastSeenProvider =
    StreamProvider.family<DocumentSnapshot<Map<String, dynamic>>, String>(
        (ref, userID) {
  final fireStore = ref.read(fireStoreServiceProvider);
  return fireStore.fetchStatus(userID: userID)!;
});

class ChatListNotifier extends StateNotifier<ChatState> {
  final FirestoreService firestoreService;
  final ConversationRepository conversationRepository;
  ChatListNotifier(
    this.conversationRepository,
    this.firestoreService,
  ) : super(ChatState.initial());

  Future<void> fetchConversations() async {
    try {
      final res = await conversationRepository.fectchConversations();
      if (res.status) {
        conversationRepository.saveConversations(res.data ?? []);
        state = state.copyWith(
          messageLoadState: LoadState.success,
          conversations: res.data,
        );
      } else {
        state = state.copyWith(messageLoadState: LoadState.error);
      }
    } catch (e) {
      state = state.copyWith(messageLoadState: LoadState.error);
    }
  }

//Method that handles sending messages to the database
  Future<void> sendMessage({
    required String otherUserId,
    required String currentUserId,
    required String messageText,
    required String chatRoomId,
  }) async {
    await firestoreService.sendMessages(
      collection2: 'usersMessages',
      collPath: 'messages',
      docPath: chatRoomId,
      data: UserMessage.toFireStore(
        createdAt: DateTime.now(),
        sender: currentUserId,
        text: messageText,
      ),
    );
  }

  Future<void> sendUnreadMessages({
    required String otherUserId,
    required String currentUserId,
    required String messageText,
    required String chatRoomId,
  }) async {
    await firestoreService.sendMessages(
      collection2: 'unread$otherUserId',
      collPath: 'unreadmessages',
      docPath: otherUserId,
      data: UserMessage.toFireStore(
        createdAt: DateTime.now(),
        sender: currentUserId,
        text: messageText,
      ),
    );
  }

  Future<void> deleteMessage({
    required String senderid,
    required String currentUserId,
  }) async {
    try {
      firestoreService.deleteChatUnreadMessages(
        userid: currentUserId,
        senderid: senderid,
      );
    } catch (e) {
      debugLog(e);
    }
  }

  Future<void> sendLastMessage({
    required String otherUserId,
    required String currentUserId,
    required String messageText,
    required String chatRoomId,
  }) async {
    await firestoreService.sendLastMessage(
      collection2: 'last_message',
      collPath: 'messages',
      docPath: chatRoomId,
      data: UserMessage.toFireStore(
        createdAt: DateTime.now(),
        sender: currentUserId,
        text: messageText,
      ),
    );
  }

  Future<void> sendPushNotification(NotficationDto data) async {
    try {
      await conversationRepository.sendNotification(data);
    } catch (e) {
      rethrow;
    }
  }
}

final chatListProvider =
    StateNotifierProvider.autoDispose<ChatListNotifier, ChatState>(
  (ref) => ChatListNotifier(
    ref.read(conversationRepository),
    ref.read(fireStoreServiceProvider),
  ),
);
