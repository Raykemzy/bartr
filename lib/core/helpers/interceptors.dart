// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bartr/domain/repositories/user_repository.dart';
import 'package:dio/dio.dart';

import 'package:bartr/core/config/exception/logger.dart';

class AppInterceptor extends Interceptor {
  Dio dio;
  UserRepository userRepository;
  AppInterceptor({
    required this.dio,
    required this.userRepository,
  });

  @override
  FutureOr<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    handler.next(options);
    try {
      final token = userRepository.getToken();
      if (token.isNotEmpty) {
        options.headers["Authorization"] = "Bearer $token";
      }
    } catch (e) {
      debugLog(e);
    }
    if (options.data != null) {
      debugLog('[URL]${options.uri}');
      debugLog("[BODY] ${options.data}");
    }
    return options;
  }

  @override
  FutureOr<dynamic> onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) {
    handler.next(err);
    return err;
  }

  @override
  FutureOr<dynamic> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    debugLog("Response: ${response.data}");
    handler.next(response);
    return response;
  }
}
