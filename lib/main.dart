import 'package:bartr/core/router/router.dart';
import 'package:bartr/core/utils/colors.dart';
import 'package:bartr/firebase_options.dart';
import 'package:bartr/main_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/services/local_database/hive_keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  initializeDateFormatting('az');
  await Hive.initFlutter();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.openBox(HiveKeys.appBox);
  await Hive.openBox(HiveKeys.badge);
  runApp(ProviderScope(child: BartrMobile()));
}

class BartrMobile extends StatelessWidget {
  BartrMobile({Key? key}) : super(key: key);

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return Portal(
      child: MaterialApp.router(
        title: "Bartr",
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: BartrColors.white,
            elevation: 0.5,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          primarySwatch: BartrColors.primarysWatch,
          fontFamily: "Poppins",
          scaffoldBackgroundColor: BartrColors.white,
          splashColor: BartrColors.lightGrey,
        ),
        debugShowCheckedModeBanner: false,
        routeInformationParser: appRouter.defaultRouteParser(),
        routerDelegate: appRouter.delegate(),
      ),
    );
  }
}



//flutter pub run build_runner build --delete-conflicting-outputs