import 'dart:io';
import 'package:bartr/core/config/exception/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class BartrImagePicker {
  Future<void> pickImage({
    required ImageSource source,
    required ValueNotifier<List<File>> images,
  }) async {
    try {
      final imagePicker = ImagePicker();
      final image = await imagePicker.pickImage(source: source);
      images.value = [File(image!.path)].take(1).toList();
    } catch (e) {
      debugLog(e);
      return;
    }
  }

  Future<void> pickMultiImage({
    required ImageSource source,
    required ValueNotifier<List<File>> images,
  }) async {
    final imagePicker = ImagePicker();
    try {
      if (source == ImageSource.camera) {
        final image = await imagePicker.pickImage(source: ImageSource.camera);
        images.value = [File(image!.path)].take(1).toList();
        return;
      }

      final image = await imagePicker.pickMultiImage();
      var newImage = image.length > 7
          ? image.map((e) => File(e.path)).toList()
          : image.map((e) => File(e.path)).take(6).toList();
      images.value = [...images.value, ...newImage];
    } catch (e) {
      debugLog(e);
      return;
    }
  }
}

final imagePickerService = Provider((_) => BartrImagePicker());
