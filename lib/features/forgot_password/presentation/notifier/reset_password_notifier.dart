import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/domain/repositories/reset_password_repository.dart';
import 'package:bartr/features/forgot_password/data/reset_password_repo_implentation.dart';
import 'package:bartr/features/forgot_password/domain/dtos/reset_password_dto.dart';
import 'package:bartr/features/forgot_password/domain/model/forgot_password_response.dart';
import 'package:bartr/features/forgot_password/presentation/notifier/reset_password_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResetPasswordNotifier extends StateNotifier<ResetPasswordState> {
  ResetPasswordNotifier(this.resetPasswordRepo)
      : super(ResetPasswordState.initial());
  final ResetPasswordRepository resetPasswordRepo;

  Future<ForgotPasswordResponse> resetPass(ResetPasswordDto data) async {
    state = state.copyWith(loadState: LoadState.loading);
    try {
      final response = await resetPasswordRepo.resetPassword(data);
      if (response.status) {
        state = state.copyWith(loadState: LoadState.success);
        return ForgotPasswordResponse(
          message: response.message,
        );
      }
      state = state.copyWith(loadState: LoadState.error);
      return ForgotPasswordResponse(
          message: response.error,
        );
    } catch (e) {
      state = state.copyWith(
          loadState: LoadState.error, errorMessage: e.toString(),);
      rethrow;
    }
  }
}

final resetPasswordProvider =
    StateNotifierProvider<ResetPasswordNotifier, ResetPasswordState>(
  (ref) => ResetPasswordNotifier(
    ref.read(resetPasswordRepo),
  ),
);
