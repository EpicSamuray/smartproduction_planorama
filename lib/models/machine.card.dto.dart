import 'package:hive_flutter/hive_flutter.dart';
import 'package:smartproduction_planorama/common/constants.dart';
import 'package:smartproduction_planorama/common/toJson.abstract.dart';

part 'machine.card.dto.g.dart';

@HiveType(typeId: HiveTypeIds.machineCardDto)
class MachineCardDto extends HiveObject implements JsonSerializable{

  @HiveField(0)
  String imagesLocationPath;

  @HiveField(1)
  String machineName;

  @HiveField(2)
  String fileId;

  MachineCardDto({required this.imagesLocationPath, required this.machineName, required this.fileId});

  @override
  factory MachineCardDto.fromJson(Map<String, dynamic> json) {
    return MachineCardDto(
      imagesLocationPath: json['imagesLocationPath'],
      machineName: json['machineName'],
      fileId: json['fileId']
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'imagesLocationPath': imagesLocationPath,
      'machineName': machineName,
      'fileId': fileId,
    };
  }

}