import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/config/exception/logger.dart';
import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/messages/presentation/notifer/chat_list_notifier.dart';
import 'package:bartr/features/messages/presentation/widgets/message_tile.dart';
import 'package:bartr/general_widgets/bartr_loader.dart';
import 'package:bartr/general_widgets/retry_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/models/conversation_model.dart';

class MessagesScreen extends StatefulHookConsumerWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends ConsumerState<MessagesScreen>
    with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.read(chatListProvider.notifier).fetchConversations();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    // ref.read(chatListProvider.notifier).fetchConversations();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      ref.read(chatListProvider.notifier).fetchConversations();
      return null;
    }, const []);
    final r = ref.watch(chatListProvider);
    r.conversations.removeWhere((element) => element.members.length < 2);
    final currentUser = ref.watch(currentUserProvider);
    return RefreshIndicator(
      onRefresh: () {
        return ref.read(chatListProvider.notifier).fetchConversations();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            Strings.messages,
            style: Styles.w500(
              size: 18,
              color: BartrColors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: (r.messageLoadState == LoadState.loading)
              ? const BartrLoader(
                  color: BartrColors.primary,
                )
              : (r.messageLoadState == LoadState.error)
                  ? RetryWidget(
                      onRetry: () => ref
                          .read(chatListProvider.notifier)
                          .fetchConversations(),
                    )
                  : (r.conversations.isEmpty)
                      ? const EmptyMessage()
                      : ListView.builder(
                          reverse: true,
                          padding: const EdgeInsets.only(top: 20.0),
                          shrinkWrap: true,
                          itemCount: r.conversations.length,
                          itemBuilder: (ctx, index) {
                            List<Member> members =
                                r.conversations[index].members;

                            var otherUser = members.firstWhere(
                                (element) => element.id != currentUser.id);
                            debugLog(otherUser);
                            return MessageTile(
                              user: otherUser,
                              chatId: r.conversations[index].id,
                              onTap: () => context.router.push(
                                ChatPageRoute(
                                  chatRoomId: r.conversations[index].id,
                                  user: otherUser,
                                ),
                              ),
                            );
                          },
                        ),
        ),
      ),
    );
  }
}

class EmptyMessage extends StatelessWidget {
  const EmptyMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/messageicon.png",
            width: 100,
          ),
          const SizedBox(height: 20.0),
          Text(
            Strings.noMessages,
            style: Styles.w500(
              size: 16,
              color: BartrColors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
