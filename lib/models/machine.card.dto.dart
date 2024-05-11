import 'package:hive/hive.dart';
import 'package:smartproduction_planorama/common/constants.dart';

@HiveType(typeId: HiveTypeIds.machineCardDto)
class MachineCardDto extends HiveObject{

  @HiveField(0)
  String? imagesLocationPath;

  @HiveField(1)
  String? machineName;

  @HiveField(2)
  String? imageId;

}