import 'package:bartr/core/config/exception/logger.dart';
import 'package:bartr/core/config/response/base_response.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:dio/dio.dart';

class AppException implements Exception {
  static BaseResponse<T> handleError<T>(
    DioError e, {
    T? data,
  }) {
    debugLog(e);
    if (e.response != null && DioErrorType.response == e.type) {
      if (e.response!.statusCode! >= 500) {
        return BaseResponse(
          status: false,
          error: Strings.serverError,
          data: data,
        );
      }
      if (e.response?.data is Map<String, dynamic>) {
        debugLog(BaseResponse.fromMap(e.response?.data).error);
        return BaseResponse.fromMap(e.response?.data);
      } else if (e.response?.data is String) {
        debugLog(e.response?.data);
        return BaseResponse(
          status: false,
          error: e.response?.data,
        );
      }
    }
    return BaseResponse(
      status: false,
      data: data,
      error: _mapException(e.type),
    );
  }

  static String _mapException(DioErrorType? error) {
    if (DioErrorType.connectTimeout == error ||
        DioErrorType.receiveTimeout == error ||
        DioErrorType.sendTimeout == error) {
      return Strings.timeout;
    } else if (DioErrorType.other == error) {
      return Strings.connectionError;
    }
    return Strings.genericErrorMessage;
  }
}
