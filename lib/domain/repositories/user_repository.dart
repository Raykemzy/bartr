import 'dart:io';

import 'package:bartr/core/config/response/base_response.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/features/dashboard/domain/dtos/fcm_dto.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:bartr/features/profile/domain/dtos/change_password_dto.dart';
import 'package:bartr/features/profile/domain/dtos/edit_profile_dto.dart';
import 'package:bartr/features/search/domain/models/searched_users_model.dart';
import 'package:bartr/features/verify_profile/presentation/domain/verify_profile_dto.dart';

import '../../features/create_post/domain/dtos/report_post_dto.dart';

abstract class UserRepository {
  void saveUser(BartrUser user);
  void setCurrentUser(BartrUser user);
  BartrUser getUser();
  void saveCurrentState(CurrentState val);
  void saveToken(String val);
  void saveFCMTokenLocally(String val);
  Future<BaseResponse> saveFCMTokenRemotely(FcmTokenDto val);
  String getToken();
  String getFCMToken();
  CurrentState getCurrentState();
  Future<BaseResponse<BartrUser>> getUserProfile(String username);
  Future<BaseResponse> followOrUnfollowUser(String userId);
  Future<BaseResponse> editProfile(EditProfileDto data);
  Future<BaseResponse> changeCoverPhoto(File data);
  Future<BaseResponse> changePassword(ChangePasswordDto data);
  Future<BaseResponse> deleteUser();
  Future<BaseResponse> verifyProfile(VerifyProfileDto data);
  Future<BaseResponse<List<SearchedUser>>> searchUsers(String query);
  Future<BaseResponse> reportUser({required ReportPostDto data});
  bool hasClearedCache();
  void saveCacheStatus(bool status);
}
