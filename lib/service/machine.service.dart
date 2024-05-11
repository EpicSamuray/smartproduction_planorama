import 'package:hive/hive.dart';

import '../models/machine.card.dto.dart';

class MachineService {
  final Box<MachineCardDto> machineCardDtoBox;

  MachineService(this.machineCardDtoBox);

  List<MachineCardDto> getAllMachineCardDto() {
    return machineCardDtoBox.values.toList();
  }

  void addMachineCardDto(MachineCardDto machineCardDto) {
    machineCardDtoBox.add(machineCardDto);
  }

  //TODO: muss noch Validiert werden ob Verwendet wird
  void removeMachineCardDto(MachineCardDto machineCardDto) {
    machineCardDtoBox.delete(machineCardDto.key);
  }
}