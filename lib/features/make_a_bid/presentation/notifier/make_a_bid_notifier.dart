import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/domain/repositories/posts_repository.dart';
import 'package:bartr/features/home/data/post_repository_impl.dart';
import 'package:bartr/features/make_a_bid/domain/dtos/make_a_bid_dto.dart';
import 'package:bartr/features/make_a_bid/presentation/notifier/make_a_bid_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MakeAbidNotifier extends StateNotifier<MakeAbidState> {
  MakeAbidNotifier(this._postsRepository) : super(MakeAbidState.initial());
  final PostsRepository _postsRepository;
  Future<void> makeAbid({
    required MakeAbidDto data,
  }) async {
    state = state.copyWith(makeAbidLoadState: LoadState.loading);
    try {
      final response = await _postsRepository.makeAbid(
        data: data,
      );
      if (response.status) {
        state = state.copyWith(
          makeAbidLoadState: LoadState.success,
          successMessage: response.message,
        );
        state = state.copyWith(makeAbidLoadState: LoadState.idle);
        return;
      }
      state = state.copyWith(
          makeAbidLoadState: LoadState.error, errorMessage: response.error);
      state = state.copyWith(makeAbidLoadState: LoadState.idle);
    } catch (e) {
      state = state.copyWith(makeAbidLoadState: LoadState.error);
      rethrow;
    }
  }
}

final makeAbidNotifier = StateNotifierProvider<MakeAbidNotifier, MakeAbidState>(
  (_) => MakeAbidNotifier(
    _.read(postsRepository),
  ),
);
