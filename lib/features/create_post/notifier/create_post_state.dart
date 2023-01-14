import 'package:bartr/core/utils/enums.dart';

class CreatePostState {
  final LoadState createPostLoadState;
  final String succeesMessage;
  CreatePostState({
    required this.succeesMessage,
    required this.createPostLoadState,
  });

  factory CreatePostState.initial() {
    return CreatePostState(
      createPostLoadState: LoadState.idle,
      succeesMessage: '',
    );
  }

  CreatePostState copyWith({
    LoadState? createPostLoadState,
    String? succeesMessage,
  }) {
    return CreatePostState(
      createPostLoadState: createPostLoadState ?? this.createPostLoadState,
      succeesMessage: succeesMessage ?? this.succeesMessage,
    );
  }
}
