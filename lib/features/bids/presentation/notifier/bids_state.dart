import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/features/bids/domain/user_bids_model.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';

class BidsState {
  final LoadState bidsLoadState;
  final LoadState? postBidsLoadState;
  final LoadState? conversationLoadState;

  final List<UserBid> bids;
  final List<PostBid> postBids;
  final List<ReceivedBid> receivedBids;
  final List<SentBid> sentBids;
  final BartrUser? bartrUser;
  final int currentIndex;
  final String conversationError;

  BidsState({
    required this.bidsLoadState,
    required this.postBidsLoadState,
    required this.bids,
    required this.postBids,
    required this.receivedBids,
    required this.sentBids,
    required this.bartrUser,
    required this.currentIndex,
    required this.conversationLoadState,
    required this.conversationError,
  });

  factory BidsState.initial() {
    return BidsState(
      bidsLoadState: LoadState.loading,
      postBidsLoadState: LoadState.loading,
      bids: [],
      postBids: [],
      receivedBids: [],
      sentBids: [],
      bartrUser: null,
      currentIndex: 0,
      conversationLoadState: LoadState.idle,
      conversationError: '',
    );
  }

  BidsState copyWith({
    LoadState? bidsLoadState,
    LoadState? postBidsLoadState,
    LoadState? conversationLoadState,
    List<UserBid>? bids,
    List<PostBid>? postBids,
    List<ReceivedBid>? receivedBids,
    List<SentBid>? sentBids,
    BartrUser? bartrUser,
    int? currentIndex,
    String? conversationError,
  }) {
    return BidsState(
      bidsLoadState: bidsLoadState ?? this.bidsLoadState,
      postBidsLoadState: postBidsLoadState ?? this.postBidsLoadState,
      bids: bids ?? this.bids,
      postBids: postBids ?? this.postBids,
      receivedBids: receivedBids ?? this.receivedBids,
      sentBids: sentBids ?? this.sentBids,
      bartrUser: bartrUser ?? this.bartrUser,
      currentIndex: currentIndex ?? this.currentIndex,
      conversationLoadState:
          conversationLoadState ?? this.conversationLoadState,
      conversationError: conversationError ?? this.conversationError,
    );
  }
}
