import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/helpers/helper_functions.dart';
import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/login/domain/dtos/login_dto.dart';
import 'package:bartr/features/login/presentation/notifier/login_notifier.dart';
import 'package:bartr/features/login/presentation/notifier/login_state.dart';

import 'package:bartr/general_widgets/app_button.dart';
import 'package:bartr/general_widgets/bartr_loader.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import '../../../../core/config/configure_dependencies.dart';
import '../../../login/domain/models/login_model.dart';
import '../../domain/dtos/register_dto.dart';
import '../notifier/register_notifier.dart';
import '../widgets/verify_email_texts.dart';

class VerifyEmail extends ConsumerStatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  ConsumerState<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends ConsumerState<VerifyEmail> {
  late TextEditingController _pinController;

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _sendCode();
    });
    _pinController = TextEditingController();

    super.initState();
  }

  _sendCode() {
    final user = ref.read(currentUserProvider);
    if (user.emailConfirmed != null && !user.emailConfirmed!) {
      ref.read(registerNotifier.notifier).resendCode(
            data: ResendCodeDto(
              email: user.email!,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Image.asset(
          "assets/images/bartr.png",
          width: 100,
          height: 100,
        ),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const VerifyEmailTexts(),
              PinCodeTextField(
                controller: _pinController,
                onTextChanged: (val) {
                  setState(() {});
                },
                maxLength: 4,
                pinBoxWidth: 48,
                pinBoxHeight: 52,
                pinBoxRadius: 8.0,
                pinBoxBorderWidth: 1,
                pinTextStyle: Styles.w500(
                  size: 24,
                  color: BartrColors.black,
                ),
              ),
              const SizedBox(height: 24.0),
              Consumer(builder: (context, ref, child) {
                final model = ref.read(registerNotifier.notifier);
                final state = ref.watch(registerNotifier);
                var user = ref.watch(currentUserProvider);
                return state.resendState == LoadState.loading
                    ? const BartrLoader()
                    : Text.rich(
                        TextSpan(
                          text: Strings.didntGetCode,
                          children: [
                            TextSpan(
                              text: Strings.resendCode,
                              style: Styles.w600(
                                color: BartrColors.primary,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  model.resendCode(
                                    data: ResendCodeDto(email: user.email!),
                                  );
                                },
                            )
                          ],
                        ),
                      );
              }),
              const SizedBox(height: 24.0),
              Consumer(
                builder: (context, ref, child) {
                  _navigateToDashBoard(ref, context);
                  final state = ref.watch(registerNotifier);
                  final model = ref.read(registerNotifier.notifier);
                  var user = ref.watch(currentUserProvider);

                  return AppButton(
                    isLoading: state.loadState == LoadState.loading ||
                        state.resendState == LoadState.loading,
                    isEnabled: _pinController.text.length == 4 &&
                        state.loadState != LoadState.loading,
                    text: Strings.continuE,
                    onTap: () => _verifyEmail(model, ref, user),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _verifyEmail(
    RegisterNotifier model,
    WidgetRef ref,
    BartrUser user,
  ) async {
    final value =
        await model.verifyEmail(VerifyEmailDto(code: _pinController.text));
    if (value != null) {
      showError(text: value, context: context);
    } else {
      _login(ref, user);
    }
  }

  void _login(WidgetRef ref, BartrUser user) async {
    final res = await ref.read(loginNotifier.notifier).login(
          LoginDto(
            username: user.email!,
            password: user.password!,
          ),
        );
    if (res != null) {
      showError(text: res, context: context);
    }
  }

  void _navigateToDashBoard(WidgetRef ref, BuildContext context) {
    ref.listen<LoginState>(loginNotifier, (previous, next) {
      if (next.loadState == LoginLoadState.success) {
        context.router.replaceAll([const BartrDashBoardRoute()]);
        ref.read(userRepository).saveCacheStatus(true);
        return;
      }
    });
  }
}
