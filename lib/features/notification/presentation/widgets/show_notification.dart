import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/helpers/extensions.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/notification/domain/notification_model.dart';

import 'package:bartr/features/notification/presentation/notifier/notifications_notifier.dart';
import 'package:bartr/features/notification/presentation/widgets/notification_tile.dart';
import 'package:bartr/general_widgets/bartr_loader.dart';
import 'package:bartr/general_widgets/retry_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/router.dart';
import 'empty_nofication.dart';

class ShowNotification extends HookConsumerWidget {
  const ShowNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationsNotifier);
    final model = ref.read(notificationsNotifier.notifier);
    final user = ref.watch(currentUserProvider);

    NotificationModel(type: NotificationType.message);
    bool loadmore = state.notificationsLoadState == LoadState.loadmore;
    ValueNotifier<int> page = useState(1);
    return state.notificationsLoadState == LoadState.loading
        ? const BartrLoader(
            color: BartrColors.black,
          )
        : state.notificationsLoadState == LoadState.error
            ? RetryWidget(onRetry: () => model.getNotifications(page: 1))
            : state.notifications.isEmpty
                ? const EmptyNotification()
                : RefreshIndicator(
                    onRefresh: () => model.getNotifications(page: 1),
                    child: NotificationListener<ScrollEndNotification>(
                      onNotification: (not) {
                        if (state.notificationsLoadState == LoadState.done) {
                          return true;
                        } else {
                          if (not.metrics.pixels ==
                                  not.metrics.maxScrollExtent &&
                              not.metrics.axisDirection == AxisDirection.down) {
                            page.value = page.value + 1;

                            model.getNotifications(
                              page: page.value,
                              loadmore: true,
                            );
                            return false;
                          } else {
                            return true;
                          }
                        }
                      },
                      child: Column(
                        children: [
                          if (!(user.verified ?? false))
                            NotificationTile(
                              onTap: () => context.router.push(
                                const VerifyProfilePageRoute(),
                              ),
                              model: NotificationModel(
                                type: NotificationType.message,
                                title: 'verification checking',
                                body: 'We would like you to Verify yourself',
                                post: '',
                                createdAt: DateTime.now(),
                              ),
                            ),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(bottom: 50),
                              itemCount: state.groups.keys.length,
                              itemBuilder: (context, index) =>
                                  GroupedNotifications(
                                header: state.groups.keys[index]
                                    .convertDateHeaderToString,
                                notifications: state.groups.children[index],
                              ),
                            ),
                          ),
                          if (loadmore)
                            const BartrLoader(color: BartrColors.primary),
                          if (loadmore) const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  );
  }
}

class GroupedNotifications extends StatelessWidget {
  const GroupedNotifications({
    Key? key,
    required this.notifications,
    required this.header,
  }) : super(key: key);
  final String header;
  final List<NotificationModel> notifications;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 26.0, left: 20, bottom: 10),
          child: Text(
            header,
            style: Styles.w500(size: 14, color: BartrColors.grey),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(5),
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return NotificationTile(model: notifications[index]);
          },
        ),
      ],
    );
  }
}
