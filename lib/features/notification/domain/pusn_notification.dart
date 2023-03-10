// ignore_for_file: public_member_api_docs, sort_constructors_first
class PushNotification {
  final String title;
  final String body;
  PushNotification({
    required this.title,
    required this.body,
  });

  @override
  String toString() => 'PushNotification(title: $title, body: $body)';
}
