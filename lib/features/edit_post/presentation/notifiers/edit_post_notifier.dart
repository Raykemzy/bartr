import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/domain/repositories/posts_repository.dart';
import 'package:bartr/features/edit_post/domain/edit_post_dto.dart';
import 'package:bartr/features/edit_post/presentation/notifiers/edit_post_state.dart';
import 'package:bartr/features/home/data/post_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditPostNotifier extends StateNotifier<EditPostState> {
  EditPostNotifier(this._postsRepository) : super(EditPostState.initial());
  final PostsRepository _postsRepository;
  Future<String?> editPost(EditPostDto data, String postId) async {
    state = state.copyWith(editPostLoadState: LoadState.loading);
    try {
      final response = await _postsRepository.editPost(data, postId);

      if (response.status) {
        state = state.copyWith(
          editPostLoadState: LoadState.success,
          succeesMessage: response.message,
        );
        return null;
      }
      state = state.copyWith(editPostLoadState: LoadState.error);
      return response.error;
    } catch (e) {
      state = state.copyWith(editPostLoadState: LoadState.error);
      rethrow;
    }
  }
}

final editPostNotifier =
    StateNotifierProvider<EditPostNotifier, EditPostState>(
  (_) => EditPostNotifier(
    _.read(postsRepository),
  ),
);