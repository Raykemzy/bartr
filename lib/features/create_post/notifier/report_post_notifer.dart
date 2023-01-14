import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/domain/repositories/posts_repository.dart';
import 'package:bartr/domain/repositories/user_repository.dart';
import 'package:bartr/features/create_post/domain/dtos/report_post_dto.dart';
import 'package:bartr/features/create_post/notifier/report_post_state.dart';
import 'package:bartr/features/home/data/post_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/config/configure_dependencies.dart';

class ReportPostNotifier extends StateNotifier<ReportPostState> {
  ReportPostNotifier(
    this._postsRepository,
    this._userRepository,
  ) : super(ReportPostState.initial());
  final PostsRepository _postsRepository;
  final UserRepository _userRepository;
  Future<String?> reportPost(ReportPostDto data) async {
    state = state.copyWith(reportPostLoadState: LoadState.loading);
    try {
      final response = await _postsRepository.reportPost(data: data);

      if (response.status) {
        state = state.copyWith(
          reportPostLoadState: LoadState.success,
          succeesMessage: response.message,
        );
        return null;
      }
      state = state.copyWith(reportPostLoadState: LoadState.error);
      return response.error;
    } catch (e) {
      state = state.copyWith(reportPostLoadState: LoadState.error);
      rethrow;
    }
  }

  Future<String?> reportUser(ReportPostDto data) async {
    state = state.copyWith(reportPostLoadState: LoadState.loading);
    try {
      final response = await _userRepository.reportUser(data: data);

      if (response.status) {
        state = state.copyWith(
          reportPostLoadState: LoadState.success,
          succeesMessage: response.message,
        );
        return null;
      }
      state = state.copyWith(reportPostLoadState: LoadState.error);
      return response.error;
    } catch (e) {
      state = state.copyWith(reportPostLoadState: LoadState.error);
      rethrow;
    }
  }
}

final reportPostNotifier =
    StateNotifierProvider.autoDispose<ReportPostNotifier, ReportPostState>(
  (_) => ReportPostNotifier(
    _.read(postsRepository),
     _.read(userRepository),
  ),
);
