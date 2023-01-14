import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/config/exception/logger.dart';
import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:new_version_plus/new_version_plus.dart';

class SplashScreen extends StatefulHookConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    _checkVersion();
    super.initState();
  }

  _checkVersion() async {
    try {
      final newVersion = NewVersionPlus();

      final status = await newVersion.getVersionStatus();
      if (status != null && status.canUpdate) {
        //TODO: add custom dialog
        newVersion.showUpdateDialog(
          context: context,
          versionStatus: status,
          allowDismissal: false,
        );
        return;
      }
      _init();
    } on Exception {
      _init();
    }
  }

  void _init() async {
    bool hasClearedCache = ref.read(userRepository).hasClearedCache();
    if (!hasClearedCache) {
      debugLog("CacheStatus : $hasClearedCache");
      ref.read(localDb).clear();
    }
    await Future.delayed(const Duration(seconds: 1), () {
      var data = ref.read(userRepository).getCurrentState();
      switch (data) {
        case CurrentState.loggedIn:
          context.router.replaceAll([const BartrDashBoardRoute()]);
          break;
        case CurrentState.onboarded:
          context.router.replace(const LoginRoute());
          break;
        case CurrentState.initial:
          context.router.replace(const LandingPageRoute());
          break;
        default:
          return context.router.replace(const LandingPageRoute());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          "assets/icons/bartrlogo.svg",
        ),
      ),
    );
  }
}
