import 'dart:io';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/helpers/helper_functions.dart';
import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/profile/presentation/notifier/profile_notifier.dart';
import 'package:bartr/general_widgets/bartr_loader.dart';
import 'package:bartr/general_widgets/cached_network_image_display.dart';
import 'package:bartr/general_widgets/select_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../login/domain/models/login_model.dart';

class ProfileCoverPhoto extends HookConsumerWidget {
  const ProfileCoverPhoto({
    Key? key,
    required this.maxExtent,
    required this.progress,
    required this.user,
    required this.shrinkOffset,
    required this.currentUser,
  }) : super(key: key);

  final double progress, shrinkOffset, maxExtent;
  final BartrUser user, currentUser;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ValueNotifier<List<File>> images = useState([]);
    return InkWell(
      onTap: () {
        _uploadCoverPhoto(context, images, ref);
      },
      child: AnimatedContainer(
        curve: Curves.bounceInOut,
        decoration: BoxDecoration(
          color: BartrColors.white,
          borderRadius: BorderRadius.lerp(
            BorderRadius.circular(20),
            BorderRadius.zero,
            progress,
          ),
        ),
        duration: const Duration(milliseconds: 150),
        height: maxExtent * 0.65,
        width: double.infinity,
        margin: EdgeInsets.lerp(
          const EdgeInsets.symmetric(horizontal: 5),
          const EdgeInsets.symmetric(horizontal: 0),
          progress,
        ),
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(
            tileMode: TileMode.clamp,
            sigmaX: shrinkOffset > (maxExtent.toInt() * 0.1) ? 50.0 : 0.0,
            sigmaY: shrinkOffset > (maxExtent.toInt() * 0.9) ? .0 : 0.0,
          ),
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              (ref.watch(profileNotifier).coverPhotoLoadState ==
                          LoadState.loading &&
                      user.id == currentUser.id)
                  ? const BartrLoader(
                      color: BartrColors.primary,
                    )
                  : (user.coverPhoto == null || user.coverPhoto!.isEmpty)
                      ? ClipRRect(
                          borderRadius: BorderRadius.lerp(
                            BorderRadius.circular(20),
                            BorderRadius.zero,
                            progress,
                          ),
                          child: Image.asset(
                            "assets/images/bartrcover.png",
                            fit: BoxFit.cover,
                          ),
                        )
                      : CachedNetworkDisplay(
                          isProfile: true,
                          url: user.coverPhoto!,
                          radius:
                              shrinkOffset > (maxExtent.toInt() * 0.9) ? 0 : 20,
                        ),
              GestureDetector(
                onTap: () => context.router.push(const EditProfileRoute()),
                child: Visibility(
                  visible: (currentUser.id! == user.id) && (progress < 0.3),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: const EdgeInsets.only(right: 16, bottom: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: BartrColors.primary,
                        border: Border.all(color: BartrColors.purple),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "Edit Profile",
                        style: Styles.w400(
                          color: BartrColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _uploadCoverPhoto(
      BuildContext context, ValueNotifier<List<File>> images, WidgetRef ref) {
    if (user.id == currentUser.id) {
      SelectImage.chooseImage(
        context: context,
        imageType: "Change cover photo",
        imageList: images,
        type: ImageType.single,
      ).then(
        (value) {
          if (images.value.isNotEmpty) {
            ref
                .read(profileNotifier.notifier)
                .changeCoverPhoto(
                  coverPhoto: images.value.first,
                  username: currentUser.username!,
                )
                .then(
              (value) {
                if (value) {
                  showSuccess(text: "Cover photo updated", context: context);
                  images.value.clear();
                } else {
                  showError(
                    text: "Could not update cover photo",
                    context: context,
                  );
                }
              },
            );
          }
        },
      );
    }
  }
}
