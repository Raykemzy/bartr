import 'dart:async';

import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/features/forgot_password/presentation/notifier/resent_code_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TimerNotifier extends StateNotifier<String> {
  TimerNotifier() : super('');

  String countDown(String text) => text;
}

int timerCountdown(int duration) {
  Timer.periodic(
    Duration(seconds: duration),
    (timer) {
      duration--;
      if (duration == 0) {
        timer.cancel();
      }
    },
  );
  return duration;
}

class CountDownNotifier extends StateNotifier<ResentCodeState> {
  CountDownNotifier() : super(ResentCodeState.initial());

  codeResent(WidgetRef ref, int duration) {
    state = state.copyWith(loadState: TimerState.timerStarted);
    timerCountdown(duration);
    state = state.copyWith(loadState: TimerState.timerEnded);
  }
}

final timerProvider =
    StateNotifierProvider<TimerNotifier, String>((ref) => TimerNotifier());

final countDownProvider =
    StateNotifierProvider<CountDownNotifier, ResentCodeState>(
        (ref) => CountDownNotifier(),);
