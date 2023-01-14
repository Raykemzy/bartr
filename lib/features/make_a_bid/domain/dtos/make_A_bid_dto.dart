
// ignore_for_file: file_names

import 'dart:io';

import 'package:equatable/equatable.dart';

class MakeAbidDto extends Equatable {
  const MakeAbidDto({
    required this.itemName,
    required this.itemDescription,
    required this.itemPicture,
    required this.bidId,
  });

  final String itemName;
  final String itemDescription;
  final List<File> itemPicture;
  final String bidId;
  @override
  List<Object> get props {
    return [
      itemName,
      itemDescription,
      bidId
    ];
  }
}
