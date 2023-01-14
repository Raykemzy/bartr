import 'package:bartr/core/utils/enums.dart';

class ResentCodeState {
  final TimerState loadState;
  ResentCodeState({
    required this.loadState,
  });

  factory ResentCodeState.initial() {
    return ResentCodeState(
      loadState: TimerState.timerNotStarted,
    );
  }
  ResentCodeState copyWith({
    TimerState? loadState,
  }) {
    return ResentCodeState(
      loadState: loadState ?? this.loadState,
    );
  }
}
