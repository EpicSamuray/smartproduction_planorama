import 'package:hive_flutter/hive_flutter.dart';
import 'package:smartproduction_planorama/common/constants.dart';

part 'machine.card.dto.g.dart';

@HiveType(typeId: HiveTypeIds.machineCardDto)
class MachineCardDto extends HiveObject{

  @HiveField(0)
  String imagesLocationPath;

  @HiveField(1)
  String machineName;

  @HiveField(2)
  String imageId;

  MachineCardDto({required this.imagesLocationPath, required this.machineName, required this.imageId});

}