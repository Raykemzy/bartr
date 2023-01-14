import 'package:bartr/core/config/configure_dependencies.dart';
import 'package:bartr/core/services/local_database/abstract_class_hivestorage.dart';
import 'package:bartr/core/services/local_database/hive_keys.dart';
import 'package:bartr/domain/repositories/user_repository.dart';
import 'package:bartr/features/dashboard/domain/dtos/fcm_dto.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/config/exception/logger.dart';

class DashboardNotifier extends StateNotifier<DashBoardState> {
  DashboardNotifier(
    this._messaging,
    this.userRepository,
    this.localStorage,
  ) : super(DashBoardState());
  final UserRepository userRepository;
  final FirebaseMessaging _messaging;
  final AbstractHive localStorage;

  int retry = 0;

  void saveFcmToken(FcmTokenDto dto) async {
    try {
      final res = await userRepository.saveFCMTokenRemotely(dto);
      if (!res.status) {
        _retrySaveFcmToken(dto);
        return;
      }
      localStorage.put(HiveKeys.hasSavedFcmTokenRemotely, true);
      userRepository.saveFCMTokenLocally(dto.fcmToken);
      debugLog(res.data);
    } catch (e) {
      _retrySaveFcmToken(dto);
    }
  }

  _retrySaveFcmToken(FcmTokenDto dto) {
    if (retry == 3) {
      retry = 0;
      return;
    }
    retry = retry++;
    saveFcmToken(dto);
  }

  void requestAndRegisterNotification() async {
    //2 IOS: create the function that is called when a notification is available

    //3 IOS: request user permission
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
      announcement: true
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugLog("User granted permission");
      await _messaging.setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );
      String? fcmToken = await _messaging.getToken();
      debugLog("User token is $fcmToken");
      var user = userRepository.getUser();
      userRepository.saveUser(user.copyWith(fcmPushToken: fcmToken ?? ""));

      String fcmTokenFromDb = userRepository.getFCMToken();

      final hasSavedTokenRemote =
          localStorage.get(HiveKeys.hasSavedFcmTokenRemotely) ?? false;
      if (!(hasSavedTokenRemote) || fcmToken != fcmTokenFromDb) {
        final user = userRepository.getUser();
        final dto = FcmTokenDto(fcmToken: fcmToken!, userId: user.id!);
        saveFcmToken(dto);
      }

      //Save fcm token to local db and server
    } else {
      debugLog("Permission denied");
    }
  }
}

class DashBoardState {}

final dashboardNotifier =
    StateNotifierProvider<DashboardNotifier, DashBoardState>(
  (ref) => DashboardNotifier(
    FirebaseMessaging.instance,
    ref.read(userRepository),
    ref.read(localDb),
  ),
);
