import 'dart:convert';
import 'dart:io';

import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/features/create_post/domain/dtos/report_post_dto.dart';
import 'package:bartr/features/dashboard/domain/dtos/fcm_dto.dart';
import 'package:bartr/features/profile/domain/dtos/change_password_dto.dart';
import 'package:bartr/features/search/domain/models/searched_users_model.dart';
import 'package:bartr/features/verify_profile/presentation/domain/verify_profile_dto.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:bartr/core/config/exception/app_exception.dart';
import 'package:bartr/core/config/response/base_response.dart';
import 'package:bartr/core/services/local_database/abstract_class_hivestorage.dart';
import 'package:bartr/core/services/local_database/hive_keys.dart';
import 'package:bartr/core/services/network/rest_client.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:bartr/features/profile/domain/dtos/edit_profile_dto.dart';

import '../../../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._storage, this._client, this._ref);

  final AbstractHive _storage;
  final RestClient _client;
  final Ref _ref;
  @override
  BartrUser getUser() {
    final response = _storage.get(HiveKeys.user) ?? {};
    BartrUser user = BartrUser.fromJson(
        response is String ? json.decode(response) : json.decode("$response"));
    return user;
  }

  @override
  void saveUser(BartrUser user) async {
    await _storage.put(HiveKeys.user, json.encode(user));
  }

  @override
  void saveCurrentState(CurrentState val) async {
    await _storage.put(HiveKeys.currentState, val.name);
  }

  @override
  CurrentState getCurrentState() {
    switch (_storage.get(HiveKeys.currentState) ?? CurrentState.initial.name) {
      case "loggedIn":
        return CurrentState.loggedIn;
      case "onboarded":
        return CurrentState.onboarded;
      default:
        return CurrentState.initial;
    }
  }

  @override
  Future<BaseResponse<BartrUser>> getUserProfile(String username) async {
    try {
      return await _client.getUserProfile(username);
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  void saveToken(String val) async {
    await _storage.put(HiveKeys.token, val);
  }

  @override
  String getToken() {
    return _storage.get(HiveKeys.token) ?? "";
  }

  @override
  Future<BaseResponse> followOrUnfollowUser(String userId) async {
    try {
      return await _client.followOrUnfollowUser(userId);
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  Future<BaseResponse> editProfile(EditProfileDto data) async {
    try {
      return await _client.editProfile(
        profilePicture: data.profilePicture,
        name: data.name,
        username: data.username,
        country: data.country,
      );
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  void setCurrentUser(BartrUser user) {
    _ref.read(currentUserProvider.notifier).state = user;
    saveUser(user);
  }

  @override
  void saveFCMTokenLocally(String val) async {
    await _storage.put(HiveKeys.fcmToken, val);
  }

  @override
  Future<BaseResponse> saveFCMTokenRemotely(FcmTokenDto val) async {
    try {
      return await _client.storeFcmToken(val);
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  String getFCMToken() {
    return _storage.get(HiveKeys.fcmToken) ?? "";
  }

  @override
  Future<BaseResponse> changeCoverPhoto(File data) async {
    try {
      return await _client.changeCoverPhoto(coverPhoto: data);
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  Future<BaseResponse> deleteUser() async {
    try {
      return await _client.deleteAccount();
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  Future<BaseResponse<List<SearchedUser>>> searchUsers(String query) async {
    try {
      return await _client.searchUsers(query);
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  Future<BaseResponse> changePassword(ChangePasswordDto data) async {
    try {
      return await _client.changePassword(data);
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  Future<BaseResponse> verifyProfile(VerifyProfileDto data) async {
    try {
      return await _client.verifyProfile(
        idType: data.idType,
        idImage: data.idImage,
      );
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  Future<BaseResponse> reportUser({required ReportPostDto data}) async {
    try {
      return await _client.reportUser(data);
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  bool hasClearedCache() {
    return _storage.get(HiveKeys.clearedCache) ?? false;
  }

  @override
  void saveCacheStatus(bool status) async {
    await _storage.put(HiveKeys.clearedCache, status);
  }
}
