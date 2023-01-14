import 'package:bartr/core/utils/enums.dart';
import 'package:equatable/equatable.dart';

class EditPostDto extends Equatable {
  const EditPostDto({
    this.title,
    this.description,
    this.category,
    this.postType,
    this.visibility,
    this.hours,
    this.minutes,
    this.images,
    this.status,
  });

  final String? title;
  final String? status;
  final String? description;
  final String? category;
  final PostType? postType;
  final PostVisiblility? visibility;
  final String? hours;
  final String? minutes;
  final List<String>? images;
  @override
  List<Object> get props {
    return [
      title!,
      description!,
      category!,
      postType!,
      visibility!,
      hours!,
      minutes!,
    ];
  }
}
