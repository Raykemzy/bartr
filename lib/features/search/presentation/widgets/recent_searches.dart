import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/router/routes.dart';
import 'package:bartr/general_widgets/cached_network_image_display.dart';
import 'package:flutter/material.dart';

import '../../domain/models/searched_users_model.dart';

class RecentSearchesUsers extends StatelessWidget {
  const RecentSearchesUsers({Key? key, required this.users}) : super(key: key);
  final List<SearchedUser> users;

  @override
  Widget build(BuildContext context) {
    return users.isEmpty
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 120,
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 16),
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                scrollDirection: Axis.horizontal,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  SearchedUser user = users[index];
                  return SizedBox(
                    width: 70,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => context.router.push(
                            OtherUserProfileRoute(
                              userId: user.id!,
                              username: user.username!,
                            ),
                          ),
                          child: CachedNetworkDisplay(
                            height: 64,
                            width: 64,
                            radius: 70,
                            url: user.profilePicture!,
                            memCacheHeight: 150,
                            memCacheWidth: 150,
                          ),
                        ),
                        Text(
                          user.username!,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          );
  }
}
