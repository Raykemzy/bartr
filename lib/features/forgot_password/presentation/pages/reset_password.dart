import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/helpers/extensions.dart';
import 'package:bartr/core/helpers/helper_functions.dart';
import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/core/utils/validations.dart';
import 'package:bartr/features/forgot_password/domain/dtos/reset_password_dto.dart';
import 'package:bartr/features/forgot_password/presentation/notifier/reset_password_notifier.dart';
import 'package:bartr/features/forgot_password/presentation/notifier/reset_password_state.dart';
import 'package:bartr/features/forgot_password/presentation/widgets/forgot_password_scaffold.dart';
import 'package:bartr/features/forgot_password/presentation/widgets/password_criteria.dart';
import 'package:bartr/features/login/presentation/notifier/visibility_state.dart';
import 'package:bartr/general_widgets/app_button.dart';
import 'package:bartr/general_widgets/bartr_textfield.dart';
import 'package:bartr/general_widgets/eye_toggle_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResetPassword extends ConsumerStatefulWidget {
  final String code;
  const ResetPassword({required this.code, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends ConsumerState<ResetPassword> {
  final _pass1Controller = TextEditingController();
  final _pass2Controller = TextEditingController();
  bool isValid = false;
  bool isVisible = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _pass1Controller.dispose();
    _pass2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resetModel = ref.read(resetPasswordProvider.notifier);
    final resetState = ref.watch(resetPasswordProvider);
    final state = ref.watch(visibilityProvider);
    return ForgotPasswordScaffold(
      ctx: context,
      title: Strings.resetPass,
      titleBottomPadding: 5.0,
      child: Form(
        key: _formKey,
        onChanged: () {
          setState(() {
            isValid = _formKey.currentState!.validate();
          });
        },
        child: Column(
          children: [
            Text(
              Strings.strongPass,
              style: Styles.w300(
                size: 14,
                color: BartrColors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            BartrTextField(
              suffixIcon: const VisibilityIcon(),
              obscureText: !state,
              validateFunction: Validators.password(6),
              label: Strings.enterNewPass,
              controller: _pass1Controller,
              onChange: (p0) {
                setState(() {});
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: PassCriteria(
                has6t020: _pass1Controller.text.length >= 6,
                hasLettersNumbersAndSpecial:
                    _pass1Controller.text.containsLower() &&
                        _pass1Controller.text.containsNumber() &&
                        _pass1Controller.text.containsSpecialChar(),
              ),
            ),
            const SizedBox(height: 20.0),
            BartrTextField(
              validateFunction: (val) {
                if (_pass1Controller.text != _pass2Controller.text) {
                  return "Passwords do not match";
                } else {
                  return null;
                }
              },
              label: Strings.confirmNewPass,
              controller: _pass2Controller,
            ),
            const SizedBox(height: 20.0),
            Consumer(
              builder: (context, ref, child) {
                _navigate(ref);
                return AppButton(
                  isEnabled: isValid,
                  isLoading: resetState.loadState == LoadState.loading,
                  text: Strings.continuE,
                  onTap: () => _reset(resetModel),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void _navigate(WidgetRef ref) {
    ref.listen<ResetPasswordState>(resetPasswordProvider, (prev, next) async {
      if (next.loadState == LoadState.success) {
        await Future.delayed(const Duration(seconds: 1), () {
          context.router.replaceAll([const LoginRoute()]);
        });
      }
    });
  }

  void _reset(ResetPasswordNotifier model) {
    final data = ResetPasswordDto(
      code: widget.code,
      password: _pass2Controller.text,
    );
    model.resetPass(data).then((value) {
      if (value.error != null) {
        showError(text: value.error!, context: context);
      } else {
        showSuccess(text: value.message!, context: context);
      }
    });
  }
}
