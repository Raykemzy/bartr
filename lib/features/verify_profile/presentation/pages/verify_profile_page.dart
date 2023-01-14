import 'dart:io';

import 'package:bartr/core/helpers/helper_functions.dart';
import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/router/routes.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/validations.dart';
import 'package:bartr/features/verify_profile/presentation/domain/verify_profile_dto.dart';
import 'package:bartr/features/verify_profile/presentation/notifiers/verify_profile_notifier.dart';
import 'package:bartr/features/verify_profile/presentation/notifiers/verify_profile_state.dart';
import 'package:bartr/features/verify_profile/presentation/widgets/id_image_picker.dart';
import 'package:bartr/general_widgets/app_button.dart';
import 'package:bartr/general_widgets/bartr_textfield.dart';
import 'package:bartr/general_widgets/batr_general_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VerifyProfilePage extends StatefulHookConsumerWidget {
  const VerifyProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<VerifyProfilePage> createState() => _VerifyProfilePageState();
}

class _VerifyProfilePageState extends ConsumerState<VerifyProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final idNumberController = TextEditingController();
  EdgeInsetsGeometry padding = const EdgeInsets.only(top: 320);
  bool isEnabled = false;

  @override
  void dispose() {
    idNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<List<File>> images = useState([]);
    return Scaffold(
      appBar: BartrAppBar(title: Strings.verifyProfile),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0) +
              const EdgeInsets.only(top: 24),
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
                IDImagePicker(images: images),
                const SizedBox(height: 40),
                BartrTextField(
                  label: "ID Type",
                  hintText: Strings.enterID,
                  controller: idNumberController,
                  validateFunction: Validators.notEmpty(),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).viewInsets.bottom == 0
                        ? 300
                        : 50,
                  ),
                  child: Consumer(
                    builder: (context, ref, child) {
                      final model = ref.read(verifyProfileNotifier.notifier);
                      final state = ref.watch(verifyProfileNotifier);
                      _navigate(ref, context);
                      return AppButton(
                        text: Strings.verifyMe,
                        isEnabled: isEnabled && images.value.isNotEmpty,
                        isLoading:
                            state.verifyProfileLoadState == LoadState.loading,
                        onTap: () => _verify(model, images),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _verify(VerifyProfileNotifier model, ValueNotifier<List<File>> images) {
    final data = VerifyProfileDto(
      idType: idNumberController.text,
      idImage: images.value[0],
    );
    model.verifyProfile(data).then((value) {
      if (value != null) {
        showError(text: value, context: context);
      }
    });
  }

  void _navigate(WidgetRef ref, BuildContext context) {
    ref.listen<VerifyProfileState>(verifyProfileNotifier, (previous, next) {
      if (next.verifyProfileLoadState == LoadState.success) {
        context.router.replace(const IDSubmittedPageRoute());
        return;
      }
    });
  }
}
