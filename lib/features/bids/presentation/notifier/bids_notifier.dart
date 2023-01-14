import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/domain/repositories/bids_repository.dart';
import 'package:bartr/domain/repositories/conversation_repository.dart';
import 'package:bartr/domain/repositories/user_repository.dart';
import 'package:bartr/features/bids/data/bids_repository_implementation.dart';
import 'package:bartr/features/bids/presentation/notifier/bids_state.dart';
import 'package:bartr/features/messages/data/conversation_repositpry_impl.dart';
import 'package:bartr/features/messages/domain/dtos/conversation_dto.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/bid_with_conversation.dart';

class BidsNotifier extends StateNotifier<BidsState> {
  BidsNotifier(
    this.bidsRepository,
    this.userRepo,
    this.conversationRepository,
  ) : super(BidsState.initial());
  final BidsRepository bidsRepository;
  final UserRepository userRepo;
  final ConversationRepository conversationRepository;

  Future<void> fetchUserBids({bool retry = false}) async {
    if (retry) {
      state = state.copyWith(bidsLoadState: LoadState.loading);
    }
    try {
      final res = await bidsRepository.getUserBids();
      if (res.status) {
        state = state.copyWith(
          receivedBids: res.data!.receivedBids,
          sentBids: res.data!.sentBids,
          bidsLoadState: LoadState.success,
        );
      } else {
        state = state.copyWith(bidsLoadState: LoadState.error);
      }
    } catch (e) {
      state = state.copyWith(bidsLoadState: LoadState.error);
    }
  }

  void changeIndex(int newIndex) {
    state = state.copyWith(currentIndex: newIndex);
  }

  Future<String?> createConversation({
    required ConversationDto data,
    required String otherUID,
    required String currentUID,
  }) async {
    try {
      List<BidWithConversation> localconVo =
          conversationRepository.fetchBidsWithConversations();
      if (localconVo.isNotEmpty &&
          localconVo.any((element) => element.otherUID == otherUID)) {
        state = state.copyWith(conversationLoadState: LoadState.success);
        return localconVo
            .firstWhere((element) => element.otherUID == otherUID)
            .conversationId;
      }
      final res = await conversationRepository.createConversation(data);
      if (res.status) {
        conversationRepository.saveBidsConversations(
          BidWithConversation(
            otherUID: otherUID,
            currentUID: currentUID,
            conversationId: res.data!.id,
          ),
        );
        state = state.copyWith(conversationLoadState: LoadState.success);

        return res.data!.id;
      }
      state = state.copyWith(
        conversationLoadState: LoadState.error,
        conversationError: res.error,
      );
      state = state.copyWith(conversationLoadState: LoadState.idle);
      return null;
    } catch (e) {
      state = state.copyWith(
        conversationLoadState: LoadState.error,
        conversationError: e.toString(),
      );
      state = state.copyWith(conversationLoadState: LoadState.idle);
      rethrow;
    }
  }
}

final bidsNotifier = StateNotifierProvider<BidsNotifier, BidsState>(
  (ref) => BidsNotifier(
    ref.read(bidsRepository),
    ref.read(userRepository),
    ref.read(conversationRepository),
  ),
);
