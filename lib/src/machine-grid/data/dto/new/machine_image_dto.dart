import 'package:hive/hive.dart';
import 'package:smartproduction_planorama/common/toJson.abstract.dart';

import '../../../../../common/constants.dart';

part 'machine_image_dto.g.dart';

@HiveType(typeId: HiveTypeIds.machineCardDto)
class MachineImageDto implements JsonSerializable {
  @HiveField(0)
  final String machineId;
  @HiveField(1)
  final String imageId;
  @HiveField(2)
  final String imageLocalPath;

  MachineImageDto({
    required this.imageId,
    required this.imageLocalPath,
    required this.machineId,
  });

  factory MachineImageDto.fromJson(Map<String, dynamic> json) {
    return MachineImageDto(
      machineId: json['\$id'],
      imageId: json['imageId'],
      imageLocalPath: json['imageLocalPath'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'imageId': imageId,
      'imageLocalPath': imageLocalPath,
      'machineId': machineId,
    };
  }
}
