import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/domain/repositories/bids_repository.dart';
import 'package:bartr/domain/repositories/user_repository.dart';
import 'package:bartr/features/bids/data/bids_repository_implementation.dart';
import 'package:bartr/features/bids/presentation/notifier/bids_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostBidsNotifier extends StateNotifier<BidsState> {
  PostBidsNotifier(
    this.bidsRepository,
    this.userRepo,
  ) : super(BidsState.initial());
  final BidsRepository bidsRepository;
  final UserRepository userRepo;

  Future<void> fetchPostBids({
    required String postId,
    bool retry = false,
  }) async {
    if (retry) {
      state = state.copyWith(bidsLoadState: LoadState.loading);
    }
    try {
      final res = await bidsRepository.getPostBids(postId);
      if (res.status) {
        state = state.copyWith(
          postBids: res.data!.posts,
          postBidsLoadState: LoadState.success,
        );
      } else {
        state = state.copyWith(postBidsLoadState: LoadState.error);
      }
    } catch (e) {
      state = state.copyWith(postBidsLoadState: LoadState.error);
    }
  }
}

final postbidsNotifier =
    StateNotifierProvider.autoDispose<PostBidsNotifier, BidsState>(
  (ref) => PostBidsNotifier(
    ref.read(bidsRepository),
    ref.read(userRepository),
  ),
);
