import 'dart:io';
import 'package:equatable/equatable.dart';

class VerifyProfileDto extends Equatable {
  const VerifyProfileDto({
    required this.idType,
    required this.idImage,
  });

  final String idType;
  final File idImage;
  @override
  List<Object> get props {
    return [
      idType
    ];
  }
}
