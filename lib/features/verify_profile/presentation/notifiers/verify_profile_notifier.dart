import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/domain/repositories/user_repository.dart';
import 'package:bartr/features/verify_profile/presentation/domain/verify_profile_dto.dart';
import 'package:bartr/features/verify_profile/presentation/notifiers/verify_profile_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VerifyProfileNotifier extends StateNotifier<VerifyProfileState> {
  VerifyProfileNotifier(this._userRepository) : super(VerifyProfileState.initial());
  final UserRepository _userRepository;
  Future<String?> verifyProfile(VerifyProfileDto data) async {
    state = state.copyWith(verifyProfileLoadState: LoadState.loading);
    try {
      final response = await _userRepository.verifyProfile(data);

      if (response.status) {
        state = state.copyWith(
          verifyProfileLoadState: LoadState.success,
          succeesMessage: response.message,
        );
        return null;
      }
      state = state.copyWith(verifyProfileLoadState: LoadState.error);
      return response.error;
    } catch (e) {
      state = state.copyWith(verifyProfileLoadState: LoadState.error);
      rethrow;
    }
  }
}

final verifyProfileNotifier =
    StateNotifierProvider<VerifyProfileNotifier, VerifyProfileState>(
  (_) => VerifyProfileNotifier(
    _.read(userRepository),
  ),
);
