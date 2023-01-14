import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/helpers/extensions.dart';
import 'package:bartr/core/helpers/mixins.dart';
import 'package:bartr/core/router/routes.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/notification/domain/notification_model.dart';
import 'package:bartr/general_widgets/cached_network_image_display.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

import '../../../../core/router/router.dart';

class NotificationTile extends ConsumerWidget with NavigationMixin {
  const NotificationTile({
    Key? key,
    required this.model,
    this.onTap,
  }) : super(key: key);

  final NotificationModel model;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    return ListTile(
      onTap: onTap ??
          () => _navigateNested(
                context: context,
                notificationType: model.type,
                viewType: NavigationViewType.notifications,
              ),
      leading: InkWell(
        onTap: () {
          if (model.sender!.id! == currentUser.id) {
            // AutoTabsRouter.of(context).setActiveIndex(4);
            return;
          }
          context.router.push(
            OtherUserProfileRoute(
              userId: model.sender!.id!,
              key: ValueKey(model.post),
              username: model.sender!.username!,
            ),
          );
        },
        child: currentUser.verified == false && model.receiver == null
            ? Image.asset('assets/images/verifyB.png')
            : CachedNetworkDisplay(
                url: model.sender != null ? model.sender!.profilePicture! : "",
                height: 30,
                width: 30,
                radius: 70,
              ),
      ),
      title: currentUser.verified == false && model.receiver == null
          ? Text.rich(TextSpan(
              text: Strings.weWould,
              style: Styles.w500(size: 14, color: BartrColors.black),
              children: [
                  TextSpan(
                      text: Strings.toVerify,
                      style: Styles.w600(size: 14, color: BartrColors.primary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.router.push(const VerifyProfilePageRoute());
                        }),
                  TextSpan(
                    text: Strings.yourSelf,
                    style: Styles.w500(size: 14, color: BartrColors.black),
                  )
                ]))
          : LinkifyText(
              model.body ?? "",
              textStyle: Styles.w500(
                size: 14,
                color: BartrColors.black,
              ),
              linkStyle: Styles.w600(
                size: 14,
                color: BartrColors.primaryLight,
              ),
              linkTypes: const [
                LinkType.userTag,
              ],
              onTap: (link) {
                navigateToProfile(
                  context: context,
                  userId: link.value!.removeTag(),
                  username: link.value!.removeTag(),
                );
              },
              textAlign: TextAlign.left,
            ),
      subtitle: Timeago(
        date: model.createdAt!,
        builder: (context, value) {
          return Text(
            value,
            style: Styles.w400(
              size: 10,
              color: BartrColors.grey,
            ),
          );
        },
      ),
    );
  }

  void _navigateNested({
    required BuildContext context,
    required NavigationViewType viewType,
    required NotificationType notificationType,
  }) {
    switch (notificationType) {
      case NotificationType.comment:
        context.router.push(
          NotificationPostDetailRoute(
            key: ValueKey(model.post),
            postId: model.post!,
            senderId: model.sender!.id!,
          ),
        );
        break;
      case NotificationType.post:
        context.router.push(
          PostDetailRoute(
            key: ValueKey(model.post),
            postId: model.post!,
          ),
        );
        break;
      case NotificationType.bid:
        context.router.push(
          ItemBidsPageRoute(
            key: ValueKey(model.post),
            postId: model.post!,
          ),
        );
        break;
      case NotificationType.message:
        // TODO: Handle this case.
        break;
      case NotificationType.user:
        context.router.push(OtherUserProfileRoute(
          userId: model.sender!.id!,
          username: model.sender!.username!,
        ));
        break;
    }
  }
}
