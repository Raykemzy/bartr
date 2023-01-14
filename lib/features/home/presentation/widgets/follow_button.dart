import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/helpers/mixins.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FollowButton extends HookConsumerWidget with PostMixin{
  const FollowButton({
    Key? key,
    required this.user,
  }) : super(key: key);
  final PostUser user;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final currentuser = ref.watch(currentUserProvider);
    
    ValueNotifier<PostUser> postState = useState(user);
    PostUser postuser = postState.value;

    ValueNotifier<bool> isFollowing =
        useState(user.followers!.contains(currentuser.id));

    void changeLikeStatus() {
      if (!isFollowing.value) {
        isFollowing.value = true;
      } else {
        isFollowing.value = false;
      }
    }

    void followAndUnfollow() async {
      changeLikeStatus();
      final res = await followOrUnfollow(postuser.id!,ref);
      if (!res) {
        changeLikeStatus();
      }
    }

    return InkWell(
      onTap: followAndUnfollow,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color:
              isFollowing.value ? BartrColors.lightGrey : BartrColors.primary,
          boxShadow: const [
            BoxShadow(blurRadius: 5, color: BartrColors.lightGrey),
          ],
        ),
        child: Text(
          isFollowing.value ? "Unfollow" : "Follow",
          style: Styles.w400(
            size: 12,
            color: isFollowing.value ? BartrColors.black : BartrColors.white,
          ),
        ),
      ),
    );
  }
}
