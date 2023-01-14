import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/config/exception/app_exception.dart';
import 'package:bartr/core/config/response/base_response.dart';
import 'package:bartr/core/services/network/rest_client.dart';
import 'package:bartr/domain/repositories/forgot_password_repository.dart';
import 'package:bartr/features/forgot_password/domain/dtos/forgot_password_dto.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ForgotPasswordRepoImpl implements ForgotPasswordRepository {
  final RestClient _client;
  ForgotPasswordRepoImpl(this._client);

  @override
  Future<BaseResponse> forgotPassword(ForgotPasswordDto data) async {
    try {
      return await _client.forgotPassword(data);
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }
}

final forgotPassRepo =
    Provider((_) => ForgotPasswordRepoImpl(_.read(restClient)));
