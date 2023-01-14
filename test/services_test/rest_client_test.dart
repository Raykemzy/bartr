import 'package:bartr/core/config/response/base_response.dart';
import 'package:bartr/core/services/network/rest_client.dart';
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

  group('RestClient Test ==>', () {
    test('When client.login is called, expect a LoginResponse Object',
        () async {
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
      final res = await client.login(
          const LoginDto(username: "text@test.com", password: "Test@123"));
      expect(res, isA<BaseResponse<UserResponse>>());
      expect(res.data?.user.username, "Pure");
      expect(res.status, true);
    });

    test(
        'when client.getUserPosts is called, we expect a Baseresponse<List<Post>> object',
        () async {
      String userid = "62e0dde5379382222cdf2e39";
      dioAdapter.onGet(
        '/post/$userid/user_posts',
        (request) {
          return request.reply(
            200,
            getUserPostFixtures,
          );
        },
        data: null,
        queryParameters: {},
        headers: {},
      );
      final client = RestClient(dioAdapter.dio);
      final response = await client.getUserPosts(userid, {
        "page": 1,
      });
      expect(response, isA<BaseResponse<List<Post>>>());
      expect(response.data!.posts.length, 1);
    });
  });
}

//Constructor injection - Passing what your class depends on as a parameter into
/// your class through the contructor
/// 
/// 
//Service lodator injection - is using service locator tools like get it to 
/// register your depencies as a service