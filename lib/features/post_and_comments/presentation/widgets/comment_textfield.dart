import 'package:bartr/core/helpers/helper_functions.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/search/domain/models/searched_users_model.dart';
import 'package:bartr/general_widgets/bartr_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/config/configure_dependencies.dart';
import '../../../home/data/post_repository_impl.dart';
import '../../../search/presentation/notifier/search_notifier.dart';
import '../../../search/presentation/notifier/search_state.dart';

class CommentTextField extends ConsumerStatefulWidget {
  const CommentTextField({
    Key? key,
    this.focus = false,
    this.isLoading = false,
    this.onTap,
    // required this.controller,
    required this.mentionKey,
    this.focusNode,
  }) : super(key: key);
  final bool focus;
  final bool isLoading;
  final void Function()? onTap;
  // final TextEditingController controller;
  final FocusNode? focusNode;
  final MentionKey mentionKey;
  @override
  ConsumerState<CommentTextField> createState() => _CommentTextFieldState();
}

class _CommentTextFieldState extends ConsumerState<CommentTextField> {
  final searchnotifier = StateNotifierProvider<SearchNotifier, SearchState>(
    (_) => SearchNotifier(
      _.read(postsRepository),
      _.read(userRepository),
      _,
    ),
  );

  late SearchNotifier _model;

  @override
  void dispose() {
    widget.mentionKey.currentState?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _model = ref.read(searchnotifier.notifier);
  }

  bool isEnabled = false;
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchnotifier);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              width: 0.6,
              color: BartrColors.lightGrey,
            ),
          ),
        ),
        child: FlutterMentions(
          textCapitalization: TextCapitalization.sentences,
          maxLines: 100,
          minLines: 1,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          autofocus: widget.focus,
          onChanged: (value) {
            setState(() {});
            isEnabled =
                widget.mentionKey.currentState?.controller?.text.isEmpty ??
                    false;
          },
          key: widget.mentionKey,
          onSearchChanged: (trigger, value) {
            _model.searchPosts('$trigger$value');
          },
          suggestionPosition: SuggestionPosition.Top,
          mentions: [
            Mention(
              trigger: "@",
              style: Styles.w700(
                color: BartrColors.primaryLight,
              ),
              data: state.searchedUsers.map((e) {
                return <String, dynamic>{
                  'display': e.username,
                  'username': e.username,
                  'fullName': e.fullName,
                  'profilePicture': e.profilePicture,
                  'fcmPushToken': e.fcmPushToken,
                  '_id': e.id,
                };
              }).toList(),
              suggestionBuilder: (json) {
                final user = SearchedUser.fromJson(json);
                return _SuggestedUserTile(user: user);
              },
            ),
          ],
          appendSpaceOnAdd: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(
              left: 40,
              top: 10,
              bottom: 10,
            ),
            filled: true,
            fillColor: BartrColors.greyFill,
            hintText: "Add comment...",
            hintStyle: Styles.w400(
              size: 14,
              color: BartrColors.deepgrey,
            ),
            disabledBorder: Helpers.replybod(30),
            labelStyle: const TextStyle(
              color: BartrColors.black,
            ),
            enabledBorder: Helpers.replybod(30),
            focusedBorder: Helpers.replybod(30),
            border: Helpers.replybod(30),
            focusedErrorBorder: Helpers.replybod(30),
            errorBorder: Helpers.replybod(30),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: widget.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: BartrLoader(
                        color: BartrColors.primary,
                      ),
                    )
                  : TextButton(
                      onPressed: isEnabled ? null : widget.onTap,
                      child: Text(Strings.addPost.split(" ")[1]),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

typedef MentionKey = GlobalKey<FlutterMentionsState>;

class _SuggestedUserTile extends StatelessWidget {
  const _SuggestedUserTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final SearchedUser user;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: BartrColors.receiverBubble,
      ),
      padding: const EdgeInsets.fromLTRB(30.0, 30, 10, 10),
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(
              user.profilePicture ?? "",
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              user.fullName ?? "",
              style: Styles.w500(
                size: 16,
                color: Colors.black,
              ),
            ),
            Text(
              "@${user.username}",
              style: Styles.w400(
                size: 12,
                color: BartrColors.grey,
              ),
            )
          ]),
        ],
      ),
    );
  }
}
