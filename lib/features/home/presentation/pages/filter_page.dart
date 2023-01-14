import 'package:bartr/core/helpers/extensions.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/features/home/domain/models/filter_post_dto.dart';
import 'package:bartr/features/home/presentation/notifier/home_notifier.dart';
import 'package:bartr/features/home/presentation/widgets/home_list_view.dart';
import 'package:bartr/features/search/presentation/widgets/no_search_results.dart';
import 'package:bartr/general_widgets/app_button.dart';
import 'package:bartr/general_widgets/bartr_scaffold.dart';
import 'package:bartr/general_widgets/batr_general_appbar.dart';
import 'package:bartr/general_widgets/country_picker_field.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/enums.dart';
import '../../../../core/utils/strings.dart';
import '../../../../general_widgets/drop_down_field.dart';

class FilterPage extends ConsumerWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.read(homeNotifier.notifier);
    final state = ref.watch(homeNotifier);
    return BartrScaffold(
      appbar: BartrAppBar(
        elevation: state.filteredPostList.isNotEmpty ? 1 : 0,
        hasLeading: true,
        title: state.filteredPostList.isNotEmpty ? "Posts" : "Filter",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () => model.resetFilter(),
              child: SvgPicture.asset(
                "assets/icons/close-circle.svg",
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ],
      ),
      child: state.searchStatus == SearchStatus.noSearch
          ? const NoSearchWidget()
          : state.searchStatus == SearchStatus.idle
              ? const FilterActionPage()
              : const FilteredPosts(),
    );
  }
}

class FilterActionPage extends ConsumerStatefulWidget {
  const FilterActionPage({Key? key}) : super(key: key);

  @override
  ConsumerState<FilterActionPage> createState() => _FilterActionPageState();
}

class _FilterActionPageState extends ConsumerState<FilterActionPage> {
  Country _selectedCountry = const Country("", 'flags/usa.png', '', '');
  void _initCountry() async {
    final country = await getDefaultCountry(context);
    setState(() {
      _selectedCountry = country;
    });
  }

  void _showCountryPicker() async {
    final country = await showCountryPickerSheet(
      context,
    );
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }

  bool isEnabled = false;
  List<String> postCategories = [
    "Arts & Crafts",
    "Books",
    "Cars",
    "Clothing",
    "Collectibles",
    "Electronics",
    "Furniture",
    "Gadgets",
    "Video Games",
    "Handmade",
    "Home, Garden & Pets",
    "Kitchen Utensils",
    "PC",
    "Power/Mechanic/Carpentry tools",
    "Toys",
    "Others",
  ];
  bool isTimed = false;

  late String postCategory;
  late PostType postType;

  @override
  void initState() {
    postCategory = "Arts & Crafts";
    postType = PostType.Barter;
    _initCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.read(homeNotifier.notifier);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
        child: Column(
          children: [
            DropDownField<String>(
              label: Strings.selectPT,
              currentValue:
                  postType == PostType.Giveaway ? "Giveaway" : "Barter",
              values: [
                PostType.Barter.name.capiTalizeFirst(),
                PostType.Giveaway.name.capiTalizeFirst(),
              ],
              onChanged: (val) {
                setState(() {
                  if (val == "Barter") {
                    postType = PostType.Barter;
                  } else {
                    postType = PostType.Giveaway;
                  }
                });
              },
            ),
            const SizedBox(height: 40.0),
            DropDownField<String>(
              label: Strings.selectCat,
              values: postCategories,
              onChanged: (val) {
                setState(() {
                  postCategory = val!;
                });
              },
            ),
            const SizedBox(height: 40.0),
            CountryPickerField(
              labelSize: 14,
              labelColor: BartrColors.black,
              country: _selectedCountry,
              onTap: _showCountryPicker,
            ),
            const SizedBox(height: 100.0),
            AppButton(
              text: "Apply filter",
              onTap: () => model.filterPost(
                FilterPostDto(
                  category: postCategory,
                  country: _selectedCountry.name,
                  postType: postType,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilteredPosts extends ConsumerStatefulWidget {
  const FilteredPosts({Key? key}) : super(key: key);

  @override
  ConsumerState<FilteredPosts> createState() => _FilteredPostsState();
}

class _FilteredPostsState extends ConsumerState<FilteredPosts> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final model = ref.read(homeNotifier.notifier);
    final state = ref.watch(homeNotifier);
    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: HomeListView(
        onDeletePost: (p0) => {},
        isLoadingMore: state.homeLoadState == LoadState.loadmore,
        scrollController: _scrollController,
        isLoading: state.homeLoadState == LoadState.loading,
        posts: state.filteredPostList,
      ),
    );
  }
}
