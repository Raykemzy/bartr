import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mocks.mocks.dart';

void main() {
  late MockUserRepositoryImpl userRepo;

  setUp(() {
    userRepo = MockUserRepositoryImpl();
  });
  group('User repository test =>', () {
    var user = BartrUser(
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
    test('Test that the user object is being storeed in the local db',
        () async {
      when(
        userRepo.getUser(),
      ).thenReturn(user);
      var newuser = userRepo.getUser();
      expect(newuser, isA<BartrUser>());
    });

    test('set currentuser', () {
      when(userRepo.setCurrentUser(user)).thenAnswer((_) async {});
      userRepo.setCurrentUser(user);
      verify(userRepo.setCurrentUser(user)).called(1);
    });
  });
}
