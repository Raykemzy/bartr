import 'package:bartr/core/helpers/helper_functions.dart';
import 'package:bartr/core/router/routes.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/validations.dart';
import 'package:bartr/features/login/presentation/notifier/visibility_state.dart';
import 'package:bartr/features/profile/domain/dtos/change_password_dto.dart';
import 'package:bartr/general_widgets/app_button.dart';
import 'package:bartr/general_widgets/bartr_textfield.dart';
import 'package:bartr/general_widgets/eye_toggle_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditPasswordView extends ConsumerStatefulWidget {
  const EditPasswordView({Key? key}) : super(key: key);

  @override
  ConsumerState<EditPasswordView> createState() => _EditPasswordViewState();
}

class _EditPasswordViewState extends ConsumerState<EditPasswordView> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool isEnabled = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(visibilityProvider);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
      child: Form(
        key: _formKey,
        onChanged: () {
          setState(() {
            isEnabled = _formKey.currentState!.validate();
          });
        },
        child: Column(
          children: [
            BartrTextField(
              suffixIcon: const VisibilityIcon(),
              obscureText: !state,
              validateFunction: Validators.notEmpty(),
              label: Strings.oldPassword,
              hintText: Strings.passwordHint,
              controller: _oldPasswordController,
            ),
            const SizedBox(height: 40.0),
            BartrTextField(
              suffixIcon: const VisibilityIcon(),
              obscureText: !state,
              validateFunction: Validators.password(),
              label: Strings.newPassword,
              hintText: Strings.passwordHint,
              controller: _newPasswordController,
            ),
            const SizedBox(height: 40.0),
            BartrTextField(
              suffixIcon: const VisibilityIcon(),
              obscureText: !state,
              validateFunction: (val) {
                if (_newPasswordController.text !=
                    _confirmPasswordController.text) {
                  return "Passwords do not match";
                } else {
                  return null;
                }
              },
              label: Strings.confirmNewPassword,
              hintText: Strings.passwordHint,
              controller: _confirmPasswordController,
            ),
            const SizedBox(height: 40.0),
            Consumer(
              builder: (context, ref, child) {
                final model = ref.read(profileNotifier.notifier);
                final state = ref.watch(profileNotifier);
                _pop(ref);
                return AppButton(
                  isLoading: state.changePasswordState == LoadState.loading,
                  isEnabled: isEnabled,
                  text: Strings.saveChange,
                  onTap: () {
                    final data = ChangePasswordDto(
                      oldPassword: _oldPasswordController.text.trim(),
                      newPassword: _confirmPasswordController.text.trim(),
                    );
                    model.changePassword(data);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _pop(WidgetRef ref) {
    ref.listen<ProfileState>(profileNotifier, (prev, next) async {
      if (next.changePasswordState == LoadState.success) {
        showSuccess(
          text: "Password changed successfully",
          context: context,
          onFinished: () {
            if (mounted) {
              context.router.pop();
              return;
            }
          },
        );
        return;
      }
      if (next.changePasswordState == LoadState.error) {
        showError(
          text: next.successMessage ?? Strings.genericErrorMessage,
          context: context,
        );
        return;
      }
    });
  }
}
