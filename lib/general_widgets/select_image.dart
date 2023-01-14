import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/general_widgets/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../core/services/thirdparty_services/image_picker_service.dart';

class SelectImage {
  static Future<void> chooseImage({
    required BuildContext context,
    required String imageType,
    required ValueNotifier<List<File>> imageList,
    required ImageType type,
  }) async {
    return showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      backgroundColor: BartrColors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      builder: (context) => Select(
        imageList: imageList,
        type: type,
      ),
    );
  }
}

class Select extends HookConsumerWidget {
  const Select({
    Key? key,
    required this.imageList,
    required this.type,
  }) : super(key: key);

  final ValueNotifier<List<File>> imageList;
  final ImageType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final picker = ref.read(imagePickerService);
    void pickImage(BartrImagePicker picker, ImageSource source) async {
      if (type == ImageType.single) {
        picker.pickImage(source: source, images: imageList).then((value) {
          context.router.pop();
        });
      } else {
        picker.pickMultiImage(source: source, images: imageList).then((value) {
          context.router.pop();
        });
      }
    }

    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${Strings.select}Image",
                style: Styles.w400(
                  size: 14,
                  color: BartrColors.white,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                Strings.selectImage,
                style: Styles.w400(
                  size: 12,
                  color: BartrColors.grey,
                ),
              ),
              const SizedBox(height: 19),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      DotBorder(
                        color: BartrColors.grey,
                        borderType: BorderType.circle,
                        strokeWidth: 1,
                        dashPattern: const [16, 10],
                        padding: const EdgeInsets.all(6.0),
                        child: GestureDetector(
                          onTap: () => pickImage(picker, ImageSource.camera),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: BartrColors.grey,
                            child: Image.asset(
                              "assets/images/cam.png",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        Strings.camera,
                        style: Styles.w400(
                          size: 14,
                          color: BartrColors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      DotBorder(
                        color: BartrColors.grey,
                        borderType: BorderType.circle,
                        strokeWidth: 1,
                        dashPattern: const [16, 10],
                        padding: const EdgeInsets.all(6.0),
                        child: GestureDetector(
                          onTap: () => pickImage(picker, ImageSource.gallery),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: BartrColors.grey,
                            child: Image.asset(
                              "assets/images/gallery.png",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        Strings.gallery,
                        style: Styles.w400(
                          size: 14,
                          color: BartrColors.white,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
