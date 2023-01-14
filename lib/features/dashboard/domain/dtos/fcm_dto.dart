import 'dart:convert';

class FcmTokenDto {
  final String fcmToken;
  final String userId;
  FcmTokenDto({
    required this.fcmToken,
    required this.userId,
  });

  FcmTokenDto copyWith({
    String? fcmToken,
    String? userId,
  }) {
    return FcmTokenDto(
      fcmToken: fcmToken ?? this.fcmToken,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'fcmToken': fcmToken,
      'userId': userId,
    };
  }

  factory FcmTokenDto.fromMap(Map<String, dynamic> map) {
    return FcmTokenDto(
      fcmToken: map['fcmToken'] as String,
      userId: map['userId'] as String,
    );
  }

  factory FcmTokenDto.fromJson(String source) =>
      FcmTokenDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FcmTokenDto(fcmToken: $fcmToken, userId: $userId)';

  @override
  bool operator ==(covariant FcmTokenDto other) {
    if (identical(this, other)) return true;

    return other.fcmToken == fcmToken && other.userId == userId;
  }

  @override
  int get hashCode => fcmToken.hashCode ^ userId.hashCode;
}
