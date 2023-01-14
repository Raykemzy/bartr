import 'package:bartr/core/helpers/extensions.dart';
import 'package:bartr/core/helpers/helper_functions.dart';
import 'package:bartr/core/helpers/mixins.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:linkfy_text/linkfy_text.dart';
import '../../domain/models/single_post_model.dart';
import 'package:timeago_flutter/timeago_flutter.dart' as timeago;

class CommentBody extends StatelessWidget with NavigationMixin {
  const CommentBody({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final SinglePostComment? comment;

  @override
  Widget build(BuildContext context) {
    final width = Helpers.width(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "@${comment!.user!.username ?? ""}",
          style: Styles.w500(
            size: 14,
            color: BartrColors.black,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: width * 0.6,
          child: LinkifyText(
            comment!.commentText ?? "",
            textStyle: Styles.w400(
              size: 14,
              color: BartrColors.black,
            ),
            linkStyle: Styles.w600(
              size: 14,
              color: BartrColors.primaryLight,
            ),
            linkTypes: const [
              LinkType.userTag,
            ],
            onTap: (link) {
              navigateToProfile(
                context: context,
                userId: link.value!.removeTag(),
                username: link.value!.removeTag(),
              );
            },
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Text(
              timeago.format(comment!.createdAt!),
              style: Styles.w400(
                size: 12,
                color: BartrColors.black,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(width: 16),
            // InkWell(
            //   onTap: () => FocusManager.instance.primaryFocus!.requestFocus(),
            //   child: Text(
            //     "Reply",
            //     style: Styles.w700(
            //       size: 10,
            //       color: BartrColors.black,
            //     ),
            //     textAlign: TextAlign.left,
            //   ),
            // ), //TODO: implement nested comments in future
          ],
        )
      ],
    );
  }
}
