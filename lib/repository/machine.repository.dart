import 'package:hive/hive.dart';
import 'package:smartproduction_planorama/src/machine-grid/data/dto/new/machine_image_dto.dart';

import '../common/logging.dart';

final Logging log = Logging('machine.repository.dart');

class MachineRepository {
  late Box<MachineImageDto> machineCardDtoBox;

  Future<Box> openBox() async {
    final box = await Hive.openBox<MachineImageDto>('machineCardDtoBox');
    machineCardDtoBox = box;
    log.logInfo('Machine Card Dto Box opened');
    return box;
  }

  List<MachineImageDto> getAllMachineCardDto() {
    return machineCardDtoBox.values.toList();
  }

  void addMachineCardDto(MachineImageDto machineCardDto) {
    machineCardDtoBox.add(machineCardDto);
  }

  void removeMachineCardDto(MachineImageDto machineCardDto) {
    machineCardDtoBox.delete(machineCardDto);
  }

  Future<List<MachineImageDto>> searchMachineCardDto(
      String fieldName, dynamic searchValue) async {
    return Future.delayed(Duration.zero, () {
      return machineCardDtoBox.values.where((element) {
        switch (fieldName) {
          case 'imagesLocationPath':
            return element.imageLocalPath == searchValue;
          case 'imageId':
            return element.imageId == searchValue;
          default:
            return false;
        }
      }).toList();
    });
  }
}
