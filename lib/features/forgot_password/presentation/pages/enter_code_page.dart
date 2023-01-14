import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/helpers/helper_functions.dart';
import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/forgot_password/domain/dtos/forgot_password_dto.dart';
import 'package:bartr/features/forgot_password/presentation/notifier/forgot_password_notifier.dart';
import 'package:bartr/features/forgot_password/presentation/notifier/timer_notifier.dart';
import 'package:bartr/features/forgot_password/presentation/widgets/forgot_password_scaffold.dart';
import 'package:bartr/general_widgets/app_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class EnterCodePage extends StatefulWidget {
  final String email;
  const EnterCodePage({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<EnterCodePage> createState() => _EnterCodePageState();
}

class _EnterCodePageState extends State<EnterCodePage> {
  TextEditingController controller = TextEditingController(text: "");
  String thisText = "";
  int pinLength = 4;
  bool hasError = false;
  String errorMessage = '';
  final int seconds = 5;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ForgotPasswordScaffold(
      ctx: context,
      title: Strings.checkEmail,
      titleBottomPadding: 10.0,
      child: Column(
        children: [
          Text(
            Strings.enter6Digit,
            style: Styles.w300(
              size: 14,
              color: BartrColors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20.0),
          Text(
            Strings.enterCode,
            style: Styles.w300(
              size: 14,
              color: BartrColors.primary,
            ),
          ),
          const SizedBox(height: 5.0),
          PinCodeTextField(
            controller: controller,
            highlight: true,
            pinBoxWidth: 48,
            pinBoxHeight: 52,
            maxLength: pinLength,
            pinBoxColor: Colors.transparent,
            pinBoxRadius: 10,
            pinBoxBorderWidth: 1,
            defaultBorderColor: BartrColors.lightGrey,
          ),
          const SizedBox(height: 20.0),
          Consumer(
            builder: (context, ref, child) {
              final model = ref.read(forgotPassNotifier.notifier);
              final timerModel2 = ref.read(countDownProvider.notifier);
              return Text.rich(
                TextSpan(
                  text: Strings.notGetCode,
                  children: [
                    TextSpan(
                      text: Strings.resend,
                      style: Styles.w600(
                        color: BartrColors.primary,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _forgot(model);
                          timerModel2.codeResent(ref, seconds);
                        },
                    )
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 30.0),
          Consumer(
            builder: (context, ref, child) {
              final timerModel = ref.watch(countDownProvider);
              if (timerModel.loadState == TimerState.timerStarted) {
                return Text(Strings.resendCount + seconds.toString());
              }
              return const SizedBox();
            },
          ),
          AppButton(
            isEnabled: (controller.text.length < 7) ? true : false,
            text: Strings.continuE,
            onTap: () {
              context.router.push(ResetPasswordRoute(code: controller.text));
            },
          )
        ],
      ),
    );
  }

  void _forgot(ForgotPasswordNotifier model) {
    final data = ForgotPasswordDto(email: widget.email);
    model.forgotPass(data).then((value) {
      if (value != null) {
        showError(text: value, context: context);
      }
    });
  }
}
