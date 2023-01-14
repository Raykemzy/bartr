import 'package:bartr/core/services/local_database/local_db.dart';
import 'package:bartr/features/login/data/repository.dart';
import 'package:bartr/features/profile/data/repositories/user_repository_impl.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([
  MockSpec<HiveStorage>(),
  MockSpec<UserRepositoryImpl>(),
  MockSpec<LoginRepositoryImpl>()
])
class Mocks {}
