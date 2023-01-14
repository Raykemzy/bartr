import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';

class ProfileState {
  final LoadState profileLoadState;
  final LoadState editProfileLoadState;
  final LoadState postLoadState;
  final LoadState coverPhotoLoadState;
  final LoadState deleteAccountState;
  final LoadState changePasswordState;
  final List<Post> posts;
  final List<Post> barterPosts;
  final List<Post> giveAwayPosts;
  final List<Follow> followers;
  final List<Follow> following;
  final BartrUser? bartrUser;
  final int currentIndex;
  final String? successMessage;
   final String? errorMessage;

  ProfileState({
    required this.changePasswordState,
    required this.deleteAccountState,
    required this.profileLoadState,
    required this.editProfileLoadState,
    required this.coverPhotoLoadState,
    required this.postLoadState,
    required this.posts,
    required this.barterPosts,
    required this.giveAwayPosts,
    required this.followers,
    required this.following,
    required this.currentIndex,
    this.bartrUser,
    this.successMessage,
    this.errorMessage,
  });

  factory ProfileState.initial() {
    return ProfileState(
      editProfileLoadState: LoadState.idle,
      profileLoadState: LoadState.loading,
      postLoadState: LoadState.loading,
      coverPhotoLoadState: LoadState.idle,
      deleteAccountState: LoadState.idle,
      changePasswordState: LoadState.idle,
      posts: [],
      barterPosts: [],
      giveAwayPosts: [],
      followers: [],
      following: [],
      currentIndex: 0,
      bartrUser: null,
    );
  }

  ProfileState copyWith({
    LoadState? profileLoadState,
    LoadState? postLoadState,
    LoadState? coverPhotoLoadState,
    List<Post>? posts,
    List<Post>? barterPosts,
    List<Post>? giveAwayPosts,
    List<Follow>? followers,
    List<Follow>? following,
    int? currentIndex,
    BartrUser? bartrUser,
    LoadState? editProfileLoadState,
    String? successMessage,
    LoadState? deleteAccountState,
    LoadState? changePasswordState,
      String? errorMessage,
  }) {
    return ProfileState(
      editProfileLoadState: editProfileLoadState ?? this.editProfileLoadState,
      profileLoadState: profileLoadState ?? this.profileLoadState,
      posts: posts ?? this.posts,
      barterPosts: barterPosts ?? this.barterPosts,
      giveAwayPosts: giveAwayPosts ?? this.giveAwayPosts,
      currentIndex: currentIndex ?? this.currentIndex,
      bartrUser: bartrUser ?? this.bartrUser,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      postLoadState: postLoadState ?? this.postLoadState,
      successMessage: successMessage ?? this.successMessage,
      coverPhotoLoadState: coverPhotoLoadState ?? this.coverPhotoLoadState,
      deleteAccountState: deleteAccountState ?? this.deleteAccountState,
      changePasswordState: changePasswordState ?? this.changePasswordState,
      errorMessage:  errorMessage ?? this.errorMessage,
    );
  }
}
