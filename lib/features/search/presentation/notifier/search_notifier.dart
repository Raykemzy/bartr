// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/domain/repositories/user_repository.dart';
import 'package:bartr/features/home/data/post_repository_impl.dart';
import 'package:bartr/features/search/presentation/notifier/search_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/domain/repositories/posts_repository.dart';

import '../../../login/domain/models/login_model.dart';
import '../../domain/models/searched_users_model.dart';

class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier(
    this.postsRepository,
    this.userRepository,
    this.ref,
  ) : super(SearchState.initial(ref));
  final PostsRepository postsRepository;
  final UserRepository userRepository;
  final Ref ref;
  Future<void> searchPosts(String query) async {
    try {
      if (!query.startsWith("@")) {
        state = state.copyWith(searchState: SearchStatus.loading);
        final response = await postsRepository.searchPosts(query);
        if (response.status) {
          state = state.copyWith(
              searchState: response.data!.isEmpty
                  ? SearchStatus.noSearch
                  : SearchStatus.hasSearch,
              searchedPosts: response.data,
              searchedUsers: []);
          return;
        }
        state = state.copyWith(searchState: SearchStatus.error);
      } else {
        String username = query.substring(1);
        if (username.isEmpty) {
          return;
        }
        state = state.copyWith(searchState: SearchStatus.loading);
        final response = await userRepository.searchUsers(username);
        if (response.status) {
          state = state.copyWith(
            searchState: response.data!.isEmpty
                ? SearchStatus.noSearch
                : SearchStatus.hasSearch,
            searchedUsers: response.data,
            searchedPosts: [],
          );
          return;
        }
        state = state.copyWith(searchState: SearchStatus.error);
      }
    } catch (e) {
      state = state.copyWith(searchState: SearchStatus.error);
      rethrow;
    }
  }

  void saveClickedPost(Post post) async {
    var posts = postsRepository.getSearchedPostsLocally();
    bool contains = posts.any((element) => element.id == post.id);
    if (contains) {
      return;
    }
    if (posts.length < 4) {
      posts.add(post);
      postsRepository.saveSearchedPostsLocally(posts);
    } else {
      posts.removeAt(0);
      posts.add(post);
      postsRepository.saveSearchedPostsLocally(posts);
    }
  }

  void saveClickedUser(SearchedUser user) async {
    var users = postsRepository.getSearchedUsersLocally();
    bool contains = users.any((element) => element.id == user.id);
    if (contains) {
      return;
    }
    if (users.length < 10) {
      users.add(user);
      postsRepository.saveSearchedUsersLocally(users);
    } else {
      users.removeAt(0);
      users.add(user);
      postsRepository.saveSearchedUsersLocally(users);
    }
  }

  void clearSearch() {
    state = state.copyWith(
      searchState: SearchStatus.idle,
      searchedPosts: [],
      searchedUsers: [],
    );
  }
}

final searchNotifier = StateNotifierProvider<SearchNotifier, SearchState>(
  (_) => SearchNotifier(
    _.read(postsRepository),
    _.read(userRepository),
    _,
  ),
);
