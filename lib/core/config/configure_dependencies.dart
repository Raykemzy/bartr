import 'package:bartr/core/services/local_database/abstract_class_hivestorage.dart';
import 'package:bartr/core/services/local_database/local_db.dart';
import 'package:bartr/core/services/network/auth_strings.dart';
import 'package:bartr/core/services/network/firebase_client.dart';
import 'package:bartr/core/services/network/rest_client.dart';
import 'package:bartr/features/login/domain/models/login_model.dart';
import 'package:bartr/features/profile/data/repositories/user_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/repositories/user_repository.dart';
import '../helpers/interceptors.dart';
import '../services/local_database/hive_keys.dart';

final dio = Provider<Dio>(
  (ref) {
    final dio = Dio();
    dio.options.baseUrl = AuthStrings.baseUrl;
    dio.options.headers = {
      'Content-Type': 'application/json',
      "accept": 'application/json'
    };
    dio.interceptors.add(
      AppInterceptor(
        dio: dio,
        userRepository: UserRepositoryImpl(
          HiveStorage(Hive.box(HiveKeys.appBox)),
          RestClient(dio),
          ref,
        ),
      ),
    );
    return dio;
  },
);
final firebaseDio = Provider<Dio>(
  (ref) {
    final dio = Dio();
    dio.options.baseUrl = AuthStrings.fcmUrl;
    dio.options.headers = {
      'Content-Type': 'application/json',
      "Authorization": 'key= ${AuthStrings.serverKey}'
    };
    return dio;
  },
);
final firebaseClient =
    Provider<FirebaseClient>((ref) => FirebaseClient(ref.read(firebaseDio)));
final restClient = Provider<RestClient>((ref) => RestClient(ref.read(dio)));
final userRepository = Provider<UserRepository>(
  (ref) => UserRepositoryImpl(ref.read(localDb), ref.read(restClient), ref),
);
final localDb =
    Provider<AbstractHive>((ref) => HiveStorage(Hive.box(HiveKeys.appBox)));
final currentUserProvider = StateProvider<BartrUser>((_) {
  return _.read(userRepository).getUser();
});
