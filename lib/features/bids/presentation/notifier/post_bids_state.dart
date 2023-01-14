import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/features/bids/domain/user_bids_model.dart';

class PostBidsState {
  final LoadState? postBidsLoadState;
  final List<PostBid> postBids;
  final List<ReceivedBid> receivedBids;
  final List<SentBid> sentBids;

  PostBidsState({
    required this.postBidsLoadState,
    required this.postBids,
    required this.receivedBids,
    required this.sentBids,
  });

  factory PostBidsState.initial() {
    return PostBidsState(
      postBidsLoadState: LoadState.loading,
      postBids: [],
      receivedBids: [],
      sentBids: [],
    );
  }

  PostBidsState copyWith({
    LoadState? postBidsLoadState,
    List<PostBid>? postBids,
    List<ReceivedBid>? receivedBids,
    List<SentBid>? sentBids,
  }) {
    return PostBidsState(
      postBidsLoadState: postBidsLoadState ?? this.postBidsLoadState,
      postBids: postBids ?? this.postBids,
      receivedBids: receivedBids ?? this.receivedBids,
      sentBids: sentBids ?? this.sentBids,
    );
  }
}
