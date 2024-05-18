import 'package:smartproduction_planorama/common/toJson.abstract.dart';
import 'package:smartproduction_planorama/src/machine-grid/data/dto/remote/machine_db_upload_dto.dart';

import 'machine_image_upload_dto.dart';

class MachineUploadDto extends JsonSerializable {
  final MachineDbUploadDto metaMachine;
  final MachineImageUploadDto image;

  MachineUploadDto({
    required this.metaMachine,
    required this.image,
  });

  factory MachineUploadDto.fromJson(Map<String, dynamic> json) {
    return MachineUploadDto(
      image: MachineImageUploadDto.fromJson(json['image']),
      metaMachine: MachineDbUploadDto.fromJson(json['metaMachine']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'image': image.toJson(),
      'metaMachine': metaMachine.toJson(),
    };
  }
}
