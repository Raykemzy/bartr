import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/helpers/helper_functions.dart';
import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/bids/domain/bid_with_conversation.dart';
import 'package:bartr/features/bids/domain/user_bids_model.dart';
import 'package:bartr/features/bids/presentation/notifier/bids_notifier.dart';
import 'package:bartr/features/bids/presentation/notifier/post_bids_notifier.dart';
import 'package:bartr/features/bids/presentation/widgets/no_bids.dart';
import 'package:bartr/features/messages/data/conversation_repositpry_impl.dart';
import 'package:bartr/features/messages/domain/dtos/conversation_dto.dart';
import 'package:bartr/features/messages/domain/models/conversation_model.dart';
import 'package:bartr/features/messages/presentation/widgets/message_tile.dart';
import 'package:bartr/general_widgets/bartr_loader.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ItemBidsPage extends ConsumerStatefulWidget {
  @PathParam()
  final String postId;
  const ItemBidsPage({Key? key, required this.postId}) : super(key: key);

  @override
  ConsumerState<ItemBidsPage> createState() => _ItemBidsPageState();
}

class _ItemBidsPageState extends ConsumerState<ItemBidsPage> {
  @override
  void initState() {
    ref.read(postbidsNotifier.notifier).fetchPostBids(postId: widget.postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(postbidsNotifier);
    final model = ref.read(bidsNotifier.notifier);
    final user = ref.watch(currentUserProvider);
    List<BidWithConversation> bidswithConvos =
        ref.read(conversationRepository).fetchBidsWithConversations();
    return RefreshIndicator(
      onRefresh: () => ref.read(postbidsNotifier.notifier).fetchPostBids(
            postId: widget.postId,
          ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: InkWell(
            onTap: () => context.router.pop(),
            child: Image.asset(
              "assets/images/backarrow.png",
              scale: 4,
            ),
          ),
          title: Text(
            Strings.bidsOnItem,
            style: Styles.w500(
              size: 16,
              color: BartrColors.black,
            ),
          ),
          // actions: [
          //   InkWell(
          //     onTap: () {},
          //     child: Image.asset(
          //       "assets/images/menu.png",
          //       scale: 4,
          //     ),
          //   ),
          // ],
        ),
        body: state.postBidsLoadState == LoadState.loading
            ? const BartrLoader(
                size: 80,
                color: BartrColors.primary,
              )
            : (state.postBidsLoadState == LoadState.success &&
                    state.postBids.isEmpty)
                ? const NoBids()
                : Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListView.builder(
                      padding:
                          const EdgeInsets.only(top: 10, left: 17, right: 17),
                      itemCount: state.postBids.length,
                      itemBuilder: (ctx, i) {
                        final r = state.postBids[i];
                        final member = Member(
                            id: r.user!.id!,
                            fullName: r.user!.fullName!,
                            username: r.user!.username!,
                            profilePicture: r.user!.profilePicture!,
                            fcmPushToken: r.user!.fcmPushToken ?? "");

                        return MessageTile(
                          chatId: (bidswithConvos
                              .firstWhere(
                                (element) => element.otherUID == r.user!.id!,
                                orElse: () => BidWithConversation(
                                    otherUID: "",
                                    conversationId: "",
                                    currentUID: ""),
                              )
                              .conversationId),
                          user: member,
                          onTap: () => _createConversation(
                            model: model,
                            currentUserId: user.id!,
                            otherUserId: r.user!.id!,
                            r: r,
                          ),
                        );
                      },
                    ),
                  ),
      ),
    );
  }

  _createConversation({
    required BidsNotifier model,
    required String currentUserId,
    required String otherUserId,
    required PostBid r,
  }) {
    final data = ConversationDto(userOne: currentUserId, userTwo: otherUserId);
    model
        .createConversation(
      data: data,
      currentUID: currentUserId,
      otherUID: otherUserId,
    )
        .then(
      (value) {
        if (value != null) {
          final member = Member(
            id: r.user!.id!,
            fullName: r.user!.fullName!,
            username: r.user!.username!,
            profilePicture: r.user!.profilePicture!,
            fcmPushToken: r.user!.fcmPushToken ?? "",
          );
          context.router.push(
            ChatPageRoute(
              user: member,
              chatRoomId: value,
              postBid: r,
            ),
          );
        } else {
          showError(text: Strings.couldntStartConvo, context: context);
        }
      },
    );
  }
}
