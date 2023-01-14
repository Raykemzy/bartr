import 'package:bartr/features/login/domain/dtos/login_dto.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';

import '../../core/config/response/base_response.dart';


abstract class LoginRepository {
  Future<BaseResponse<UserResponse>> login(LoginDto data);
}
