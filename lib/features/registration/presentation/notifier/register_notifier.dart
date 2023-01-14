import 'dart:io';

import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/domain/repositories/register_repository.dart';
import 'package:bartr/domain/repositories/user_repository.dart';
import 'package:bartr/features/registration/data/repository.dart';
import 'package:bartr/features/registration/domain/dtos/register_dto.dart';
import 'package:bartr/features/registration/presentation/notifier/register_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../login/domain/models/login_model.dart';

class RegisterNotifier extends StateNotifier<RegisterState> {
  RegisterNotifier(this.registerRepository, this.userRepository)
      : super(RegisterState.initial());

  final RegisterRepository registerRepository;
  final UserRepository userRepository;
  Future<String?> register(RegisterDto data, File profilePicture) async {
    state = state.copyWith(loadState: LoadState.loading);
    try {
      final response = await registerRepository.register(data, profilePicture);
      if (response.status) {
        final user = BartrUser(
          email: data.email,
          username: data.username,
          fullName: data.fullName,
          password: data.password,
        );
        saveUserData(user);
        state = state.copyWith(
          loadState: LoadState.success,
        );
        return null;
      }
      state = state.copyWith(loadState: LoadState.error);
      return response.error;
    } catch (e) {
      state = state.copyWith(
        loadState: LoadState.error,
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }

  Future<String?> verifyEmail(VerifyEmailDto data) async {
    state = state.copyWith(loadState: LoadState.loading);
    try {
      final response = await registerRepository.verifyEmail(data);
      if (response.status) {
        state = state.copyWith(
          loadState: LoadState.success,
        );
        return null;
      }
      state = state.copyWith(loadState: LoadState.error);
      return response.error;
    } catch (e) {
      state = state.copyWith(
        loadState: LoadState.error,
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }

  void resendCode({
    required ResendCodeDto data,
  }) async {
    state = state.copyWith(resendState: LoadState.loading);
    try {
      final res = await registerRepository.resendVerificationCode(data);
      if (res.status) {
        state = state.copyWith(resendState: LoadState.success);
        return;
      }
      state = state.copyWith(resendState: LoadState.error);
    } catch (e) {
      state = state.copyWith(resendState: LoadState.error);
    }
  }

  void saveUserData(BartrUser user) {
    userRepository.setCurrentUser(user);
  }
}

final registerNotifier = StateNotifierProvider<RegisterNotifier, RegisterState>(
  (_) => RegisterNotifier(
    _.read(registerRepository),
    _.read(userRepository),
  ),
);
