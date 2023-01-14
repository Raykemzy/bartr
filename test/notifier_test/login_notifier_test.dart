import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/config/response/base_response.dart';
import 'package:bartr/core/router/routes.dart';
import 'package:bartr/domain/repositories/login_repository.dart';
import 'package:bartr/features/login/data/repository.dart';
import 'package:bartr/features/login/domain/dtos/login_dto.dart';
import 'package:bartr/features/login/presentation/notifier/login_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';

import '../fixtures/client_fixtures.dart';
import '../mocks/mocks.mocks.dart';

void main() {
  late MockUserRepositoryImpl userRepo;
  late LoginRepository loginMock;
  late ProviderContainer container;
  setUp(() {
    userRepo = MockUserRepositoryImpl();
    loginMock = MockLoginRepositoryImpl();
    container = ProviderContainer(
      overrides: [
        userRepository.overrideWithValue(userRepo),
        loginRepository.overrideWithValue(loginMock),
      ],
    );
  });

  group('Login Notifier => ', () {
    const loginDto = LoginDto(username: "text@test.com", password: "Test@123");
    final user = BartrUser(
      fullName: "Testing Account",
      username: "Testing",
      country: "Nigeria",
      coverPhoto: "image.jpg",
      email: "test@gmail.com",
      emailConfirmed: true,
      expoPushToken: "1212",
      id: "614D",
      profilePicture: "img.png",
      signupCode: 3409,
      terms: true,
      v: 1,
    );
    test('Expect the initial state of LoginNotifier to be idle', () async {
      expect(container.read(loginNotifier).loadState, LoginLoadState.idle);
    });

    test(
        'When login function is called, expect the state to be Loadstate.loading',
        () {
      var loginResponse = BaseResponse<UserResponse>.fromJson(loginFixtures,
          (json) => UserResponse.fromJson(json as Map<String, dynamic>));
      when(loginMock.login(loginDto))
          .thenAnswer((_) => Future.value(loginResponse));
      container.read(loginNotifier.notifier).login(loginDto);
      expect(container.read(loginNotifier).loadState, LoginLoadState.loading);
    });

    test(
      'When login function is called and it is successful, verify that the user data has been stored locally \n and state.errorMessage is Empty',
      () async {
        var loginResponse = BaseResponse<UserResponse>.fromJson(loginFixtures,
            (json) => UserResponse.fromJson(json as Map<String, dynamic>));
        when(loginMock.login(loginDto))
            .thenAnswer((_) => Future.value(loginResponse));
        when(userRepo.setCurrentUser(user)).thenAnswer((_) async {});
        when(userRepo.getUser()).thenReturn(user);
        await container.read(loginNotifier.notifier).login(loginDto);
        expect(container.read(loginNotifier).loadState, LoginLoadState.success);
        expect(container.read(loginNotifier).errorMessage.isEmpty, true);
        final storageRes = container.read(userRepository).getUser();
        expect(storageRes, isA<BartrUser>());
        expect(storageRes.email, "test@gmail.com");
      },
    );

    test(
        'Verify that an error message is returned if username or password is incorrect and\nloginstate == LoginState.error',
        () async {
      var loginResponse =
          BaseResponse<UserResponse>.fromMap(failedloginFixtures);
      when(loginMock.login(loginDto))
          .thenAnswer((_) => Future.value(loginResponse));
      final loginres =
          await container.read(loginNotifier.notifier).login(loginDto);
      expect(container.read(loginNotifier).loadState, LoginLoadState.error);
      expect(loginResponse.data, null);
      expect(loginres, "Incorrect email or password");
    });
  });
}
