import 'package:hive_flutter/hive_flutter.dart';
import 'package:smartproduction_planorama/common/constants.dart';
import 'package:smartproduction_planorama/common/toJson.abstract.dart';

part 'machine_image_location_dto.g.dart';

@HiveType(typeId: HiveTypeIds.machineCardDto)
class MachineImageLocationDto extends HiveObject implements JsonSerializable{

  @HiveField(0)
  String imagesLocationPath;

  @HiveField(1)
  String fileId;

  MachineImageLocationDto({required this.imagesLocationPath, required this.fileId});

  @override
  factory MachineImageLocationDto.fromJson(Map<String, dynamic> json) {
    return MachineImageLocationDto(
      imagesLocationPath: json['imagesLocationPath'],
      fileId: json['fileId']
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'imagesLocationPath': imagesLocationPath,
      'fileId': fileId,
    };
  }

}