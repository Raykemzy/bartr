import 'package:bartr/core/helpers/extensions.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/forgot_password/presentation/widgets/forgot_password_scaffold.dart';
import 'package:flutter/material.dart';

class CodeSentPage extends StatelessWidget {
  final String email;
  const CodeSentPage({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ForgotPasswordScaffold(
      ctx: context,
      title: Strings.resetPass,
      titleBottomPadding: 20.0,
      child: Column(
        children: [
          Text(
            Strings.accountFound,
            style: Styles.w300(
              size: 14,
              color: BartrColors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40.0),
          Text(
            email.obscuredMail(),
            style: Styles.w600(
              size: 14,
              color: BartrColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
