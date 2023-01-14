import 'package:bartr/core/router/routes.dart';
import 'package:bartr/core/utils/enums.dart';

class MakeAbidState {
  final LoadState makeAbidLoadState;
  final String successMessage;
    final String errorMessage;

  MakeAbidState({
    required this.makeAbidLoadState,
    required this.successMessage,
    required this.errorMessage,
  });

  factory MakeAbidState.initial() {
    return MakeAbidState(
      makeAbidLoadState: LoadState.idle,
      successMessage: '',
      errorMessage: '',
    );
  }

  MakeAbidState copyWith({
    LoadState? makeAbidLoadState,
    String? successMessage,
    String? errorMessage,
  }) {
    return MakeAbidState(
      makeAbidLoadState: makeAbidLoadState ?? this.makeAbidLoadState,
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
