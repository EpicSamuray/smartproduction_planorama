import 'package:smartproduction_planorama/service/machine.service.dart';

import '../models/machine.card.dto.dart';


class MachineRepository {
  final MachineService _dataSource;

  MachineRepository(this._dataSource);

  List<MachineCardDto> getAllMachineCardDto() {
    return _dataSource.getAllMachineCardDto();
  }

  void addMachineCardDto(MachineCardDto machineCardDto) {
    _dataSource.addMachineCardDto(machineCardDto);
  }

  void removeMachineCardDto(MachineCardDto machineCardDto) {
    _dataSource.removeMachineCardDto(machineCardDto);
  }
}