import 'package:auto_route/auto_route.dart';
import 'package:bartr/features/search/presentation/widgets/searched_user_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/config/configure_dependencies.dart';
import '../../../../core/router/router.dart';
import '../../../home/data/post_repository_impl.dart';
import '../../../profile/presentation/notifier/profile_notifier.dart';
import '../../../profile/presentation/notifier/profile_state.dart';
import '../../domain/models/searched_users_model.dart';
import '../notifier/search_notifier.dart';

class SearchedUsersListView extends ConsumerWidget {
  SearchedUsersListView({
    Key? key,
    required this.users,
  }) : super(key: key);
  final List<SearchedUser> users;

  final userProfilefromHomeNotifier =
      StateNotifierProvider.autoDispose<ProfileNotifier, ProfileState>(
    (_) => ProfileNotifier(
      _.read(postsRepository),
      _.read(userRepository),
    ),
  );
  _navigate(SearchedUser user, BuildContext context, WidgetRef ref) {
    context.router.push(
      OtherUserProfileRoute(
        userId: user.id!,
        username: user.username!,
      ),
    );
    ref.read(searchNotifier.notifier).saveClickedUser(user);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      // padding: const EdgeInsets.only(top: 20),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var user = users[index];
        return SearchedUserTile(
          user: user,
          onTap: () => _navigate(user, context, ref),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 5,
        );
      },
      itemCount: users.length,
    );
  }
}
