import 'dart:typed_data';

import 'package:smartproduction_planorama/common/toJson.abstract.dart';

class MachineImageUploadDto extends JsonSerializable {
  final Uint8List image;

  MachineImageUploadDto({
    required this.image,
  });

  factory MachineImageUploadDto.fromJson(Map<String, dynamic> json) {
    return MachineImageUploadDto(
      image: json['image'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'image': image,
    };
  }
}
