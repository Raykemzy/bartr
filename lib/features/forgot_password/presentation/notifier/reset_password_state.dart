import 'package:bartr/core/utils/enums.dart';

class ResetPasswordState {
  final LoadState loadState;
  final String errorMessage;
  ResetPasswordState({
    required this.loadState,
    this.errorMessage = '',
  });

  factory ResetPasswordState.initial() {
    return ResetPasswordState(
      loadState: LoadState.idle,
    );
  }
  ResetPasswordState copyWith({
    LoadState? loadState,
    String? errorMessage,
  }) {
    return ResetPasswordState(
        loadState: loadState ?? this.loadState,
        errorMessage: errorMessage ?? this.errorMessage,);
  }
}
