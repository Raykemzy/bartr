// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_dto.g.dart';

@JsonSerializable()
class RegisterDto extends Equatable {
  final String fullName;
  final String email;
  final String password;
  final String username;
  final String country;

  const RegisterDto({
    required this.fullName,
    required this.email,
    required this.password,
    required this.username,
    required this.country,
  });
  factory RegisterDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterDtoFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterDtoToJson(this);

  @override
  List<Object> get props => [fullName, email, password, username, country];
}

@JsonSerializable()
class VerifyEmailDto extends Equatable {
  final String code;

  const VerifyEmailDto({
    required this.code,
  });

  @override
  List<Object> get props => [code];

  factory VerifyEmailDto.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailDtoFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyEmailDtoToJson(this);
}

@JsonSerializable()
class ResendCodeDto extends Equatable {
  final String email;

  const ResendCodeDto({
    required this.email,
  });

  @override
  List<Object> get props => [email];

  factory ResendCodeDto.fromJson(Map<String, dynamic> json) =>
      _$ResendCodeDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ResendCodeDtoToJson(this);
}
