import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/helpers/helper_functions.dart';
import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/validations.dart';
import 'package:bartr/features/create_post/presentation/widgets/post_description_texfield.dart';
import 'package:bartr/features/create_post/presentation/widgets/post_image_picker.dart';
import 'package:bartr/features/make_a_bid/domain/dtos/make_a_bid_dto.dart';
import 'package:bartr/features/make_a_bid/presentation/notifier/make_a_bid_notifier.dart';
import 'package:bartr/features/make_a_bid/presentation/notifier/make_a_bid_state.dart';
import 'package:bartr/general_widgets/app_button.dart';
import 'package:bartr/general_widgets/bartr_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MakeABid extends StatefulHookConsumerWidget {
  const MakeABid({required this.bidId, Key? key}) : super(key: key);
  final String bidId;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MakeABidState();
}

final _decriptionController = TextEditingController();
final _itemNameController = TextEditingController();
final _formKey = GlobalKey<FormState>();
bool isEnabled = false;

class _MakeABidState extends ConsumerState<MakeABid> {
  @override
  Widget build(BuildContext context) {
    ValueNotifier<List<File>> images = useState([]);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 80),
          child: Text(
            "Make a Bid",
            style: TextStyle(color: Colors.black),
            // textAlign: TextAlign.center,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        onChanged: () => setState(() {
          isEnabled = _formKey.currentState!.validate();
        }),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              PostImagePicker(
                max: 1,
                images: images,
              ),
              const SizedBox(height: 40),
              BartrTextField(
                hintText: Strings.hintTextItemName,
                validateFunction: Validators.notEmpty(),
                controller: _itemNameController,
                labelSize: 14,
                label: Strings.itemName,
              ),
              const SizedBox(height: 40),
              PostDescriptionTextField(
                onChanged: (val) {
                  setState(() {});
                },
                validateFunction: Validators.notEmpty(),
                minLines: 3,
                minLength: 150,
                controller: _decriptionController,
                label: Strings.desc,
                hintText: Strings.hintTextDescription,
              ),
              const SizedBox(height: 40),
              Consumer(builder: (context, ref, child) {
                _successScreen(ref, images);
                final model = ref.read(makeAbidNotifier.notifier);
                final state = ref.watch(makeAbidNotifier);

                return AppButton(
                  text: 'Send Bid',
                  isLoading: state.makeAbidLoadState == LoadState.loading,
                  margin: EdgeInsets.zero,
                  textColor: BartrColors.white,
                  isEnabled: isEnabled && images.value.isNotEmpty,
                  onTap: () => _makeAbid(model, images),
                );
              })
            ],
          ),
        ),
      )),
    );
  }

  void _makeAbid(MakeAbidNotifier bidModel, ValueNotifier<List<File>> images) {
    bidModel.makeAbid(
      data: MakeAbidDto(
        itemName: _itemNameController.text,
        itemDescription: _decriptionController.text,
        itemPicture: images.value,
        bidId: widget.bidId,
      ),
    );
  }

  void _successScreen(WidgetRef ref, ValueNotifier<List<File>> images) {
    ref.listen<MakeAbidState>(makeAbidNotifier, (previous, next) {
      if (next.makeAbidLoadState == LoadState.success) {
        context.router.push(const BidSentSuccessScreenRoute());
        return;
      } else if (next.makeAbidLoadState == LoadState.error) {
        showError(text: next.errorMessage, context: context);
      }
    });
  }
}
