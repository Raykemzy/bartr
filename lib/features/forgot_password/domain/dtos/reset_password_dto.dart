import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'reset_password_dto.g.dart';

@JsonSerializable()
class ResetPasswordDto extends Equatable {
  final String code;
  final String password;
  const ResetPasswordDto({
    required this.code,
    required this.password,
  });

  factory ResetPasswordDto.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordDtoToJson(this);

  @override
  List<Object?> get props => throw UnimplementedError();
}
