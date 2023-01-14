// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:bartr/core/config/exception/app_exception.dart';
import 'package:bartr/core/config/response/base_response.dart';
import 'package:bartr/core/services/network/rest_client.dart';
import 'package:bartr/domain/repositories/notifications_repository.dart';
import 'package:bartr/features/notification/domain/notification_model.dart';

class NotificationRepositoryImpl implements NotificationsRepository {
  final RestClient client;
  NotificationRepositoryImpl({
    required this.client,
  });
  @override
  Future<BaseResponse<NotificationResponse>> getNotifications(int page) async {
    try {
      return await client.getNotifications({
        "page": page,
      });
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }
}

final notificationRepository = Provider(
  (ref) => NotificationRepositoryImpl(
    client: ref.read(
      restClient,
    ),
  ),
);
