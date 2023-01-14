import 'dart:io';

import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/config/exception/app_exception.dart';
import 'package:bartr/core/config/response/base_response.dart';
import 'package:bartr/core/services/network/rest_client.dart';
import 'package:bartr/domain/repositories/register_repository.dart';
import 'package:bartr/features/registration/domain/dtos/register_dto.dart';
import 'package:bartr/features/registration/domain/models/register_model.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  RegisterRepositoryImpl(this._client);

  final RestClient _client;

  @override
  Future<BaseResponse> register(
    RegisterDto data,
    File profilePicture,
  ) async {
    try {
      return await _client.register(
        country: data.country,
        email: data.email,
        password: data.password,
        fullName: data.fullName,
        profilePicture: profilePicture,
        username: data.username,
      );
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  Future<BaseResponse<RegisterResponse>> verifyEmail(
    VerifyEmailDto data,
  ) async {
    try {
      return await _client.verifyEmail(data);
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  Future<BaseResponse> resendVerificationCode(ResendCodeDto data) async {
    try {
      return await _client.resendVerificationCode(data);
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }
}

final registerRepository =
    Provider((_) => RegisterRepositoryImpl(_.read(restClient)));
