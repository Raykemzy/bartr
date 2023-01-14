import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/config/exception/app_exception.dart';
import 'package:bartr/core/config/response/base_response.dart';
import 'package:bartr/core/services/network/rest_client.dart';
import 'package:bartr/domain/repositories/reset_password_repository.dart';
import 'package:bartr/features/forgot_password/domain/dtos/reset_password_dto.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResetPasswordRepoImpl implements ResetPasswordRepository {
  final RestClient _client;
  ResetPasswordRepoImpl(this._client);

  @override
  Future<BaseResponse> resetPassword(ResetPasswordDto data) async {
    try {
      return await _client.resetPassword(data);
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }
}

final resetPasswordRepo =
    Provider((ref) => ResetPasswordRepoImpl(ref.read(restClient)));
