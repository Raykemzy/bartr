import 'package:bartr/core/config/response/base_response.dart';
import 'package:bartr/features/forgot_password/domain/dtos/forgot_password_dto.dart';

abstract class ForgotPasswordRepository {
  Future<BaseResponse> forgotPassword(ForgotPasswordDto data);
}
