import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../features/messages/domain/dtos/notification_dto.dart';
part 'firebase_client.g.dart';

@RestApi()
abstract class FirebaseClient {
  factory FirebaseClient(Dio dio, {String baseUrl}) = _FirebaseClient;

  @POST('')
  Future sendNotification({
    @Body() required NotficationDto notificationDto,
  });
}
