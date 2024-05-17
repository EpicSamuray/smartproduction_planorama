import 'package:hive/hive.dart';

import '../common/logging.dart';
import '../src/machine-grid/data/dto/new/machine_image_location_dto.dart';

final Logging log = Logging('machine.repository.dart');

class MachineRepository {
  late Box<MachineImageLocationDto> machineCardDtoBox;

  Future<Box> openBox() async {
    final box =
        await Hive.openBox<MachineImageLocationDto>('machineCardDtoBox');
    machineCardDtoBox = box;
    log.logInfo('Machine Card Dto Box opened');
    return box;
  }

  List<MachineImageLocationDto> getAllMachineCardDto() {
    return machineCardDtoBox.values.toList();
  }

  void addMachineCardDto(MachineImageLocationDto machineCardDto) {
    machineCardDtoBox.add(machineCardDto);
  }

  void removeMachineCardDto(MachineImageLocationDto machineCardDto) {
    machineCardDtoBox.delete(machineCardDto.key);
  }

  Future<List<MachineImageLocationDto>> searchMachineCardDto(
      String fieldName, dynamic searchValue) async {
    return Future.delayed(Duration.zero, () {
      return machineCardDtoBox.values.where((element) {
        switch (fieldName) {
          case 'imagesLocationPath':
            return element.imagesLocationPath == searchValue;
          case 'imageId':
            return element.fileId == searchValue;
          default:
            return false;
        }
      }).toList();
    });
  }
}
