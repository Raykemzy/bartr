import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/domain/repositories/posts_repository.dart';
import 'package:bartr/features/create_post/domain/dtos/create_post_dto.dart';
import 'package:bartr/features/create_post/notifier/create_post_state.dart';
import 'package:bartr/features/home/data/post_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreatePostNotifier extends StateNotifier<CreatePostState> {
  CreatePostNotifier(this._postsRepository) : super(CreatePostState.initial());
  final PostsRepository _postsRepository;
  Future<String?> createPost(CreatePostDto data) async {
    state = state.copyWith(createPostLoadState: LoadState.loading);
    try {
      final response = await _postsRepository.createPost(data);

      if (response.status) {
        state = state.copyWith(
          createPostLoadState: LoadState.success,
          succeesMessage: response.message,
        );
        return null;
      }
      state = state.copyWith(createPostLoadState: LoadState.error);
      return response.error;
    } catch (e) {
      state = state.copyWith(createPostLoadState: LoadState.error);
      rethrow;
    }
  }
}

final createPostNotifier =
    StateNotifierProvider<CreatePostNotifier, CreatePostState>(
  (_) => CreatePostNotifier(
    _.read(postsRepository),
  ),
);
