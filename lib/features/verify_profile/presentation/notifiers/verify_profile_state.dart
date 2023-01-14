import 'package:bartr/core/utils/enums.dart';

class VerifyProfileState {
  final LoadState verifyProfileLoadState;
  final String succeesMessage;
  VerifyProfileState({
    required this.succeesMessage,
    required this.verifyProfileLoadState,
  });

  factory VerifyProfileState.initial() {
    return VerifyProfileState(
      verifyProfileLoadState: LoadState.idle,
      succeesMessage: '',
    );
  }

  VerifyProfileState copyWith({
    LoadState? verifyProfileLoadState,
    String? succeesMessage,
  }) {
    return VerifyProfileState(
      verifyProfileLoadState: verifyProfileLoadState ?? this.verifyProfileLoadState,
      succeesMessage: succeesMessage ?? this.succeesMessage,
    );
  }
}
