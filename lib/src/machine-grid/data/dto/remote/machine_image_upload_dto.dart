import 'dart:typed_data';

import 'package:smartproduction_planorama/common/toJson.abstract.dart';

class MachineImageUploadDto extends JsonSerializable {
  final String imageName;
  final Uint8List image;

  MachineImageUploadDto({
    required this.imageName,
    required this.image,
  });

  factory MachineImageUploadDto.fromJson(Map<String, dynamic> json) {
    return MachineImageUploadDto(
      imageName: json['imageName'],
      image: json['image'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'imageName': imageName,
      'image': image,
    };
  }
}
