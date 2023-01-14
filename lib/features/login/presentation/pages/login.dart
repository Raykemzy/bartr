import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/helpers/helper_functions.dart';
import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/core/utils/validations.dart';
import 'package:bartr/features/login/domain/dtos/login_dto.dart';
import 'package:bartr/features/login/presentation/notifier/login_notifier.dart';
import 'package:bartr/features/login/presentation/notifier/login_state.dart';
import 'package:bartr/features/login/presentation/notifier/visibility_state.dart';
import 'package:bartr/general_widgets/app_button.dart';
import 'package:bartr/general_widgets/bartr_textfield.dart';
import 'package:bartr/general_widgets/eye_toggle_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/config/configure_dependencies.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/tandc_widget.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isEnabled = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: Strings.login,
      child: loginBody(context),
    );
  }

  Form loginBody(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: () => setState(() {
        isEnabled = _formKey.currentState!.validate();
      }),
      child: Column(
        children: [
          BartrTextField(
            validateFunction: Validators.notEmpty(),
            label: Strings.emailOrUsername,
            hintText: Strings.emailHint,
            controller: _emailController,
          ),
          const SizedBox(height: 40.0),
          Consumer(
            builder: (context, ref, child) {
              final state = ref.watch(visibilityProvider);
              return BartrTextField(
                validateFunction: Validators.notEmpty(),
                suffixIcon: const VisibilityIcon(),
                obscureText: !state,
                label: Strings.password,
                hintText: Strings.passwordHint,
                controller: _passwordController,
              );
            },
          ),
          const SizedBox(height: 8.0),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () => context.router.push(const ForgotPasswordRoute()),
              child: Text(
                Strings.forgotPass,
                style: Styles.w600(
                  size: 14,
                  color: BartrColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 56.0),
          Consumer(
            builder: (context, ref, child) {
              final model = ref.read(loginNotifier.notifier);
              final state = ref.watch(loginNotifier);
              _navigateToHome(ref, context);
              return AppButton(
                margin: EdgeInsets.zero,
                isLoading: state.loadState == LoginLoadState.loading,
                isEnabled: isEnabled,
                text: Strings.login,
                onTap: () => _login(model),
              );
            },
          ),
          const SizedBox(height: 40.0),
          Text.rich(
            TextSpan(
              text: Strings.dontHaveAcc,
              children: [
                TextSpan(
                  text: Strings.joinB,
                  style: Styles.w600(
                    color: BartrColors.primary,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.router.replace(const RegisterRoute());
                    },
                )
              ],
            ),
          ),
          const SizedBox(height: 24.0),
          const TandCWidget(),
        ],
      ),
    );
  }

  void _login(LoginNotifier model) {
    final data = LoginDto(
      username: _emailController.text,
      password: _passwordController.text,
    );
    model.login(data).then((value) {
      if (value != null) {
        showError(text: value, context: context);
      }
    });
  }

  void _navigateToHome(WidgetRef ref, BuildContext context) {
    ref.listen<LoginState>(loginNotifier, (previous, next) {
      if (next.loadState == LoginLoadState.success) {
        ref.read(userRepository).saveCacheStatus(true);
        context.router.replaceAll([const BartrDashBoardRoute()]);
        return;
      }
      if (next.loadState == LoginLoadState.unverified) {
        context.router.replaceAll([const VerifyEmailRoute()]);
        return;
      }
    });
  }
}
