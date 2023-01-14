import 'package:bartr/core/config/response/base_response.dart';
import 'package:bartr/features/notification/domain/notification_model.dart';

abstract class NotificationsRepository {
  Future<BaseResponse<NotificationResponse>> getNotifications(int page);
}
