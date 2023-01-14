import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/helpers/helper_functions.dart';
import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/core/utils/validations.dart';
import 'package:bartr/features/profile/presentation/notifier/profile_notifier.dart';
import 'package:bartr/features/profile/presentation/notifier/profile_state.dart';
import 'package:bartr/general_widgets/app_button.dart';
import 'package:bartr/general_widgets/bartr_scaffold.dart';
import 'package:bartr/general_widgets/bartr_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/config/configure_dependencies.dart';
import '../../../../core/utils/colors.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BartrScaffold(
      appbar: AppBar(
        title: Text(
          "Delete Account",
          style: Styles.w700(size: 16, color: BartrColors.black),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: BartrColors.redLight,
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.only(
                    left: 10, top: 12, bottom: 12, right: 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset("assets/icons/error.svg"),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        Strings.deleteDisclaimer,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 80),
              Text(
                Strings.enterPass,
                style: Styles.w500(size: 14, color: BartrColors.grey),
              ),
              const SizedBox(height: 16),
              BartrTextField(
                validateFunction: Validators.notEmpty(),
                controller: _passwordController,
                label: Strings.password,
                onChange: (p0) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 16),
              Consumer(builder: (context, ref, child) {
                final model = ref.read(profileNotifier.notifier);
                final state = ref.watch(profileNotifier);
                _listener(ref, context);
                return AppButton(
                  isLoading: state.deleteAccountState == LoadState.loading,
                  isEnabled: _passwordController.text.isNotEmpty,
                  onTap: () => model.deleteAccount(_passwordController.text),
                  text: "Yes, delete my account",
                  color: _passwordController.text.isNotEmpty
                      ? BartrColors.red
                      : BartrColors.red.withOpacity(0.6),
                );
              }),
              AppButton(
                onTap: () => context.router.pop(),
                text: "Cancel",
                color: Colors.transparent,
                textColor: BartrColors.grey,
                hasBorder: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _listener(WidgetRef ref, BuildContext context) {
    ref.listen<ProfileState>(
      profileNotifier,
      (previous, next) {
        if (next.deleteAccountState == LoadState.success) {
          ref.read(localDb).clear();
          context.router.replaceAll([
            const SplashScreenRoute(),
          ]);
        } else if (next.deleteAccountState == LoadState.error) {
          showError(text: next.successMessage!, context: context);
        }
      },
    );
  }
}
