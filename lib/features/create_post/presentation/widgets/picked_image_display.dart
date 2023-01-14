import 'dart:io';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/general_widgets/cached_network_image_display.dart';
import 'package:bartr/general_widgets/select_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/enums.dart';
import '../../../../general_widgets/dotted_border.dart';

class PickedImageDisplay extends StatelessWidget {
  const PickedImageDisplay({
    Key? key,
    required this.imageList,
    this.isNetwork = false,
    this.onTap,
    required this.imageType,
  }) : super(key: key);

  final ValueNotifier<List<File>> imageList;
  final bool isNetwork;
  final void Function()? onTap;
  final ImageType imageType;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ...imageList.value
            .asMap()
            .entries
            .map(
              (aFile) => Stack(
                clipBehavior: Clip.none,
                children: [
                  isNetwork
                      ? InkWell(
                          onTap: onTap,
                          child: CachedNetworkDisplay(
                            url: aFile.value.path,
                            radius: 5,
                            height: 116,
                            width: 109,
                            fit: BoxFit.cover,
                          ),
                        )
                      : InkWell(
                          onTap: onTap,
                          child: Container(
                            height: 84,
                            width: 84,
                            clipBehavior: Clip.antiAlias,
                            margin: const EdgeInsets.only(
                                right: 40, bottom: 15, top: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Image.file(
                              aFile.value,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  if (!isNetwork)
                    Positioned(
                      top: -1,
                      right: 35,
                      child: InkWell(
                        onTap: () {
                          List<File> newList = [];
                          newList = imageList.value;
                          imageList.value = [];
                          newList.removeAt(aFile.key);
                          imageList.value = newList;
                        },
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: BartrColors.greyFill,
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 17,
                          ),
                        ),
                      ),
                    )
                ],
              ),
            )
            .toList(),
        if (imageList.value.length < 6 &&
            !isNetwork &&
            imageType == ImageType.multi)
          InkWell(
            onTap: () => SelectImage.chooseImage(
              context: context,
              imageType: "Select Image",
              imageList: imageList,
              type: imageType,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DotBorder(
                borderType: BorderType.rRect,
                radius: const Radius.circular(10),
                dashPattern: const [15],
                strokeCap: StrokeCap.round,
                color: BartrColors.lightGrey,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  height: 84,
                  width: 84,
                  decoration: const BoxDecoration(
                    color: BartrColors.greyFill,
                  ),
                  child: SvgPicture.asset("assets/icons/gallery-add.svg"),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
