// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterDto _$RegisterDtoFromJson(Map<String, dynamic> json) => RegisterDto(
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      username: json['username'] as String,
      country: json['country'] as String,
    );

Map<String, dynamic> _$RegisterDtoToJson(RegisterDto instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'email': instance.email,
      'password': instance.password,
      'username': instance.username,
      'country': instance.country,
    };

VerifyEmailDto _$VerifyEmailDtoFromJson(Map<String, dynamic> json) =>
    VerifyEmailDto(
      code: json['code'] as String,
    );

Map<String, dynamic> _$VerifyEmailDtoToJson(VerifyEmailDto instance) =>
    <String, dynamic>{
      'code': instance.code,
    };

ResendCodeDto _$ResendCodeDtoFromJson(Map<String, dynamic> json) =>
    ResendCodeDto(
      email: json['email'] as String,
    );

Map<String, dynamic> _$ResendCodeDtoToJson(ResendCodeDto instance) =>
    <String, dynamic>{
      'email': instance.email,
    };
