
import 'package:bartr/core/utils/enums.dart';

class FilterPostDto {
  final String category;
  final String country;
  final PostType postType;
  FilterPostDto({
    required this.category,
    required this.country,
    required this.postType,
  });
}
