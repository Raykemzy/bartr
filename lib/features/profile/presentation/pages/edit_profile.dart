import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/profile/presentation/widgets/edit_password.dart';
import 'package:bartr/features/profile/presentation/widgets/edit_profile_listview.dart';
import 'package:bartr/features/profile/presentation/widgets/edit_profile_tab.dart';
import 'package:bartr/general_widgets/bartr_scaffold.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  int currentIndex = 0;
  void changeIndex(int newIndex) {
    setState(() {
      currentIndex = newIndex;
    });
  }

  List<Widget> children = const [
    EditProfileListView(),
    EditPasswordView(),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BartrScaffold(
        appbar: AppBar(
          title: Text(
            "Edit Profile",
            style: Styles.w500(
              size: 16,
              color: BartrColors.black,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Column(
            children: [
              AppTabBar(
                title1: "Profile",
                title2: "Password",
                changeIndex0: changeIndex, // model.changeIndex,
                changeIndex1: changeIndex, // model.changeIndex,
                currentIndex: currentIndex, //state.currentIndex,
              ),
              Expanded(
                child: PageView.builder(
                  itemCount: children.length,
                  onPageChanged: (value) {
                    changeIndex(value);
                  },
                  itemBuilder: (context, index) {
                    return children[currentIndex];
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
