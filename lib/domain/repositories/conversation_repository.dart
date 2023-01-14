import 'package:bartr/core/config/response/base_response.dart';
import 'package:bartr/features/bids/domain/bid_with_conversation.dart';
import 'package:bartr/features/messages/domain/dtos/conversation_dto.dart';
import 'package:bartr/features/messages/domain/dtos/notification_dto.dart';
import 'package:bartr/features/messages/domain/models/conversation_model.dart';

abstract class ConversationRepository {
  Future<BaseResponse<MessageConversation>> createConversation(
      ConversationDto data);
  Future<BaseResponse<List<Conversation>>> fectchConversations();
  void saveConversations(List<Conversation> data);
  List<Conversation> fetchLocalConversations();
  List<BidWithConversation> fetchBidsWithConversations();
  void saveBidsConversations(BidWithConversation data);
  Future sendNotification(NotficationDto data);
}
