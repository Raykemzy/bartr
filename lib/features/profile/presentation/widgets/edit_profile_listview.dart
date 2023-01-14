import 'dart:io';

import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/helpers/helper_functions.dart';
import 'package:bartr/core/router/routes.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/core/utils/validations.dart';
import 'package:bartr/general_widgets/app_button.dart';
import 'package:bartr/general_widgets/bartr_textfield.dart';
import 'package:bartr/general_widgets/cached_network_image_display.dart';
import 'package:bartr/general_widgets/country_picker_field.dart';
import 'package:bartr/general_widgets/select_image.dart';
import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/dtos/edit_profile_dto.dart';

class EditProfileListView extends StatefulHookConsumerWidget {
  const EditProfileListView({Key? key}) : super(key: key);

  @override
  ConsumerState<EditProfileListView> createState() =>
      _EditProfileListViewState();
}

class _EditProfileListViewState extends ConsumerState<EditProfileListView> {
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  void initState() {
    initCountry();
    setDetails();
    super.initState();
  }

  void setDetails() {
    final user = ref.read(currentUserProvider);

    _fullNameController.text = user.fullName ?? "";
    _usernameController.text = user.username ?? "";
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  Country _selectedCountry = const Country("", 'flags/usa.png', '', '');
  void initCountry() async {
    final country = await getDefaultCountry(context);
    setState(() {
      _selectedCountry = country;
    });
  }

  void _showCountryPicker() async {
    final country = await showCountryPickerSheet(
      context,
    );
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);

    ValueNotifier<List<File>> images = useState([]);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
      child: Column(
        children: [
          Center(
            child: InkWell(
              onTap: () => SelectImage.chooseImage(
                context: context,
                imageType: Strings.addPic,
                imageList: images,
                type: ImageType.single,
              ),
              child: Stack(
                children: [
                  images.value.isEmpty
                      ? CachedNetworkDisplay(
                          height: 90,
                          width: 90,
                          radius: 80,
                          url: user.profilePicture!,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: Image.file(
                            File(images.value.first.path),
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                  Positioned(
                    bottom: 2,
                    right: 35,
                    child: Image.asset(
                      "assets/images/camera.png",
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            Strings.changePic,
            textAlign: TextAlign.center,
            style: Styles.w400(
              color: BartrColors.black,
              size: 12,
            ),
          ),
          const SizedBox(height: 40.0),
          BartrTextField(
            validateFunction: Validators.name(),
            label: Strings.fullname,
            hintText: Strings.fullnameHint,
            controller: _fullNameController,
          ),
          const SizedBox(height: 40.0),
          BartrTextField(
            validateFunction: Validators.notEmpty(),
            label: Strings.username,
            hintText: Strings.usernameHint,
            controller: _usernameController,
          ),
          const SizedBox(height: 40.0),
          CountryPickerField(
            labelColor: BartrColors.black,
            country: _selectedCountry,
            onTap: _showCountryPicker,
          ),
          const SizedBox(height: 40.0),
          Consumer(
            builder: (context, ref, child) {
              final model = ref.read(profileNotifier.notifier);
              final state = ref.watch(profileNotifier);
              _pop(ref, context);
              return AppButton(
                isLoading: state.editProfileLoadState == LoadState.loading,
                text: Strings.saveChange,
                onTap: () {
                  _editProfile(model, images);
                },
              );
            },
          ),
          const SizedBox(height: 40.0),
        ],
      ),
    );
  }

  void _editProfile(ProfileNotifier model, ValueNotifier<List<File>> images) {
    final data = EditProfileDto(
      profilePicture: (images.value.isNotEmpty) ? images.value.first : null,
      country: _selectedCountry.name,
      name: _fullNameController.text,
      username: _usernameController.text,
    );
    model.editProfile(data);
  }

  void _pop(WidgetRef ref, BuildContext context) {
    ref.listen<ProfileState>(profileNotifier, (previous, next) async {
      if (next.editProfileLoadState == LoadState.success) {
        ref
            .read(profileNotifier.notifier)
            .getUserProfile(username: _usernameController.text);
        showSuccess(
          text: next.successMessage!,
          context: context,
          onFinished: () async {},
        );
        return;
      }
      if (next.editProfileLoadState == LoadState.error) {
        showError(text: next.successMessage!, context: context);
      }
    });
  }
}
