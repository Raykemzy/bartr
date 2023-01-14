import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/core/utils/strings.dart';
import 'package:bartr/core/utils/textstyles.dart';
import 'package:bartr/core/utils/validations.dart';
import 'package:bartr/features/login/presentation/notifier/visibility_state.dart';
import 'package:bartr/features/login/presentation/widgets/auth_scaffold.dart';
import 'package:bartr/features/login/presentation/widgets/tandc_widget.dart';
import 'package:bartr/general_widgets/app_button.dart';
import 'package:bartr/general_widgets/bartr_textfield.dart';
import 'package:bartr/general_widgets/country_picker_field.dart';
import 'package:bartr/general_widgets/eye_toggle_widget.dart';
import 'package:bartr/general_widgets/select_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/utils/enums.dart';
import '../../domain/dtos/register_dto.dart';
import '../notifier/register_notifier.dart';
import '../notifier/register_state.dart';

class Register extends StatefulHookWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isEnabled = false;

  @override
  void initState() {
    initCountry();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  Country _selectedCountry = const Country("", 'flags/usa.png', '', '');
  void initCountry() async {
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

  @override
  Widget build(BuildContext context) {
    ValueNotifier<List<File>> images = useState([]);
    return AuthScaffold(
      title: Strings.joinB,
      child: Form(
        key: _formKey,
        onChanged: () => setState(() {
          isEnabled = _formKey.currentState!.validate();
        }),
        child: Column(
          children: [
            Center(
              child: InkWell(
                onTap: () => SelectImage.chooseImage(
                  context: context,
                  imageType: Strings.addPic,
                  imageList: images,
                  type: ImageType.single,
                ),
                child: CircleAvatar(
                  backgroundColor: BartrColors.white,
                  radius: 40,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: images.value.isEmpty
                            ? Image.asset(
                                "assets/images/avatar.png",
                                height: 80,
                                width: 100,
                                fit: BoxFit.fitHeight,
                              )
                            : Image.file(
                                File(images.value.first.path),
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 35,
                        child: Image.asset(
                          "assets/images/camera.png",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              Strings.addPic,
              textAlign: TextAlign.center,
              style: Styles.w400(
                color: BartrColors.black,
                size: 12,
              ),
            ),
            const SizedBox(height: 40.0),
            BartrTextField(
              validateFunction: Validators.name(),
              label: Strings.fullname,
              hintText: Strings.fullnameHint,
              controller: _fullNameController,
            ),
            const SizedBox(height: 40.0),
            BartrTextField(
              validateFunction: Validators.username(),
              label: Strings.username,
              hintText: Strings.usernameHint,
              controller: _usernameController,
            ),
            const SizedBox(height: 40.0),
            BartrTextField(
              validateFunction: Validators.email(),
              label: Strings.email,
              hintText: Strings.emailHint,
              controller: _emailController,
            ),
            const SizedBox(height: 40.0),
            CountryPickerField(
              country: _selectedCountry,
              onTap: _showCountryPicker,
            ),
            const SizedBox(height: 40.0),
            Consumer(
              builder: (context, ref, child) {
                final state = ref.watch(visibilityProvider);
                return BartrTextField(
                  suffixIcon: const VisibilityIcon(),
                  obscureText: !state,
                  validateFunction: Validators.password(),
                  label: Strings.password,
                  hintText: Strings.passwordHint,
                  controller: _passwordController,
                );
              },
            ),
            const SizedBox(height: 40.0),
            Consumer(
              builder: (context, ref, child) {
                final model = ref.read(registerNotifier.notifier);
                final state = ref.watch(registerNotifier);
                _navigateToVerfiyEmail(ref, context);
                return AppButton(
                  text: Strings.signUp,
                  isLoading: state.loadState == LoadState.loading,
                  isEnabled: isEnabled &&
                      images.value.isNotEmpty &&
                      _selectedCountry.name.isNotEmpty,
                  onTap: () {
                    _register(model, images);
                    // context.router.replaceAll([VerifyEmailRoute()]);
                  },
                );
              },
            ),
            if (images.value.isEmpty)
              Text(
                Strings.picError,
                textAlign: TextAlign.center,
                style: Styles.w400(
                  color: BartrColors.red,
                  size: 12,
                ),
              ),
            const SizedBox(height: 24.0),
            Text.rich(
              TextSpan(
                text: Strings.alreadyHave,
                children: [
                  TextSpan(
                    text: Strings.login,
                    style: Styles.w600(
                      color: BartrColors.primary,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.router.replace(const LoginRoute());
                      },
                  )
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            const TandCWidget(),
          ],
        ),
      ),
    );
  }

  void _register(RegisterNotifier model, ValueNotifier<List> images) {
    final data = RegisterDto(
      email: _emailController.text,
      password: _passwordController.text,
      country: _selectedCountry.name,
      fullName: _fullNameController.text,
      username: _usernameController.text,
    );
    model.register(data, File(images.value.first.path)).then((value) {
      if (value != null) {
        showError(text: value, context: context);
      }
    });
  }

  void _navigateToVerfiyEmail(WidgetRef ref, BuildContext context) {
    ref.listen<RegisterState>(registerNotifier, (previous, next) {
      if (next.loadState == LoadState.success) {
        context.router.replace(const VerifyEmailRoute());
        return;
      }
    });
  }
}
