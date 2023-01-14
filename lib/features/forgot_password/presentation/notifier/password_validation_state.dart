import 'package:bartr/core/utils/enums.dart';

class PasswordValidationState {
  final ValidationState loadState;
  PasswordValidationState({
    required this.loadState,
  });

  factory PasswordValidationState.initial() {
    return PasswordValidationState(
      loadState: ValidationState.idle,
    );
  }
  PasswordValidationState copyWith({
    ValidationState? loadState,
  }) {
    return PasswordValidationState(
      loadState: loadState ?? this.loadState,
    );
  }
}
