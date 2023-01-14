import 'package:bartr/features/search/domain/models/searched_users_model.dart';
import 'package:bartr/general_widgets/cached_network_image_display.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/textstyles.dart';

class SearchedUserTile extends StatelessWidget {
  const SearchedUserTile({
    required this.user,
    required this.onTap,
    super.key,
  });
  final void Function()? onTap;
  final SearchedUser user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CachedNetworkDisplay(
        memCacheHeight: 150,
        memCacheWidth: 150,
        height: 40,
        width: 40,
        url: user.profilePicture ?? "",
        // "https://media.istockphoto.com/photos/professional-mechanic-working-on-the-engine-of-the-car-in-the-garage-picture-id1409304203",
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user.fullName ?? "",
            style: Styles.w500(
              size: 16,
              color: Colors.black,
            ),
          ),
          Text(
            "@${user.username}",
            style: Styles.w400(
              size: 12,
              color: BartrColors.grey,
            ),
          )
        ],
      ),
    );
  }
}
