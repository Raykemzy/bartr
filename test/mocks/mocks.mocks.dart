// Mocks generated by Mockito 5.3.2 from annotations
// in bartr/test/mocks/mocks.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:io' as _i11;

import 'package:bartr/core/config/response/base_response.dart' as _i4;
import 'package:bartr/core/services/local_database/local_db.dart' as _i5;
import 'package:bartr/core/utils/enums.dart' as _i8;
import 'package:bartr/features/create_post/domain/dtos/report_post_dto.dart'
    as _i15;
import 'package:bartr/features/dashboard/domain/dtos/fcm_dto.dart' as _i10;
import 'package:bartr/features/login/data/repository.dart' as _i16;
import 'package:bartr/features/login/domain/dtos/login_dto.dart' as _i17;
import 'package:bartr/features/login/domain/models/login_model.dart' as _i3;
import 'package:bartr/features/profile/data/repositories/user_repository_impl.dart'
    as _i7;
import 'package:bartr/features/profile/domain/dtos/change_password_dto.dart'
    as _i13;
import 'package:bartr/features/profile/domain/dtos/edit_profile_dto.dart'
    as _i9;
import 'package:bartr/features/search/domain/models/searched_users_model.dart'
    as _i12;
import 'package:bartr/features/verify_profile/presentation/domain/verify_profile_dto.dart'
    as _i14;
import 'package:hive_flutter/hive_flutter.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeBox_0<E> extends _i1.SmartFake implements _i2.Box<E> {
  _FakeBox_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeBartrUser_1 extends _i1.SmartFake implements _i3.BartrUser {
  _FakeBartrUser_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeBaseResponse_2<T> extends _i1.SmartFake
    implements _i4.BaseResponse<T> {
  _FakeBaseResponse_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [HiveStorage].
///
/// See the documentation for Mockito's code generation for more information.
class MockHiveStorage extends _i1.Mock implements _i5.HiveStorage {
  @override
  _i2.Box<dynamic> get box => (super.noSuchMethod(
        Invocation.getter(#box),
        returnValue: _FakeBox_0<dynamic>(
          this,
          Invocation.getter(#box),
        ),
        returnValueForMissingStub: _FakeBox_0<dynamic>(
          this,
          Invocation.getter(#box),
        ),
      ) as _i2.Box<dynamic>);
  @override
  _i6.Future<void> put(
    dynamic key,
    dynamic value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [
            key,
            value,
          ],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  T? get<T>(String? key) => (super.noSuchMethod(
        Invocation.method(
          #get,
          [key],
        ),
        returnValueForMissingStub: null,
      ) as T?);
  @override
  dynamic getAt(int? key) => super.noSuchMethod(
        Invocation.method(
          #getAt,
          [key],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i6.Future<int> add(dynamic value) => (super.noSuchMethod(
        Invocation.method(
          #add,
          [value],
        ),
        returnValue: _i6.Future<int>.value(0),
        returnValueForMissingStub: _i6.Future<int>.value(0),
      ) as _i6.Future<int>);
  @override
  _i6.Future<int> clear() => (super.noSuchMethod(
        Invocation.method(
          #clear,
          [],
        ),
        returnValue: _i6.Future<int>.value(0),
        returnValueForMissingStub: _i6.Future<int>.value(0),
      ) as _i6.Future<int>);
  @override
  _i6.Future<void> delete(dynamic value) => (super.noSuchMethod(
        Invocation.method(
          #delete,
          [value],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> putAll(Map<String, dynamic>? entries) => (super.noSuchMethod(
        Invocation.method(
          #putAll,
          [entries],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
}

/// A class which mocks [UserRepositoryImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserRepositoryImpl extends _i1.Mock
    implements _i7.UserRepositoryImpl {
  @override
  _i3.BartrUser getUser() => (super.noSuchMethod(
        Invocation.method(
          #getUser,
          [],
        ),
        returnValue: _FakeBartrUser_1(
          this,
          Invocation.method(
            #getUser,
            [],
          ),
        ),
        returnValueForMissingStub: _FakeBartrUser_1(
          this,
          Invocation.method(
            #getUser,
            [],
          ),
        ),
      ) as _i3.BartrUser);
  @override
  void saveUser(_i3.BartrUser? user) => super.noSuchMethod(
        Invocation.method(
          #saveUser,
          [user],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void saveCurrentState(_i8.CurrentState? val) => super.noSuchMethod(
        Invocation.method(
          #saveCurrentState,
          [val],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i8.CurrentState getCurrentState() => (super.noSuchMethod(
        Invocation.method(
          #getCurrentState,
          [],
        ),
        returnValue: _i8.CurrentState.loggedIn,
        returnValueForMissingStub: _i8.CurrentState.loggedIn,
      ) as _i8.CurrentState);
  @override
  _i6.Future<_i4.BaseResponse<_i3.BartrUser>> getUserProfile(
          String? username) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserProfile,
          [username],
        ),
        returnValue: _i6.Future<_i4.BaseResponse<_i3.BartrUser>>.value(
            _FakeBaseResponse_2<_i3.BartrUser>(
          this,
          Invocation.method(
            #getUserProfile,
            [username],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i4.BaseResponse<_i3.BartrUser>>.value(
                _FakeBaseResponse_2<_i3.BartrUser>(
          this,
          Invocation.method(
            #getUserProfile,
            [username],
          ),
        )),
      ) as _i6.Future<_i4.BaseResponse<_i3.BartrUser>>);
  @override
  void saveToken(String? val) => super.noSuchMethod(
        Invocation.method(
          #saveToken,
          [val],
        ),
        returnValueForMissingStub: null,
      );
  @override
  String getToken() => (super.noSuchMethod(
        Invocation.method(
          #getToken,
          [],
        ),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
  @override
  _i6.Future<_i4.BaseResponse<dynamic>> followOrUnfollowUser(String? userId) =>
      (super.noSuchMethod(
        Invocation.method(
          #followOrUnfollowUser,
          [userId],
        ),
        returnValue: _i6.Future<_i4.BaseResponse<dynamic>>.value(
            _FakeBaseResponse_2<dynamic>(
          this,
          Invocation.method(
            #followOrUnfollowUser,
            [userId],
          ),
        )),
        returnValueForMissingStub: _i6.Future<_i4.BaseResponse<dynamic>>.value(
            _FakeBaseResponse_2<dynamic>(
          this,
          Invocation.method(
            #followOrUnfollowUser,
            [userId],
          ),
        )),
      ) as _i6.Future<_i4.BaseResponse<dynamic>>);
  @override
  _i6.Future<_i4.BaseResponse<dynamic>> editProfile(_i9.EditProfileDto? data) =>
      (super.noSuchMethod(
        Invocation.method(
          #editProfile,
          [data],
        ),
        returnValue: _i6.Future<_i4.BaseResponse<dynamic>>.value(
            _FakeBaseResponse_2<dynamic>(
          this,
          Invocation.method(
            #editProfile,
            [data],
          ),
        )),
        returnValueForMissingStub: _i6.Future<_i4.BaseResponse<dynamic>>.value(
            _FakeBaseResponse_2<dynamic>(
          this,
          Invocation.method(
            #editProfile,
            [data],
          ),
        )),
      ) as _i6.Future<_i4.BaseResponse<dynamic>>);
  @override
  void setCurrentUser(_i3.BartrUser? user) => super.noSuchMethod(
        Invocation.method(
          #setCurrentUser,
          [user],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void saveFCMTokenLocally(String? val) => super.noSuchMethod(
        Invocation.method(
          #saveFCMTokenLocally,
          [val],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i6.Future<_i4.BaseResponse<dynamic>> saveFCMTokenRemotely(
          _i10.FcmTokenDto? val) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveFCMTokenRemotely,
          [val],
        ),
        returnValue: _i6.Future<_i4.BaseResponse<dynamic>>.value(
            _FakeBaseResponse_2<dynamic>(
          this,
          Invocation.method(
            #saveFCMTokenRemotely,
            [val],
          ),
        )),
        returnValueForMissingStub: _i6.Future<_i4.BaseResponse<dynamic>>.value(
            _FakeBaseResponse_2<dynamic>(
          this,
          Invocation.method(
            #saveFCMTokenRemotely,
            [val],
          ),
        )),
      ) as _i6.Future<_i4.BaseResponse<dynamic>>);
  @override
  String getFCMToken() => (super.noSuchMethod(
        Invocation.method(
          #getFCMToken,
          [],
        ),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
  @override
  _i6.Future<_i4.BaseResponse<dynamic>> changeCoverPhoto(_i11.File? data) =>
      (super.noSuchMethod(
        Invocation.method(
          #changeCoverPhoto,
          [data],
        ),
        returnValue: _i6.Future<_i4.BaseResponse<dynamic>>.value(
            _FakeBaseResponse_2<dynamic>(
          this,
          Invocation.method(
            #changeCoverPhoto,
            [data],
          ),
        )),
        returnValueForMissingStub: _i6.Future<_i4.BaseResponse<dynamic>>.value(
            _FakeBaseResponse_2<dynamic>(
          this,
          Invocation.method(
            #changeCoverPhoto,
            [data],
          ),
        )),
      ) as _i6.Future<_i4.BaseResponse<dynamic>>);
  @override
  _i6.Future<_i4.BaseResponse<dynamic>> deleteUser() => (super.noSuchMethod(
        Invocation.method(
          #deleteUser,
          [],
        ),
        returnValue: _i6.Future<_i4.BaseResponse<dynamic>>.value(
            _FakeBaseResponse_2<dynamic>(
          this,
          Invocation.method(
            #deleteUser,
            [],
          ),
        )),
        returnValueForMissingStub: _i6.Future<_i4.BaseResponse<dynamic>>.value(
            _FakeBaseResponse_2<dynamic>(
          this,
          Invocation.method(
            #deleteUser,
            [],
          ),
        )),
      ) as _i6.Future<_i4.BaseResponse<dynamic>>);
  @override
  _i6.Future<_i4.BaseResponse<List<_i12.SearchedUser>>> searchUsers(
          String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchUsers,
          [query],
        ),
        returnValue:
            _i6.Future<_i4.BaseResponse<List<_i12.SearchedUser>>>.value(
                _FakeBaseResponse_2<List<_i12.SearchedUser>>(
          this,
          Invocation.method(
            #searchUsers,
            [query],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i4.BaseResponse<List<_i12.SearchedUser>>>.value(
                _FakeBaseResponse_2<List<_i12.SearchedUser>>(
          this,
          Invocation.method(
            #searchUsers,
            [query],
          ),
        )),
      ) as _i6.Future<_i4.BaseResponse<List<_i12.SearchedUser>>>);
  @override
  _i6.Future<_i4.BaseResponse<dynamic>> changePassword(
          _i13.ChangePasswordDto? data) =>
      (super.noSuchMethod(
        Invocation.method(
          #changePassword,
          [data],
        ),
        returnValue: _i6.Future<_i4.BaseResponse<dynamic>>.value(
            _FakeBaseResponse_2<dynamic>(
          this,
          Invocation.method(
            #changePassword,
            [data],
          ),
        )),
        returnValueForMissingStub: _i6.Future<_i4.BaseResponse<dynamic>>.value(
            _FakeBaseResponse_2<dynamic>(
          this,
          Invocation.method(
            #changePassword,
            [data],
          ),
        )),
      ) as _i6.Future<_i4.BaseResponse<dynamic>>);
  @override
  _i6.Future<_i4.BaseResponse<dynamic>> verifyProfile(
          _i14.VerifyProfileDto? data) =>
      (super.noSuchMethod(
        Invocation.method(
          #verifyProfile,
          [data],
        ),
        returnValue: _i6.Future<_i4.BaseResponse<dynamic>>.value(
            _FakeBaseResponse_2<dynamic>(
          this,
          Invocation.method(
            #verifyProfile,
            [data],
          ),
        )),
        returnValueForMissingStub: _i6.Future<_i4.BaseResponse<dynamic>>.value(
            _FakeBaseResponse_2<dynamic>(
          this,
          Invocation.method(
            #verifyProfile,
            [data],
          ),
        )),
      ) as _i6.Future<_i4.BaseResponse<dynamic>>);
  @override
  _i6.Future<_i4.BaseResponse<dynamic>> reportUser(
          {required _i15.ReportPostDto? data}) =>
      (super.noSuchMethod(
        Invocation.method(
          #reportUser,
          [],
          {#data: data},
        ),
        returnValue: _i6.Future<_i4.BaseResponse<dynamic>>.value(
            _FakeBaseResponse_2<dynamic>(
          this,
          Invocation.method(
            #reportUser,
            [],
            {#data: data},
          ),
        )),
        returnValueForMissingStub: _i6.Future<_i4.BaseResponse<dynamic>>.value(
            _FakeBaseResponse_2<dynamic>(
          this,
          Invocation.method(
            #reportUser,
            [],
            {#data: data},
          ),
        )),
      ) as _i6.Future<_i4.BaseResponse<dynamic>>);
  @override
  bool hasClearedCache() => (super.noSuchMethod(
        Invocation.method(
          #hasClearedCache,
          [],
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  void saveCacheStatus(bool? status) => super.noSuchMethod(
        Invocation.method(
          #saveCacheStatus,
          [status],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [LoginRepositoryImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginRepositoryImpl extends _i1.Mock
    implements _i16.LoginRepositoryImpl {
  @override
  _i6.Future<_i4.BaseResponse<_i3.UserResponse>> login(_i17.LoginDto? data) =>
      (super.noSuchMethod(
        Invocation.method(
          #login,
          [data],
        ),
        returnValue: _i6.Future<_i4.BaseResponse<_i3.UserResponse>>.value(
            _FakeBaseResponse_2<_i3.UserResponse>(
          this,
          Invocation.method(
            #login,
            [data],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i4.BaseResponse<_i3.UserResponse>>.value(
                _FakeBaseResponse_2<_i3.UserResponse>(
          this,
          Invocation.method(
            #login,
            [data],
          ),
        )),
      ) as _i6.Future<_i4.BaseResponse<_i3.UserResponse>>);
}
