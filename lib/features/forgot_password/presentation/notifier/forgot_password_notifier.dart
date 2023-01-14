import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/domain/repositories/forgot_password_repository.dart';
import 'package:bartr/features/forgot_password/data/forgot_password_repository_impl.dart';
import 'package:bartr/features/forgot_password/domain/dtos/forgot_password_dto.dart';
import 'package:bartr/features/forgot_password/presentation/notifier/forgot_password_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ForgotPasswordNotifier extends StateNotifier<ForgotPasswordState> {
  ForgotPasswordNotifier(this.forgotPassRepo)
      : super(ForgotPasswordState.initial());

  final ForgotPasswordRepository forgotPassRepo;

  Future forgotPass(ForgotPasswordDto data) async {
    state = state.copyWith(loadState: LoadState.loading);
    try {
      final response = await forgotPassRepo.forgotPassword(data);
      if (response.status) {
        state = state.copyWith(loadState: LoadState.success);
        return null;
      }
      state = state.copyWith(loadState: LoadState.error);
      return response.error;
    } catch (e) {
      state = state.copyWith(
          loadState: LoadState.error, errorMessage: e.toString(),);
      rethrow;
    }
  }
}

final forgotPassNotifier =
    StateNotifierProvider<ForgotPasswordNotifier, ForgotPasswordState>(
  (_) => ForgotPasswordNotifier(
    _.read(forgotPassRepo),
  ),
);
