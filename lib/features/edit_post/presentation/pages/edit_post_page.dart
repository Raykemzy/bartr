import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/helpers/extensions.dart';
import 'package:bartr/core/helpers/helper_functions.dart';
import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/validations.dart';
import 'package:bartr/features/edit_post/domain/edit_post_dto.dart';
import 'package:bartr/features/edit_post/presentation/notifiers/edit_post_notifier.dart';
import 'package:bartr/features/edit_post/presentation/notifiers/edit_post_state.dart';
import 'package:bartr/features/edit_post/presentation/widgets/edit_post_description_text_field.dart';
import 'package:bartr/features/edit_post/presentation/widgets/edit_post_images_container.dart';
import 'package:bartr/features/home/presentation/notifier/home_notifier.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:bartr/features/post_and_comments/domain/models/single_post_model.dart';
import 'package:bartr/general_widgets/app_button.dart';
import 'package:bartr/general_widgets/bartr_scaffold.dart';
import 'package:bartr/general_widgets/bartr_textfield.dart';
import 'package:bartr/general_widgets/batr_general_appbar.dart';
import "package:flutter/material.dart";
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../general_widgets/drop_down_field.dart';

class EditPostPage extends StatefulWidget {
  final Post? post;
  final SinglePost? singlePost;
  const EditPostPage({
    Key? key,
    this.post,
    this.singlePost,
  }) : super(key: key);

  @override
  State<EditPostPage> createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  final _formKey = GlobalKey<FormState>();
  final _hourController = TextEditingController();
  final _minuteController = TextEditingController();
  String? _question;
  String? _description;

  @override
  void dispose() {
    _minuteController.dispose();
    _hourController.dispose();
    super.dispose();
  }

  bool isEnabled = false;
  List<String> postCategories = [
    "Arts & Crafts",
    "Books",
    "Cars",
    "Clothing",
    "Collectibles",
    "Electronics",
    "Furniture",
    "Gadgets",
    "Video Games",
    "Handmade",
    "Home, Garden & Pets",
    "Kitchen Utensils",
    "PC",
    "Power/Mechanic/Carpentry tools",
    "Toys",
    "Others",
  ];
  bool isTimed = false;
  late PostType? postType;
  late String? postCategory;
  late PostVisiblility? postVisiblility;
  late String? postStatus;
  @override
  void initState() {
    postStatus = widget.post?.status ?? widget.singlePost?.status ?? "";
    postCategory = widget.post?.category ?? widget.singlePost!.category;
    postType = widget.post?.postType ?? widget.singlePost!.postType;
    postVisiblility = widget.post?.visibility ?? widget.singlePost!.visibility;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //ValueNotifier<List<File>> images = useState([]);
    return BartrScaffold(
      appbar: BartrAppBar(
        title: Strings.editPost,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 24, 16, 40),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: () {
              setState(() {
                isEnabled = _formKey.currentState!.validate();
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropDownField<String>(
                  label: Strings.changeStatus,
                  currentValue: postStatus,
                  values:
                      (widget.post?.postType ?? widget.singlePost!.postType) ==
                              PostType.Giveaway
                          ? ["Available", "Given away"]
                          : ["Available", "Bartered"],
                  onChanged: (val) {
                    setState(() {
                      postStatus = val;
                    });
                  },
                ),
                const SizedBox(height: 40),
                DropDownField<String>(
                  label: Strings.selectPT,
                  currentValue:
                      postType == PostType.Giveaway ? "Giveaway" : "Barter",
                  values: [
                    PostType.Barter.name.capiTalizeFirst(),
                    PostType.Giveaway.name.capiTalizeFirst(),
                  ],
                  onChanged: (val) {
                    setState(() {
                      if (val == "Barter") {
                        postType = PostType.Barter;
                      } else {
                        postType = PostType.Giveaway;
                      }
                    });
                  },
                ),
                const SizedBox(height: 40),
                BartrTextField(
                  validateFunction: Validators.notEmpty(),
                  onChange: (v) {
                    setState(() {
                      _question = v;
                    });
                  },
                  labelSize: 14,
                  label: (postType == PostType.Giveaway)
                      ? Strings.hintTextItemName
                      : Strings.postQuestion,
                  initialValue: widget.post?.title ?? widget.singlePost!.title,
                ),
                const SizedBox(height: 30),
                DropDownField<String>(
                  label: Strings.selectVis,
                  currentValue: postVisiblility == PostVisiblility.Private
                      ? "Private"
                      : "Public",
                  values: [
                    PostVisiblility.Public.name.capiTalizeFirst(),
                    PostVisiblility.Private.name.capiTalizeFirst(),
                  ],
                  onChanged: (val) {
                    setState(() {
                      if (val == "Public") {
                        postVisiblility = PostVisiblility.Public;
                      } else {
                        postVisiblility = PostVisiblility.Private;
                      }
                    });
                  },
                ),
                const SizedBox(height: 40),
                EditPostDescriptionTextField(
                  currentValue: widget.post?.description ??
                      widget.singlePost!.description,
                  onChanged: (val) {
                    setState(() {
                      _description = val;
                    });
                  },
                  validateFunction: Validators.notEmpty(),
                  label: Strings.desc,
                ),
                DropDownField<String>(
                  label: Strings.selectCat,
                  currentValue: postCategory,
                  values: postCategories,
                  onChanged: (val) {
                    setState(() {
                      postCategory = val!;
                    });
                  },
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: widget.post?.images == null
                      ? widget.singlePost!.images!.length > 4
                          ? 180
                          : 90
                      : widget.post!.images!.length > 4
                          ? 180
                          : 90,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.post?.images == null
                              ? widget.singlePost!.images!.length
                              : widget.post?.images!.length,
                          itemBuilder: ((context, i) {
                            return ImageContainer(
                              imageUrl: widget.post?.images == null
                                  ? widget.singlePost!.images![i]
                                  : widget.post!.images![i],
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Consumer(
                  builder: (context, ref, child) {
                    final model = ref.read(editPostNotifier.notifier);
                    final state = ref.watch(editPostNotifier);
                    _pop(ref, context);
                    final data = (widget.singlePost == null)
                        ? EditPostDto(
                            status: postStatus,
                            title: _question ?? widget.post?.title,
                            description:
                                _description ?? widget.post?.description,
                            category: postCategory ?? widget.post?.category!,
                            postType: postType ?? widget.post?.postType,
                            visibility:
                                postVisiblility ?? widget.post?.visibility,
                            hours: _hourController.text.isEmpty
                                ? widget.post?.createdAt!.hour.toString()
                                : _hourController.text,
                            minutes: _minuteController.text.isEmpty
                                ? widget.post?.createdAt!.hour.toString()
                                : _minuteController.text,
                            images: widget.post?.images!,
                          )
                        : EditPostDto(
                            status: postStatus,
                            title: _question ?? widget.singlePost!.title,
                            description:
                                _description ?? widget.singlePost!.description,
                            category:
                                postCategory ?? widget.singlePost!.category!,
                            postType: postType ?? widget.singlePost!.postType,
                            visibility: postVisiblility ??
                                widget.singlePost!.visibility,
                            hours: _hourController.text.isEmpty
                                ? widget.singlePost!.createdAt!.hour.toString()
                                : _hourController.text,
                            minutes: _minuteController.text.isEmpty
                                ? widget.singlePost!.createdAt!.hour.toString()
                                : _minuteController.text,
                            images: widget.singlePost!.images!,
                          );

                    return AppButton(
                      isLoading: state.editPostLoadState == LoadState.loading,
                      onTap: () => _editPost(
                        model,
                        data,
                        widget.post != null
                            ? widget.post!.id!
                            : widget.singlePost!.id!,
                        context,
                      ),
                      isEnabled: true,
                      text: Strings.editPost,
                      margin: EdgeInsets.zero,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _editPost(
    EditPostNotifier model,
    EditPostDto data,
    String postId,
    BuildContext context,
  ) {
    model.editPost(data, postId).then((value) {
      if (value != null) {
        showError(text: value, context: context);
      }
    });
  }

  void _pop(WidgetRef ref, BuildContext context) {
    ref.listen<EditPostState>(editPostNotifier, (previous, next) async {
      if (next.editPostLoadState == LoadState.success) {
        showSuccess(text: "Post edited successfully", context: context);
        await Future.delayed(const Duration(seconds: 1));
        ref.refresh(homeNotifier.notifier).fetchPosts(page: 1);
        context.router.replaceAll([
          const BartrDashBoardRoute(),
        ]);
        return;
      }
    });
  }
}
