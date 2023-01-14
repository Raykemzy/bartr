import 'dart:io';

import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/create_post/presentation/widgets/picked_image_display.dart';
import 'package:bartr/general_widgets/dotted_border.dart';
import 'package:bartr/general_widgets/select_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/colors.dart';

class IDImagePicker extends ConsumerWidget {
  const IDImagePicker({Key? key, required this.images, this.max = 1})
      : super(key: key);
  final ValueNotifier<List<File>> images;
  final int max;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Strings.uploadMeansofID),
        const SizedBox(height: 16),
        if (images.value.isEmpty)
          InkWell(
            onTap: () => SelectImage.chooseImage(
              context: context,
              imageType: "Select Image",
              imageList: images,
              type: ImageType.single,
            ),
            child: DotBorder(
              borderType: BorderType.rRect,
              radius: const Radius.circular(10),
              dashPattern: const [15],
              strokeCap: StrokeCap.round,
              color: BartrColors.lightGrey,
              child: Container(
                padding: const EdgeInsets.only(left: 15),
                height: 64,
                decoration: const BoxDecoration(
                  color: BartrColors.greyFill,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/gallery-add.svg"),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Upload ID",
                          style: Styles.w700(
                            size: 14,
                            color: BartrColors.black,
                          ),
                        ),
                        Text(
                          "JPEG, PNG",
                          style: Styles.w400(
                            size: 10,
                            color: BartrColors.deepgrey,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        if (images.value.isNotEmpty)
          PickedImageDisplay(
            imageType: ImageType.single,
            imageList: images,
          ),
      ],
    );
  }
}
