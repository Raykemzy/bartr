import 'dart:io';

import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/config/exception/logger.dart';
import 'package:bartr/core/config/response/base_response.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/domain/repositories/posts_repository.dart';
import 'package:bartr/features/home/data/post_repository_impl.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:bartr/features/profile/domain/dtos/change_password_dto.dart';
import 'package:bartr/features/profile/domain/dtos/edit_profile_dto.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../domain/repositories/user_repository.dart';
import 'profile_state.dart';

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier(this.postsRepository, this.userRepository)
      : super(ProfileState.initial());
  final PostsRepository postsRepository;
  final UserRepository userRepository;

  Future<void> fetchUserPosts({
    bool retry = false,
    bool loadmore = false,
    required String userId,
    required int page,
  }) async {
    if (retry) {
      state = state.copyWith(postLoadState: LoadState.loading);
    }
    if (loadmore) {
      state = state.copyWith(postLoadState: LoadState.loadmore);
    }
    try {
      final res =
          await postsRepository.getUserPosts(userId: userId, page: page);
      List<Post> barterPosts = res.data!.posts.where((element) {
        return element.postType == PostType.Barter;
      }).toList();
      List<Post> giveAwayPosts = res.data!.posts.where((element) {
        return element.postType == PostType.Giveaway;
      }).toList();

      if (!loadmore) {
        state = state.copyWith(
          postLoadState: res.status ? LoadState.success : LoadState.error,
          posts: res.data?.posts,
          barterPosts: barterPosts,
          giveAwayPosts: giveAwayPosts,
        );
      } else {
        state = state.copyWith(
          postLoadState: res.status ? LoadState.success : LoadState.error,
          posts: [...state.posts, ...res.data!.posts],
          barterPosts: [...state.barterPosts, ...barterPosts],
          giveAwayPosts: [...state.giveAwayPosts, ...giveAwayPosts],
        );
      }
      if (!res.data!.pagination!.hasNextPage!) {
        state = state.copyWith(postLoadState: LoadState.done);
      }
    } catch (e) {
      state = state.copyWith(postLoadState: LoadState.error);
    }
  }

  Future<void> getUserProfile({
    bool retry = false,
    required String username,
  }) async {
    if (retry) {
      state = state.copyWith(profileLoadState: LoadState.loading);
    }
    try {
      final res = await userRepository.getUserProfile(username);
      if (res.status) {
        _saveUser(res);
        state = state.copyWith(
          profileLoadState: LoadState.success,
          bartrUser: res.data,
          followers: res.data!.followers,
          following: res.data!.following,
        );
        return;
      }
      state = state.copyWith(
        profileLoadState: LoadState.error,
        errorMessage: res.error,
      );
      return;
    } catch (e) {
      state = state.copyWith(profileLoadState: LoadState.error);
    }
  }

  void _saveUser(BaseResponse<BartrUser> res) {
    final user = userRepository.getUser();
    if (res.data!.id! == user.id) {
      final newUser = res.data!;
      userRepository.setCurrentUser(
        user.copyWith(
          profilePicture: newUser.profilePicture,
          fullName: newUser.fullName,
          followers: newUser.followers,
          following: newUser.following,
          country: newUser.country,
          coverPhoto: newUser.coverPhoto,
          username: newUser.username,
          createdAt: newUser.createdAt,
          email: newUser.email,
          verified: newUser.verified,
        ),
      );
    }
  }

  Future<bool> changeCoverPhoto({
    required File coverPhoto,
    required String username,
  }) async {
    state = state.copyWith(coverPhotoLoadState: LoadState.loading);
    try {
      final res = await userRepository.changeCoverPhoto(coverPhoto);
      if (res.status) {
        getUserProfile(username: username);
        state = state.copyWith(coverPhotoLoadState: LoadState.success);
        return true;
      }
      state = state.copyWith(coverPhotoLoadState: LoadState.error);
      return false;
    } catch (e) {
      state = state.copyWith(coverPhotoLoadState: LoadState.error);
      rethrow;
    }
  }

  void editProfile(EditProfileDto data) async {
    state = state.copyWith(editProfileLoadState: LoadState.loading);
    try {
      final res = await userRepository.editProfile(data);
      if (res.status) {
        state = state.copyWith(
          editProfileLoadState: LoadState.success,
          successMessage: res.message,
        );
        state = state.copyWith(editProfileLoadState: LoadState.idle);
        return;
      }
      state = state.copyWith(
          editProfileLoadState: LoadState.error, successMessage: res.error);
      state = state.copyWith(editProfileLoadState: LoadState.idle);
    } catch (e) {
      state = state.copyWith(editProfileLoadState: LoadState.error);
      state = state.copyWith(editProfileLoadState: LoadState.idle);
    }
  }

  void changeIndex(int newIndex) {
    state = state.copyWith(currentIndex: newIndex);
  }

  Future<bool> followOrUnfollow(String userId) async {
    try {
      final response = await userRepository.followOrUnfollowUser(userId);
      if (response.status) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  void deleteAccount(String password) async {
    final oldpassword = userRepository.getUser().password;
    state = state.copyWith(deleteAccountState: LoadState.loading);
    try {
      if (oldpassword == password) {
        final res = await userRepository.deleteUser();
        if (res.status) {
          state = state.copyWith(deleteAccountState: LoadState.success);
          return;
        }
        state = state.copyWith(
            deleteAccountState: LoadState.error, successMessage: res.error);
      } else {
        state = state.copyWith(
          deleteAccountState: LoadState.error,
          successMessage: "Invalid password",
        );
      }
    } catch (e) {
      debugLog(e);
    }
  }

  void changePassword(ChangePasswordDto data) async {
    state = state.copyWith(changePasswordState: LoadState.loading);
    try {
      final res = await userRepository.changePassword(data);
      if (res.status) {
        state = state.copyWith(changePasswordState: LoadState.success);
        state = state.copyWith(changePasswordState: LoadState.idle);
        return;
      }
      state = state.copyWith(
        changePasswordState: LoadState.error,
        successMessage: res.error,
      );
      state = state.copyWith(changePasswordState: LoadState.idle);
    } catch (e) {
      debugLog(e);
      state.copyWith(
        changePasswordState: LoadState.error,
        successMessage: e.toString(),
      );
    }
  }

  Future<bool> deletePost(String postId) async {
    try {
      final res = await postsRepository.deletePost(postId);
      fetchUserPosts(userId: state.bartrUser?.username ?? "", page: 1);
      return res.status;
    } catch (e) {
      return false;
    }
  }
}

final profileNotifier =
    StateNotifierProvider.autoDispose<ProfileNotifier, ProfileState>(
  (_) => ProfileNotifier(
    _.read(postsRepository),
    _.read(userRepository),
  ),
);
