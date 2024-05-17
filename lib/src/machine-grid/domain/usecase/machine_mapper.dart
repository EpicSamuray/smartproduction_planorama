import 'package:smartproduction_planorama/src/machine-grid/data/dto/new/machine_image_dto.dart';
import 'package:smartproduction_planorama/src/machine-grid/domain/model/machine_model.dart';

import '../../data/dto/new/machine_dto.dart';

class MachineMapper {
  static Machine fromMachineDTO(MachineDTO machineDTO) {
    return Machine(
      id: machineDTO.machineId,
      name: machineDTO.name,
      category: machineDTO.category,
      location: machineDTO.location,
      capacity: machineDTO.capacity,
    );
  }

  static MachineDTO toMachineDTO(Machine machine) {
    return MachineDTO(
      machineId: machine.id,
      name: machine.name,
      category: machine.category,
      location: machine.location,
      capacity: machine.capacity,
    );
  }

  static void updateFromImageMachineDto(
      MachineImageDto machineImageDto, Machine machine) {
    if (machineImageDto.machineId != machine.id) {
      throw Exception('Machine id does not match');
    }
    machine.updateImageInformation(
        machineImageDto.imageLocalPath, machineImageDto.imageId);
  }
}
