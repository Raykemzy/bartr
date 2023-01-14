import 'package:bartr/core/helpers/mixins.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:bartr/features/profile/presentation/notifier/profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FollowUnfollowButton extends HookConsumerWidget with PostMixin {
  const FollowUnfollowButton({
    Key? key,
    required this.user,
    required this.currentuser,
  }) : super(key: key);
  final Follow user;
  final BartrUser currentuser;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ValueNotifier<Follow> postState = useState(user);
    Follow postuser = postState.value;

    ValueNotifier<bool> isFollowing = useState(
        currentuser.following!.any((element) => element.id == user.id));

    void changeLikeStatus() {
      if (!isFollowing.value) {
        isFollowing.value = true;
      } else {
        isFollowing.value = false;
      }
    }

    void followAndUnfollow() async {
      changeLikeStatus();
      final res = await followOrUnfollow(postuser.id!, ref);
      ref
          .read(profileNotifier.notifier)
          .getUserProfile(username: currentuser.username!);
      if (!res) {
        changeLikeStatus();
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: followAndUnfollow,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isFollowing.value
                  ? BartrColors.lightGrey
                  : BartrColors.primary,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              isFollowing.value ? "Following" : "Follow",
              style: Styles.w400(
                size: 12,
                color: !isFollowing.value
                    ? BartrColors.lightGrey
                    : BartrColors.primary,
              ),
              textScaleFactor: 1,
            ),
          ),
        ),
      ],
    );
  }
}
