import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/features/home/data/post_repository_impl.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:bartr/features/search/domain/models/searched_users_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchState {
  final SearchStatus searchState;
  final List<Post> searchedPosts;
  final List<Post> recentSearchedPosts;
  final List<SearchedUser> searchedUsers;
  final List<SearchedUser> recentsearchedUsers;

  SearchState({
    required this.searchState,
    required this.searchedPosts,
    required this.searchedUsers,
    required this.recentSearchedPosts,
    required this.recentsearchedUsers,
  });

  factory SearchState.initial(Ref ref) {
    return SearchState(
      searchState: SearchStatus.idle,
      searchedPosts: [],
      searchedUsers: [],
      recentSearchedPosts:
          ref.read(postsRepository).getSearchedPostsLocally().reversed.toList(),
      recentsearchedUsers:
          ref.read(postsRepository).getSearchedUsersLocally().reversed.toList(),
    );
  }

  SearchState copyWith({
    SearchStatus? searchState,
    List<Post>? searchedPosts,
    List<Post>? recentSearchedPosts,
    List<SearchedUser>? searchedUsers,
    List<SearchedUser>? recentsearchedUsers,
  }) {
    return SearchState(
      searchState: searchState ?? this.searchState,
      searchedPosts: searchedPosts ?? this.searchedPosts,
      searchedUsers: searchedUsers ?? this.searchedUsers,
      recentSearchedPosts: recentSearchedPosts ?? this.recentSearchedPosts,
      recentsearchedUsers: recentsearchedUsers ?? this.recentsearchedUsers,
    );
  }
}
