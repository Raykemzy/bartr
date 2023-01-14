
import 'package:bartr/core/helpers/extensions.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/domain/repositories/notifications_repository.dart';
import 'package:bartr/features/notification/data/notification_repository_impl.dart';
import 'package:bartr/features/notification/presentation/notifier/notifications_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationsNotifier extends StateNotifier<NotificationsState> {
  NotificationsNotifier(this._notificationsRepository)
      : super(NotificationsState.initial());
  final NotificationsRepository _notificationsRepository;
  Future<void> getNotifications({
    bool loadmore = false,
    required int page,
  }) async {
    if (loadmore) {
      state = state.copyWith(notificationsLoadState: LoadState.loadmore);
    }
    try {
      final res = await _notificationsRepository.getNotifications(page);
      if (res.status) {
        if (!loadmore) {
          state = state.copyWith(
            groups: res.data!.notifications
                .groupBy((p0) => DateTime.parse(p0.createdAt!.splitDateOnly())),
            notifications: res.data?.notifications,
            notificationsLoadState: LoadState.success,
          );
        } else {
          state = state.copyWith(
            groups: [...state.notifications, ...res.data!.notifications]
                .groupBy((p0) => DateTime.parse(p0.createdAt!.splitDateOnly())),
            notifications: [...state.notifications, ...res.data!.notifications],
            notificationsLoadState: LoadState.success,
          );
        }
      } else {
        state = state.copyWith(notificationsLoadState: LoadState.error);
      }
      if (!res.data!.pagination!.hasNextPage!) {
        state = state.copyWith(notificationsLoadState: LoadState.done);
      }
    } catch (e) {
      state = state.copyWith(notificationsLoadState: LoadState.error);
    }
  }
}

final notificationsNotifier =
    StateNotifierProvider<NotificationsNotifier, NotificationsState>(
  (_) => NotificationsNotifier(
    _.read(notificationRepository),
  ),
);
