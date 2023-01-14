import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/search/presentation/notifier/search_notifier.dart';
import 'package:bartr/features/search/presentation/widgets/no_search_results.dart';
import 'package:bartr/features/search/presentation/widgets/searched_posts.dart';
import 'package:bartr/features/search/presentation/widgets/searched_users.dart';
import 'package:bartr/general_widgets/bartr_loader.dart';
import 'package:bartr/general_widgets/bartr_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widgets/recent_searches.dart';
import '../widgets/search_app_bar_title.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchNotifier);
    return BartrScaffold(
      appbar: AppBar(
        automaticallyImplyLeading: false,
        title: const SearchAppBarTitle(),
      ),
      child: (state.searchState == SearchStatus.noSearch ||
              state.searchState == SearchStatus.error)
          ? const NoSearchWidget()
          : (state.searchState == SearchStatus.loading)
              ? const BartrLoader(
                  color: BartrColors.primary,
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if ((state.recentSearchedPosts.isNotEmpty ||
                              state.recentsearchedUsers.isNotEmpty) &&
                          state.searchState == SearchStatus.idle)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, left: 16),
                              child: Text(
                                Strings.recentSearch,
                                style: Styles.w600(
                                  size: 14,
                                  color: BartrColors.black,
                                ),
                              ),
                            ),
                            RecentSearchesUsers(
                              users: state.recentsearchedUsers,
                            ),
                            SearchedPostListView(
                              posts: state.recentSearchedPosts,
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      SearchedUsersListView(
                        users: state.searchedUsers,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SearchedPostListView(
                        posts: state.searchedPosts,
                      ),
                    ],
                  ),
                ),
    );
  }
}
