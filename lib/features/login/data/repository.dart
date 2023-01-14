import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/config/exception/app_exception.dart';
import 'package:bartr/core/services/network/rest_client.dart';
import 'package:bartr/domain/repositories/login_repository.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:bartr/features/login/domain/dtos/login_dto.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/config/response/base_response.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl(this._client);

  final RestClient _client;

  @override
  Future<BaseResponse<UserResponse>> login(LoginDto data) async {
    try {
      return await _client.login(data);
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }
}

final loginRepository =
    Provider<LoginRepository>((_) => LoginRepositoryImpl(_.read(restClient)));
