import 'dart:convert';

import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/config/exception/app_exception.dart';
import 'package:bartr/core/services/local_database/abstract_class_hivestorage.dart';
import 'package:bartr/core/services/local_database/hive_keys.dart';
import 'package:bartr/core/services/network/rest_client.dart';
import 'package:bartr/features/messages/domain/dtos/conversation_dto.dart';

import 'package:bartr/core/config/response/base_response.dart';
import 'package:bartr/features/messages/domain/dtos/notification_dto.dart';
import 'package:bartr/features/messages/domain/models/conversation_model.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/services/network/firebase_client.dart';
import '../../../domain/repositories/conversation_repository.dart';
import '../../bids/domain/bid_with_conversation.dart';

class ConversationRepositoryImpl implements ConversationRepository {
  final RestClient _client;
  final AbstractHive storage;
  final FirebaseClient fclient;

  ConversationRepositoryImpl(
    this._client,
    this.storage,
    this.fclient,
  );
  @override
  Future<BaseResponse<MessageConversation>> createConversation(
      ConversationDto data) async {
    try {
      return await _client.createConversation(data);
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  Future<BaseResponse<List<Conversation>>> fectchConversations() async {
    try {
      return await _client.fetchConversations();
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  List<Conversation> fetchLocalConversations() {
    var data = storage.get(HiveKeys.conversations) ?? [];
    List newdata = json.decode(data);
    var posts =
        List<Conversation>.from(newdata.map((e) => Conversation.fromJson(e)))
            .toList();
    return posts;
  }

  @override
  void saveConversations(List<Conversation> data) async {
    await storage.put(HiveKeys.conversations, json.encode(data));
  }

  @override
  List<BidWithConversation> fetchBidsWithConversations() {
    var data = storage.get(HiveKeys.bidsWithConvo) ?? '[]';
    List newdata = json.decode(data);
    var posts = List<BidWithConversation>.from(
        newdata.map((e) => BidWithConversation.fromJson(e))).toList();
    return posts;
  }

  @override
  void saveBidsConversations(BidWithConversation data) async {
    List<BidWithConversation> bidsWithConvo = fetchBidsWithConversations();
    if (bidsWithConvo.contains(data)) {
      return;
    }
    bidsWithConvo.add(data);
    await storage.put(HiveKeys.bidsWithConvo, json.encode(bidsWithConvo));
  }

  @override
  Future sendNotification(NotficationDto data) async {
    try {
      return await fclient.sendNotification(notificationDto: data);
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }
}

final conversationRepository = Provider<ConversationRepository>(
  (ref) => ConversationRepositoryImpl(
    ref.read(restClient),
    ref.read(localDb),
    ref.read(firebaseClient),
  ),
);
