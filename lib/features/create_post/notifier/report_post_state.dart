import 'package:bartr/core/utils/enums.dart';

class ReportPostState {
  final LoadState reportPostLoadState;
  final String succeesMessage;
  ReportPostState({
    required this.succeesMessage,
    required this.reportPostLoadState,
  });

  factory ReportPostState.initial() {
    return ReportPostState(
      reportPostLoadState: LoadState.idle,
      succeesMessage: '',
    );
  }

  ReportPostState copyWith({
    LoadState? reportPostLoadState,
    String? succeesMessage,
  }) {
    return ReportPostState(
      reportPostLoadState: reportPostLoadState ?? this.reportPostLoadState,
      succeesMessage: succeesMessage ?? this.succeesMessage,
    );
  }
}
