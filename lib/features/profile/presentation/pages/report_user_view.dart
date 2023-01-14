import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/helpers/helper_functions.dart';
import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/core/utils/validations.dart';
import 'package:bartr/features/create_post/domain/dtos/report_post_dto.dart';
import 'package:bartr/features/create_post/notifier/report_post_notifer.dart';
import 'package:bartr/features/create_post/notifier/report_post_state.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:bartr/features/profile/presentation/widgets/feedback_textfield.dart';
import 'package:bartr/general_widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReportUserView extends StatefulWidget {
  final BartrUser user;
  const ReportUserView({Key? key, required this.user}) : super(key: key);

  @override
  State<ReportUserView> createState() => _ReportUserViewState();
}

class _ReportUserViewState extends State<ReportUserView> {
  final _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () => context.router.pop(),
                    child: Image.asset('assets/images/cancel.png'),
                  ),
                ),
                const SizedBox(height: 60),
                Image.asset('assets/images/rate.png'),
                const SizedBox(height: 16),
                Text(
                  Strings.kindlyUser,
                  style: Styles.w400(
                    color: BartrColors.black,
                    size: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                FeedBackTextField(
                  onChanged: (val) {
                    setState(() {});
                  },
                  validateFunction: Validators.notEmpty(),
                  controller: _feedbackController,
                  label: Strings.feedbackNotes,
                  hintText: Strings.tellUser,
                ),
                const SizedBox(height: 40),
                Consumer(
                  builder: (context, ref, child) {
                    final report = ref.read(reportPostNotifier.notifier);
                    final state = ref.watch(reportPostNotifier);
                    _pop(ref, context);
                    return AppButton(
                      text: Strings.submitReport,
                      isLoading: state.reportPostLoadState == LoadState.loading,
                      onTap: () {
                        final data = ReportPostDto(
                          userId: widget.user.id!,
                          reason: 'User: ${_feedbackController.text}',
                        );
                        _reportPost(report, data, context);
                      },
                    );
                  },
                ),
                const SizedBox(height: 24),
                InkWell(
                  child: Text(
                    Strings.close,
                    style: Styles.w700(size: 16, color: BartrColors.primary),
                  ),
                  onTap: () => context.router.pop(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _reportPost(
    ReportPostNotifier model,
    ReportPostDto data,
    BuildContext context,
  ) {
    model.reportUser(data).then((value) {
      if (value != null) {
        showError(text: value, context: context);
      }
    });
  }

  void _pop(WidgetRef ref, BuildContext context) {
    ref.listen<ReportPostState>(reportPostNotifier, (previous, next) async {
      if (next.reportPostLoadState == LoadState.success) {
        showSuccess(text: "User report successful", context: context);
        await Future.delayed(const Duration(seconds: 1));
        context.router.replaceAll([
          const BartrDashBoardRoute(),
        ]);
        return;
      }
    });
  }
}
