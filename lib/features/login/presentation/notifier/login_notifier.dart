import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/domain/repositories/login_repository.dart';
import 'package:bartr/domain/repositories/user_repository.dart';
import 'package:bartr/features/login/data/repository.dart';
import 'package:bartr/features/login/domain/dtos/login_dto.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'login_state.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier(this.loginRepository, this.userRepository)
      : super(LoginState.initial());

  final LoginRepository loginRepository;
  final UserRepository userRepository;

  Future<String?> login(LoginDto data) async {
    state = state.copyWith(loadState: LoginLoadState.loading);
    try {
      final response = await loginRepository.login(data);
      if (response.status) {
        if (!response.data!.user.emailConfirmed!) {
          saveDetails(response.data!.user.copyWith(password: data.password),
              response.data!.token, CurrentState.onboarded);
          state = state.copyWith(loadState: LoginLoadState.unverified);
          return null;
        }

        saveDetails(response.data!.user.copyWith(password: data.password),
            response.data!.token, CurrentState.loggedIn);
        getUserProfile(
            username: response.data!.user.username!, password: data.password);
        state = state.copyWith(
          response: response.data,
          loadState: LoginLoadState.success,
        );
        return null;
      }
      state = state.copyWith(loadState: LoginLoadState.error);
      return response.error;
    } catch (e) {
      state = state.copyWith(
        loadState: LoginLoadState.error,
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }

  saveDetails(BartrUser user, String token, CurrentState currentstate) {
    userRepository.setCurrentUser(user);
    userRepository.saveCurrentState(currentstate);
    userRepository.saveToken(token);
  }

  getUserProfile({required String username, required String password}) async {
    try {
      final res = await userRepository.getUserProfile(username);
      if (res.status) {
        userRepository.setCurrentUser(res.data!.copyWith(password: password));
      }
    } catch (e) {
      state = state.copyWith(
        loadState: LoginLoadState.error,
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }
}

final loginNotifier = StateNotifierProvider<LoginNotifier, LoginState>(
  (_) => LoginNotifier(
    _.read(loginRepository),
    _.read(userRepository),
  ),
);
