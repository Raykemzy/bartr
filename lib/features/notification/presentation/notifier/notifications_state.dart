
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/features/notification/domain/notification_model.dart';

import '../../../../core/helpers/extensions.dart';

class NotificationsState {
  final LoadState notificationsLoadState;
  final List<NotificationModel> notifications;
  Groups<DateTime, NotificationModel> groups;
  NotificationsState({
    required this.notificationsLoadState,
    required this.notifications,
    required this.groups,
  });

  factory NotificationsState.initial() => NotificationsState(
        notificationsLoadState: LoadState.loading,
        notifications: const [],
        groups: Groups<DateTime, NotificationModel>(keys: [], children: []),
      );

  NotificationsState copyWith({
    LoadState? notificationsLoadState,
    List<NotificationModel>? notifications,
    Groups<DateTime, NotificationModel>? groups,
  }) {
    return NotificationsState(
      notificationsLoadState: notificationsLoadState ?? this.notificationsLoadState,
      notifications: notifications ?? this.notifications,
      groups: groups ?? this.groups,
    );
  }
}
