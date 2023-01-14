import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/features/post_and_comments/domain/models/single_post_model.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';

class HomeState {
  final LoadState homeLoadState;
  final LoadState postLoadState;
  final SearchStatus searchStatus;
  final List<Post> posts;
  final List<Post> filteredPostList;
  final List<Post> barterPosts;
  final List<Post> giveAwayPosts;
  final SinglePost? currentPost;
  final int currentIndex;
  final String? errorMessage;

  HomeState({
    required this.searchStatus,
    required this.homeLoadState,
    required this.postLoadState,
    required this.posts,
    required this.barterPosts,
    required this.giveAwayPosts,
    required this.currentIndex,
    this.currentPost,
    required this.filteredPostList,
    this.errorMessage,
  });

  factory HomeState.initial() {
    return HomeState(
      homeLoadState: LoadState.loading,
      postLoadState: LoadState.loading,
      posts: [],
      barterPosts: [],
      giveAwayPosts: [],
      currentIndex: 0,
      currentPost: null,
      filteredPostList: [],
      searchStatus: SearchStatus.idle,
    );
  }

  HomeState copyWith({
    LoadState? homeLoadState,
    LoadState? postLoadState,
    List<Post>? posts,
    List<Post>? barterPosts,
    List<Post>? giveAwayPosts,
    int? currentIndex,
    SinglePost? currentPost,
    List<Post>? filteredPostList,
    SearchStatus? searchStatus,
    String? errorMessage,
  }) {
    return HomeState(
      homeLoadState: homeLoadState ?? this.homeLoadState,
      posts: posts ?? this.posts,
      barterPosts: barterPosts ?? this.barterPosts,
      giveAwayPosts: giveAwayPosts ?? this.giveAwayPosts,
      currentIndex: currentIndex ?? this.currentIndex,
      currentPost: currentPost ?? this.currentPost,
      postLoadState: postLoadState ?? this.postLoadState,
      filteredPostList: filteredPostList ?? this.filteredPostList,
      searchStatus: searchStatus ?? this.searchStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
