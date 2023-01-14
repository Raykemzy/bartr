import 'package:bartr/core/router/routes.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/features/home/presentation/widgets/bartr_searchbar.dart';
import 'package:bartr/features/search/presentation/notifier/search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchAppBarTitle extends ConsumerStatefulWidget {
  const SearchAppBarTitle({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchAppBarTitle> createState() => _SearchAppBarTitleState();
}

class _SearchAppBarTitleState extends ConsumerState<SearchAppBarTitle> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.read(searchNotifier.notifier);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
            ref.invalidate(searchNotifier);
            context.router.pop();
          },
          child: SvgPicture.asset(
            "assets/icons/arrow_back.svg",
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Hero(
            tag: "search",
            child: SearchBar(
              onChanged: (val) {
                if (val!.isNotEmpty) {
                  model.searchPosts(val);
                } else {
                  model.clearSearch();
                }
              },
              suffix: GestureDetector(
                onTap: () {
                  _searchController.clear();
                  model.clearSearch();
                },
                child: SvgPicture.asset(
                  "assets/icons/close-circle.svg",
                  fit: BoxFit.scaleDown,
                ),
              ),
              hintText: "@username or item name",
              height: 40,
              autoFocus: true,
              margin: EdgeInsets.zero,
            ),
          ),
        ),
        if (FocusScope.of(context).hasFocus)
          GestureDetector(
            onTap: () {
              setState(() {
                FocusScope.of(context).unfocus();
              });
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Cancel",
                  style: Styles.w500(
                    size: 12,
                    color: BartrColors.primaryLight,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
