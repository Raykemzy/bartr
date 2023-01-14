import 'dart:io';

import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/bids/domain/user_bids_model.dart';
import 'package:bartr/features/create_post/presentation/widgets/picked_image_display.dart';
import 'package:bartr/features/messages/presentation/widgets/image_display_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ChatItemBidsDetail extends HookWidget {
  const ChatItemBidsDetail({
    Key? key,
    required this.postBid,
  }) : super(key: key);

  final PostBid postBid;

  @override
  Widget build(BuildContext context) {
    ValueNotifier<List<File>> images = useState([File(postBid.itemPicture!)]);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Strings.itemImages),
          const SizedBox(
            height: 14,
          ),
          PickedImageDisplay(
            imageType: ImageType.single,
            onTap: () => _show(context, images),
            isNetwork: true,
            imageList: images,
          ),
          const SizedBox(
            height: 24,
          ),
          Text(Strings.itemName),
          const SizedBox(height: 8),
          Text(
            postBid.itemName!,
            style: Styles.w600(
              size: 16,
              color: BartrColors.black,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            Strings.desc,
            style: Styles.w400(
              size: 12,
              color: BartrColors.black,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
                color: BartrColors.greyFill,
                borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.all(20),
            child: Text(postBid.itemDescription!),
          ),
          const SizedBox(height: 25),
          const Divider(
            thickness: 2,
          ),
        ],
      ),
    );
  }

  Future<Object?> _show(BuildContext context, images) {
    return showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, anim, anim2, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(anim),
          child: child,
        );
      },
      pageBuilder: (context, anim, anim2) {
        return ImageDisplayDialog(image: images.value.first);
      },
      context: context,
    );
  }
}
