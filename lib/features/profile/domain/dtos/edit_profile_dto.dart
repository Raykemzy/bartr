import 'dart:io';

class EditProfileDto {
  final String name;
  final String username;
  final String country;
  final File? profilePicture;
  EditProfileDto({
    required this.name,
    required this.username,
    required this.country,
     this.profilePicture,
  });
}
