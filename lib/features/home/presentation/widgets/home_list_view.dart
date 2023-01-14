import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:bartr/general_widgets/bartr_loader.dart';
import 'package:flutter/material.dart';
import 'network_error_widget.dart';
import 'post_card.dart';

class HomeListView extends StatefulWidget {
  const HomeListView({
    Key? key,
    required this.posts,
    required this.isLoading,
    required this.isLoadingMore,
    required this.scrollController,
    required this.onDeletePost,
    this.onRetry,
    this.hasError = false,
    this.errorMessage,
  }) : super(key: key);
  final List<Post> posts;
  final bool isLoading, isLoadingMore;
  final ScrollController scrollController;
  final void Function()? onRetry;
  final bool hasError;
  final String? errorMessage;
  final void Function(String) onDeletePost;

  @override
  State<HomeListView> createState() => _HomeListViewState();
}

class _HomeListViewState extends State<HomeListView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.isLoading
        ? const BartrLoader(
            size: 80,
            color: BartrColors.primary,
          )
        : Column(
            children: [
              Expanded(
                child: ListView.separated(
                  addAutomaticKeepAlives: true,
                  controller: widget.scrollController,
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

                    return Column(
                      children: [
                        if (index == 0 && widget.hasError)
                          NetworkErrorWidget(
                            onTap: widget.onRetry,
                            errorMessage: widget.errorMessage,
                          ),
                        PostCard(
                          onDeletePost: () => widget.onDeletePost(post.id!),
                          post: post,
                          index: index,
                        ),
                      ],
                    );
                  },
                ),
              ),
              if (widget.isLoadingMore)
                const BartrLoader(color: BartrColors.primary),
              if (widget.isLoadingMore) const SizedBox(height: 20),
            ],
          );
  }
}
