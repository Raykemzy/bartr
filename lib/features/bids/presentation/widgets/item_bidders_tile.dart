import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/general_widgets/cached_network_image_display.dart';
import 'package:flutter/material.dart';
import 'package:timeago_flutter/timeago_flutter.dart' as timeago;

class ItemBidderTile extends StatelessWidget {
  final String imageUrl, fullName;
  final String desc;
  final DateTime timeAgo;
  final VoidCallback onTap;
  const ItemBidderTile({
    Key? key,
    required this.imageUrl,
    required this.fullName,
    required this.desc,
    required this.timeAgo,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 10) +
            const EdgeInsets.symmetric(horizontal: 17.0),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CachedNetworkDisplay(
                url: imageUrl,
                width: 40,
                height: 40,
                radius: 70,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.35,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          fullName,
                          style: Styles.w600(
                            size: 16,
                            color: BartrColors.black,
                          ),
                        ),
                        Text(
                          timeago.format(timeAgo, locale: 'en_short'),
                          style: Styles.w600(
                            size: 12,
                            color: BartrColors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      desc,
                      style: Styles.w400(
                        size: 12,
                        color: BartrColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
