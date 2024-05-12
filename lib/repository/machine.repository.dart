import 'package:hive/hive.dart';

import '../common/logging.dart';
import '../models/machine.card.dto.dart';

final Logging log = Logging('machine.repository.dart');


class MachineRepository {
  late Box<MachineCardDto> machineCardDtoBox;

  Future<void> openBox() async {
    machineCardDtoBox = await Hive.openBox<MachineCardDto>('machineCardDtoBox');
    log.logInfo('Machine Card Dto Box opened');
  }

  List<MachineCardDto> getAllMachineCardDto() {
    return machineCardDtoBox.values.toList();
  }

  void addMachineCardDto(MachineCardDto machineCardDto) {
    machineCardDtoBox.add(machineCardDto);
  }

  void removeMachineCardDto(MachineCardDto machineCardDto) {
    machineCardDtoBox.delete(machineCardDto.key);
  }


  List<MachineCardDto> searchMachineCardDto(String fieldName, dynamic searchValue) {
    return machineCardDtoBox.values.where((element) {
      switch(fieldName) {
        case 'imagesLocationPath':
          return element.imagesLocationPath == searchValue;
        case 'machineName':
          return element.machineName == searchValue;
        case 'imageId':
          return element.imageId == searchValue;
        default:
          return false;
      }
    }).toList();
  }

}