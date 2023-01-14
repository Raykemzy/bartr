import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/helpers/extensions.dart';
import 'package:bartr/core/helpers/helper_functions.dart';
import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/validations.dart';
import 'package:bartr/features/create_post/domain/dtos/create_post_dto.dart';
import 'package:bartr/features/create_post/notifier/create_post_notifier.dart';
import 'package:bartr/features/create_post/notifier/create_post_state.dart';
import 'package:bartr/features/home/presentation/notifier/home_notifier.dart';
import 'package:bartr/features/profile/presentation/notifier/profile_notifier.dart';
import 'package:bartr/general_widgets/app_button.dart';
import 'package:bartr/general_widgets/bartr_scaffold.dart';
import 'package:bartr/general_widgets/bartr_textfield.dart';
import 'package:bartr/general_widgets/batr_general_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../general_widgets/drop_down_field.dart';
import '../widgets/post_description_texfield.dart';
import '../widgets/post_image_picker.dart';

class CreatePost extends StatefulHookConsumerWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  ConsumerState<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends ConsumerState<CreatePost> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final _hourController = TextEditingController();
  final _minuteController = TextEditingController();
  final _decriptionController = TextEditingController();

  @override
  void dispose() {
    _questionController.dispose();
    _minuteController.dispose();
    _decriptionController.dispose();
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
  late PostType postType;
  late String postCategory;
  late PostVisiblility postVisiblility;
  @override
  void initState() {
    postCategory = "Arts & Crafts";
    postType = PostType.Barter;
    postVisiblility = PostVisiblility.Public;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<List<File>> images = useState([]);

    return BartrScaffold(
      appbar: BartrAppBar(
        title: Strings.addPost,
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
                  label: Strings.selectPT,
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
                  controller: _questionController,
                  labelSize: 14,
                  label: (postType == PostType.Giveaway)
                      ? Strings.hintTextItemName
                      : Strings.postQuestion,
                ),
                if (postType == PostType.Giveaway) const SizedBox(height: 40),
                if (postType == PostType.Giveaway) Text(Strings.postQuestion2),
                if (postType == PostType.Giveaway)
                  Row(
                    children: [
                      Row(
                        children: [
                          Transform.scale(
                            scale: 1.4,
                            child: Radio(
                              activeColor: BartrColors.black,
                              value: true,
                              groupValue: isTimed,
                              onChanged: (val) {
                                setState(() {
                                  isTimed = !isTimed;
                                });
                              },
                            ),
                          ),
                          Text(Strings.y)
                        ],
                      ),
                      const SizedBox(width: 24),
                      Row(
                        children: [
                          Transform.scale(
                            scale: 1.4,
                            child: Radio(
                              activeColor: BartrColors.black,
                              value: false,
                              groupValue: isTimed,
                              onChanged: (val) {
                                setState(() {
                                  isTimed = !isTimed;
                                });
                              },
                            ),
                          ),
                          Text(Strings.n)
                        ],
                      ),
                    ],
                  ),
                if (isTimed && postType == PostType.Giveaway)
                  const SizedBox(height: 40),
                if (isTimed && postType == PostType.Giveaway)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 130,
                          child: BartrTextField(
                            keyboardType: TextInputType.number,
                            controller: _hourController,
                            validateFunction: Validators.notEmpty(),
                            label: Strings.setTime,
                            labelSize: 14,
                            hintText: Strings.hour,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 130,
                          child: BartrTextField(
                            keyboardType: TextInputType.number,
                            label: " ",
                            labelSize: 14,
                            controller: _minuteController,
                            validateFunction: Validators.notEmpty(),
                            hintText: Strings.min,
                          ),
                        ),
                      )
                    ],
                  ),
                const SizedBox(height: 40),
                DropDownField<String>(
                  label: Strings.selectVis,
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
                PostDescriptionTextField(
                  onChanged: (val) {
                    setState(() {});
                  },
                  validateFunction: Validators.notEmpty(),
                  controller: _decriptionController,
                  label: Strings.desc,
                ),
                const SizedBox(height: 20),
                DropDownField<String>(
                  label: Strings.selectCat,
                  values: postCategories,
                  onChanged: (val) {
                    setState(() {
                      postCategory = val!;
                    });
                  },
                ),
                const SizedBox(height: 40),
                PostImagePicker(
                  images: images,
                ),
                const SizedBox(height: 40),
                Consumer(
                  builder: (context, ref, child) {
                    final model = ref.read(createPostNotifier.notifier);
                    final state = ref.watch(createPostNotifier);
                    _pop(ref, context);
                    final data = CreatePostDto(
                      title: _questionController.text,
                      description: _decriptionController.text,
                      category: postCategory,
                      postType: postType,
                      visibility: postVisiblility,
                      hours: _hourController.text,
                      minutes: _minuteController.text,
                      images: images.value,
                    );
                    return AppButton(
                      isLoading: state.createPostLoadState == LoadState.loading,
                      onTap: () => _createPost(model, data, context),
                      isEnabled: isEnabled && images.value.isNotEmpty,
                      text: Strings.addPost,
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

  void _createPost(
    CreatePostNotifier model,
    CreatePostDto data,
    BuildContext context,
  ) {
    model.createPost(data).then((value) {
      if (value != null) {
        showError(text: value, context: context);
      }
    });
  }

  void _pop(WidgetRef ref, BuildContext context) {
    ref.listen<CreatePostState>(createPostNotifier, (previous, next) async {
      if (next.createPostLoadState == LoadState.success) {
        showSuccess(text: "Post created successfully", context: context);
        await Future.delayed(const Duration(seconds: 1));
        ref.refresh(homeNotifier.notifier).fetchPosts(page: 1);
        ref.read(profileNotifier.notifier).fetchUserPosts(
              userId: ref.read(currentUserProvider).username!,
              page: 1,
            );
        context.router.replaceAll([
          const BartrDashBoardRoute(),
        ]);
        return;
      }
    });
  }
}
