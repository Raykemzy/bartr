import 'dart:io';
import 'package:bartr/core/utils/enums.dart';
import 'package:equatable/equatable.dart';

class CreatePostDto extends Equatable {
  const CreatePostDto({
    required this.title,
    required this.description,
    required this.category,
    required this.postType,
    required this.visibility,
    required this.hours,
    required this.minutes,
    required this.images,
  });

  final String title;
  final String description;
  final String category;
  final PostType postType;
  final PostVisiblility visibility;
  final String hours;
  final String minutes;
  final List<File> images;
  @override
  List<Object> get props {
    return [
      title,
      description,
      category,
      postType,
      visibility,
      hours,
      minutes,
    ];
  }
}
