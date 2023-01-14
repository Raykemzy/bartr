

import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';

class LoginState {
  final LoginLoadState loadState;
  final UserResponse? response;
  final String errorMessage;
  LoginState({
    required this.loadState,
    this.response,
    this.errorMessage = '',
  });

  factory LoginState.initial() {
    return LoginState(
      loadState: LoginLoadState.idle,
      response: null,
    );
  }
  LoginState copyWith({
    LoginLoadState? loadState,
    UserResponse? response,
    String? errorMessage,
  }) {
    return LoginState(
      loadState: loadState ?? this.loadState,
      response: response ?? this.response,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
