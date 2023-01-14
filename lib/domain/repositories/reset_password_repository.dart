import 'package:bartr/core/config/response/base_response.dart';
import 'package:bartr/features/forgot_password/domain/dtos/reset_password_dto.dart';

abstract class ResetPasswordRepository {
  Future<BaseResponse> resetPassword(ResetPasswordDto data);
}
