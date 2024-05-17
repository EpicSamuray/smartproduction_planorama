import 'package:hive/hive.dart';

import '../../../../../common/constants.dart';

@HiveType(typeId: HiveTypeIds.machineCardDto)
class MachineImageDto {
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

  Map<String, dynamic> toJson() {
    return {
      'imageId': imageId,
      'imageLocalPath': imageLocalPath,
      'machineId': machineId,
    };
  }
}
