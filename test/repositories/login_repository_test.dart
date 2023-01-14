import 'package:bartr/core/config/response/base_response.dart';
import 'package:bartr/core/services/network/rest_client.dart';
import 'package:bartr/features/login/data/repository.dart';
import 'package:bartr/features/login/domain/dtos/login_dto.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import '../fixtures/client_fixtures.dart';

void main() {
  final dio = Dio();
  final dioAdapter = DioAdapter(dio: dio, matcher: const UrlRequestMatcher());
  setUp(() {
    dio.httpClientAdapter = dioAdapter;
  });

  group('Login Repository =>', () {
    test('Login function. Expect a baseresponse object', () async {
      dioAdapter.onPost(
        '/auth/login',
        (request) {
          return request.reply(
            200,
            clientFixtures,
          );
        },
        data: null,
        queryParameters: {},
        headers: {},
      );
      final client = RestClient(dioAdapter.dio);
      final loginRepo = LoginRepositoryImpl(client);

      final res = await loginRepo.login(
          const LoginDto(username: "text@test.com", password: "Test@123"));

      expect(res, isA<BaseResponse<UserResponse>>());
      expect(res.data?.user.username, "Pure");
    });
  });
}
