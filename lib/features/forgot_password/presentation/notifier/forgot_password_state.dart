import 'package:bartr/core/utils/enums.dart';

class ForgotPasswordState {
  final LoadState loadState;
  final String errorMessage;
  ForgotPasswordState({
    required this.loadState,
    this.errorMessage = '',
  });

  factory ForgotPasswordState.initial() {
    return ForgotPasswordState(
      loadState: LoadState.idle,
    );
  }
  ForgotPasswordState copyWith({
    LoadState? loadState,
    String? errorMessage,
  }) {
    return ForgotPasswordState(
        loadState: loadState ?? this.loadState,
        errorMessage: errorMessage ?? this.errorMessage,);
  }
}
