import 'package:hive_flutter/hive_flutter.dart';
import 'package:smartproduction_planorama/common/constants.dart';

part 'machine_image_location_dto.g.dart';

@HiveType(typeId: HiveTypeIds.machineCardDto)
class MachineImageLocationDto extends HiveObject {
  @HiveField(0)
  String imagesLocationPath;

  @HiveField(1)
  String fileId;

  MachineImageLocationDto({
    required this.imagesLocationPath,
    required this.fileId,
  });
}
