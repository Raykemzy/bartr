import 'package:bartr/core/utils/enums.dart';

class RegisterState {
  final LoadState loadState;
  final LoadState resendState;
  final String errorMessage;
  RegisterState({
    required this.loadState,
    required this.resendState,
    this.errorMessage = '',
  });

  factory RegisterState.initial() {
    return RegisterState(
      loadState: LoadState.idle,
      resendState: LoadState.idle,
    );
  }
  RegisterState copyWith({
    LoadState? loadState,
    LoadState? resendState,
    String? errorMessage,
  }) {
    return RegisterState(
      loadState: loadState ?? this.loadState,
      errorMessage: errorMessage ?? this.errorMessage,
      resendState: resendState ?? this.resendState,
    );
  }
}
