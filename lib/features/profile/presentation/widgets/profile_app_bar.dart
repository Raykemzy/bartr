import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/router/router.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:bartr/features/profile/presentation/widgets/bartr_dialog.dart';
import 'package:bartr/features/profile/presentation/widgets/profile_dialog_child.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileAppBar extends HookConsumerWidget {
  final BartrUser user;
  const ProfileAppBar({
    Key? key,
    required this.isUserProfile,
    required this.user,
  }) : super(key: key);

  final bool isUserProfile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ValueNotifier<String> valueChoose = useState("");
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        isUserProfile
            ? const SizedBox()
            : GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset("assets/icons/arrow-left.svg"),
                ),
              ),
        isUserProfile
            ? GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const BartrDialog(
                        child: ProfileDialogWidget(),
                      );
                    },
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 15, top: 13),
                  padding: const EdgeInsets.all(9),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset("assets/icons/menu.svg"),
                ),
              )
            : PopupMenuButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.zero,
                position: PopupMenuPosition.under,
                icon: Container(
                  margin: const EdgeInsets.only(right: 15, top: 13),
                  padding: const EdgeInsets.all(9),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset("assets/icons/menu.svg"),
                ),
                color: Colors.white,
                elevation: 20,
                enabled: true,
                onSelected: (String value) {
                  valueChoose.value = value;
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: "first",
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text("Report User"),
                    ),
                    onTap: () {
                      context.router.push(ReportUserViewRoute(user: user));
                    },
                  ),
                ],
              ),
      ],
    );
  }
}
