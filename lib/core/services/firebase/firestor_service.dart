// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bartr/features/messages/presentation/notifer/user_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:bartr/core/config/exception/logger.dart';

class FirestoreService {
  final FirebaseFirestore fireStore;
  FirestoreService({
    required this.fireStore,
  });


  Stream<QuerySnapshot<Map<String, dynamic>>>? fetchMessages({
    required String docPath,
    required String collection1,
    required String collection2,
  }) {
    try {
      final snapshots = fireStore
          .collection(collection1)
          .doc(docPath)
          .collection(collection2)
          .orderBy(
            'createdAt',
          )
          .snapshots();
      return snapshots;
    } catch (e) {
      debugLog(e.toString());
      return null;
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>>? fetchLastMessages({
    required String docPath,
  }) {
    try {
      final snapshots = fireStore
          .collection('messages')
          .doc(docPath)
          .collection('last_message')
          .doc("last")
          .snapshots();
      return snapshots;
    } catch (e) {
      debugLog(e.toString());
      return null;
    }
  }

  Future<void> createChatRoom({
    required String collPath,
    required String docPath,
    required Map<String, dynamic> data,
  }) {
    return fireStore.collection(collPath).doc(docPath).set(data);
  }

  Future<void> sendMessages({
    required String collPath,
    required String collection2,
    required String docPath,
    required Map<String, dynamic> data,
  }) {
    return fireStore
        .collection(collPath)
        .doc(docPath)
        .collection(collection2)
        .add(data);
  }

  Future<void> sendLastMessage({
    required String collPath,
    required String collection2,
    required String docPath,
    required Map<String, dynamic> data,
  }) {
    return fireStore
        .collection(collPath)
        .doc(docPath)
        .collection(collection2)
        .doc("last")
        .set(data);
  }

  Future<void> deleteMessage({
    required String unreadCollection,
    required String userid,
  }) async {
    try {
      final batch = fireStore.batch();
      final collection = fireStore
          .collection('unreadmessages')
          .doc(userid)
          .collection(unreadCollection);
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } catch (e) {
      debugLog(e);
    }
  }

  Future<void> deleteChatUnreadMessages({
    required String userid,
    required String senderid,
  }) async {
    try {
      final batch = fireStore.batch();
      final collection = fireStore
          .collection('unreadmessages')
          .doc(userid)
          .collection('unread$userid');
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        var message = UserMessage.fromMap(doc.data());
        if (message.sender == senderid) {
          batch.delete(doc.reference);
        }
      }
      await batch.commit();
    } catch (e) {
      debugLog(e);
    }
  }

  Future<void> updateActiveStatus({
    required String userID,
    required Map<String, dynamic> data,
  }) {
    return fireStore.collection("user_presence").doc(userID).set(data);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>>? fetchStatus({
    required String userID,
  }) {
    try {
      final snapshots =
          fireStore.collection("user_presence").doc(userID).snapshots();
      return snapshots;
    } catch (e) {
      debugLog(e.toString());
      return null;
    }
  }
}

final fireStoreServiceProvider =
    Provider((ref) => FirestoreService(fireStore: FirebaseFirestore.instance));

class Failure {
  final String message;
  Failure({
    required this.message,
  });
}
