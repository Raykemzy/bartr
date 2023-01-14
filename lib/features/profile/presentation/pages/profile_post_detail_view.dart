import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../../general_widgets/bartr_loader.dart';
import '../../../home/presentation/widgets/post_card.dart';

class ProfilePostDetail extends StatefulWidget {
  const ProfilePostDetail({
    Key? key,
    required this.posts,
    required this.loadState,
    required this.onRefresh,
    required this.isUser,
    required this.index,
    required this.postType,
    required this.postIndex,
    required this.ondeletePost,
  }) : super(key: key);

  final List<Post> posts;
  final LoadState loadState;
  final PostType postType;
  final Future<void> Function() onRefresh;
  final void Function() ondeletePost;
  final bool isUser;
  final int index;
  final int postIndex;
  @override
  State<ProfilePostDetail> createState() => _ProfilePostDetailState();
}

class _ProfilePostDetailState extends State<ProfilePostDetail> {
  late ScrollController scrollController;
  late AutoScrollController controller;
  int currentIndex = 0;
  void changeIndex(int newIndex) {
    setState(() {
      currentIndex = newIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
    controller = AutoScrollController();
    _scrollToOFfset();
  }

  _scrollToOFfset() async {
    await Future.delayed(const Duration(milliseconds: 100), () {
      controller.scrollToIndex(
        widget.postIndex,
        duration: const Duration(milliseconds: 1000),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.postType == PostType.Barter ? "Bartr" : "Giveaway"} post",
          style: Styles.w500(
            size: 16,
            color: BartrColors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      addAutomaticKeepAlives: true,
                      controller: controller,
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 10,
                        bottom: 50,
                      ),
                      shrinkWrap: true,
                      itemCount: widget.posts.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 40),
                      itemBuilder: (context, index) {
                        var post = widget.posts[index];
                        return AutoScrollTag(
                          index: index,
                          controller: controller,
                          key: ValueKey(widget.postIndex),
                          child: PostCard(
                            onDeletePost: widget.ondeletePost,
                            post: post,
                            index: index,
                          ),
                        );
                      },
                    ),
                  ),
                  if (widget.loadState == LoadState.loadmore)
                    const BartrLoader(color: BartrColors.primary),
                  if (widget.loadState == LoadState.loadmore)
                    const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
