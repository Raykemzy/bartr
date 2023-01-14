import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/domain/repositories/posts_repository.dart';
import 'package:bartr/domain/repositories/user_repository.dart';
import 'package:bartr/features/home/data/post_repository_impl.dart';
import 'package:bartr/features/home/domain/models/filter_post_dto.dart';
import 'package:bartr/features/home/presentation/notifier/home_state.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier(this.postsRepository, this.userRepository)
      : super(HomeState.initial());
  final PostsRepository postsRepository;
  final UserRepository userRepository;

  Future<void> fetchPosts({
    bool retry = false,
    bool loadmore = false,
    bool isSilentReload = false,
    required int page,
  }) async {
    if (retry) {
      state = state.copyWith(homeLoadState: LoadState.loading);
    }
    if (loadmore) {
      state = state.copyWith(homeLoadState: LoadState.loadmore);
    }
    try {
      final res = await postsRepository.getAllPosts(page);
      List<Post> barterPosts = res.data!.posts.where((element) {
        return element.postType == PostType.Barter;
      }).toList();
      List<Post> giveAwayPosts = res.data!.posts.where((element) {
        return element.postType == PostType.Giveaway;
      }).toList();
      if (res.status) {
        if (!loadmore) {
          state = state.copyWith(
            homeLoadState: LoadState.success,
            posts: res.data?.posts,
            barterPosts: barterPosts,
            giveAwayPosts: giveAwayPosts,
          );
        } else {
          state = state.copyWith(
            homeLoadState: LoadState.success,
            posts: [...state.posts, ...res.data!.posts],
            barterPosts: [...state.barterPosts, ...barterPosts],
            giveAwayPosts: [...state.giveAwayPosts, ...giveAwayPosts],
          );
        }
        if (!res.data!.pagination!.hasNextPage!) {
          state = state.copyWith(homeLoadState: LoadState.done);
        }
        return;
      }
      state = state.copyWith(
        homeLoadState: LoadState.error,
        errorMessage: res.error,
        giveAwayPosts: giveAwayPosts,
        barterPosts: barterPosts,
      );
    } catch (e) {
      state = state.copyWith(
          homeLoadState: LoadState.error, errorMessage: e.toString());
    }
  }

  void changeIndex(int newIndex) {
    state = state.copyWith(currentIndex: newIndex);
  }

  void resetFilter() {
    state = state.copyWith(
      filteredPostList: [],
      searchStatus: SearchStatus.idle,
    );
  }

  void filterPost(FilterPostDto data) {
    List<Post> filteredPosts = state.posts
        .where(
          (element) =>
              element.postType == data.postType &&
              element.category?.toLowerCase() == data.category.toLowerCase() &&
              element.location?.toLowerCase() == data.country.toLowerCase(),
        )
        .toList();
    if (filteredPosts.isEmpty) {
      state = state.copyWith(
        filteredPostList: [],
        searchStatus: SearchStatus.noSearch,
      );
      return;
    }
    state = state.copyWith(
      filteredPostList: filteredPosts,
      searchStatus: SearchStatus.hasSearch,
    );
  }

  Future<bool> deletePost(String postId) async {
    try {
      final res = await postsRepository.deletePost(postId);
      fetchPosts(page: 1);
      return res.status;
    } catch (e) {
      return false;
    }
  }
}

final homeNotifier = StateNotifierProvider<HomeNotifier, HomeState>(
  (_) => HomeNotifier(
    _.read(postsRepository),
    _.read(userRepository),
  ),
);
