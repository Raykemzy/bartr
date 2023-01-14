import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:bartr/features/profile/presentation/widgets/followers_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FollowersLists extends ConsumerWidget {
  final bool loadState;
  final ScrollController controller;
  final List<Follow> followers;
  const FollowersLists({
    Key? key,
    required this.controller,
    required this.loadState,
    required this.followers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentuser = ref.watch(currentUserProvider);
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: followers.length,
      itemBuilder: (context, index) {
        final user = followers[index];
        return FollowTile(
          user: user,
          currentUser: currentuser,
        );
      },
    );
  }
}
