import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/helpers/helper_functions.dart';
import 'package:bartr/core/helpers/mixins.dart';
import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/features/post_and_comments/presentation/notifier/post_notifier.dart';
import 'package:bartr/features/post_and_comments/presentation/widgets/comment_body.dart';
import 'package:bartr/features/post_and_comments/presentation/widgets/comment_like.dart';
import 'package:bartr/features/profile/presentation/notifier/profile_state.dart';
import 'package:bartr/general_widgets/cached_network_image_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../home/data/post_repository_impl.dart';
import '../../../messages/data/conversation_repositpry_impl.dart';
import '../../../messages/domain/dtos/conversation_dto.dart';
import '../../../messages/domain/models/conversation_model.dart';
import '../../../profile/presentation/notifier/profile_notifier.dart';
import '../../domain/models/single_post_model.dart';
import '../notifier/post_state.dart';

class PostCommentCard extends ConsumerWidget with NavigationMixin {
  PostCommentCard({
    Key? key,
    required this.comment,
    required this.post,
  }) : super(key: key);

  final SinglePost post; //POST COMMENT CARD Err
  final SinglePostComment comment;

  final userProfilefromHomeNotifier =
      StateNotifierProvider<ProfileNotifier, ProfileState>(
    (_) => ProfileNotifier(
      _.read(postsRepository),
      _.read(userRepository),
    ),
  );

  final postNotifier = StateNotifierProvider<PostNotifier, PostState>(
    (_) => PostNotifier(
      _.read(postsRepository),
      _.read(conversationRepository),
    ),
  );

  _createConversation({
    required String currentUserId,
    required String otherUserId,
    required CommentUser user,
    required BuildContext context,
    required WidgetRef ref,
  }) {
    final data = ConversationDto(userOne: currentUserId, userTwo: otherUserId);
    ref
        .read(postNotifier.notifier)
        .createConversation(
          data: data,
          currentUID: currentUserId,
          otherUID: otherUserId,
        )
        .then(
      (value) {
        if (value != null) {
          final member = Member(
            id: user.id!,
            fullName: user.fullName!,
            username: user.username!,
            profilePicture: user.profilePicture!,
            fcmPushToken: user.fcmPushToken ?? "",
          );
          context.router.push(
            ChatPageRoute(
              user: member,
              chatRoomId: value,
            ),
          );
        } else {
          showError(text: Strings.couldntStartConvo, context: context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentuser = ref.watch(currentUserProvider);

    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              if (comment.user!.id! == currentuser.id) {
                // AutoTabsRouter.of(context).setActiveIndex(4);
                null;
              } else {
                navigateToProfile(
                  context: context,
                  userId: comment.user!.id!,
                  username: comment.user!.username!,
                );
              }
            },
            child: CachedNetworkDisplay(
              height: 40,
              width: 40,
              url: comment.user!.profilePicture ?? "",
            ),
          ),
          CommentBody(comment: comment),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommentLike(
                comment: comment,
              ),
              const SizedBox(height: 30),
              if (currentuser.id == post.user!.id &&
                  comment.user!.id != post.user!.id &&
                  post.postType == PostType.Giveaway)
                Consumer(builder: (context, ref, child) {
                  return InkWell(
                    onTap: () => _createConversation(
                      currentUserId: currentuser.id!,
                      otherUserId: comment.user!.id!,
                      user: comment.user!,
                      context: context,
                      ref: ref,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/sms_fill.svg",
                      height: 20,
                      color: BartrColors.deepgrey,
                    ),
                  );
                }),
            ],
          ),
        ],
      ),
    );
  }
}
