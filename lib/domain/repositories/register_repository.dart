import 'dart:io';

import 'package:bartr/features/registration/domain/dtos/register_dto.dart';
import 'package:bartr/features/registration/domain/models/register_model.dart';

import '../../core/config/response/base_response.dart';

abstract class RegisterRepository {
  Future<BaseResponse> register(
    RegisterDto data,
    File profilePicture,
  );

  Future<BaseResponse<RegisterResponse>> verifyEmail(
    VerifyEmailDto data,
  );

  Future<BaseResponse> resendVerificationCode(ResendCodeDto data);
}
