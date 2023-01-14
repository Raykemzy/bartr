// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_dto.g.dart';

@JsonSerializable()
class ForgotPasswordDto extends Equatable {
  final String email;
  const ForgotPasswordDto({
    required this.email,
  });
factory ForgotPasswordDto.fromJson(Map<String,dynamic> json)=> _$ForgotPasswordDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordDtoToJson(this);



  @override
  List<Object> get props => [email];
}
