import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/helpers/helper_functions.dart';
import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/validations.dart';
import 'package:bartr/features/forgot_password/domain/dtos/forgot_password_dto.dart';
import 'package:bartr/features/forgot_password/presentation/notifier/forgot_password_notifier.dart';
import 'package:bartr/features/forgot_password/presentation/notifier/forgot_password_state.dart';
import 'package:bartr/features/forgot_password/presentation/widgets/forgot_password_scaffold.dart';
import 'package:bartr/general_widgets/app_button.dart';
import 'package:bartr/general_widgets/bartr_textfield.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isEnabled = false;
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ForgotPasswordScaffold(
      ctx: context,
      title: Strings.forgotPass,
      child: Form(
        key: _formKey,
        onChanged: () {
          setState(() {
            isEnabled = _formKey.currentState!.validate();
          });
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: BartrTextField(
                validateFunction: Validators.email(),
                label: Strings.email,
                controller: _emailController,
              ),
            ),
            const SizedBox(height: 40.0),
            Consumer(
              builder: (context, ref, child) {
                final model = ref.read(forgotPassNotifier.notifier);
                final state = ref.watch(forgotPassNotifier);
                _navigateToReset(ref, context);
                return AppButton(
                  isEnabled: isEnabled,
                  isLoading: state.loadState == LoadState.loading,
                  onTap: () => _forgot(model),
                  text: "Search",
                  width: width,
                );
              },
            ),
            AppButton(
              onTap: () => context.router.replace(const LoginRoute()),
              text: "Cancel",
              color: Colors.transparent,
              textColor: BartrColors.grey,
              width: width * 0.7,
            ),
          ],
        ),
      ),
    );
  }

  void _forgot(ForgotPasswordNotifier model) {
    final data = ForgotPasswordDto(email: _emailController.text);
    model.forgotPass(data).then((value) {
      if (value != null) {
        showError(text: value, context: context);
      }
    });
  }

  void _navigateToReset(WidgetRef ref, BuildContext context) {
    ref.listen<ForgotPasswordState>(forgotPassNotifier, (previous, next) {
      if (next.loadState == LoadState.success) {
        context.router.push(EnterCodePageRoute(email: _emailController.text));
        return;
      }
    });
  }
}
