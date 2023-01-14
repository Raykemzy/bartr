import 'package:bartr/core/utils/enums.dart';

class EditPostState {
  final LoadState editPostLoadState;
  final String succeesMessage;
  EditPostState({
    required this.succeesMessage,
    required this.editPostLoadState,
  });

  factory EditPostState.initial() {
    return EditPostState(
      editPostLoadState: LoadState.idle,
      succeesMessage: '',
    );
  }

  EditPostState copyWith({
    LoadState? editPostLoadState,
    String? succeesMessage,
  }) {
    return EditPostState(
      editPostLoadState: editPostLoadState ?? this.editPostLoadState,
      succeesMessage: succeesMessage ?? this.succeesMessage,
    );
  }
}
