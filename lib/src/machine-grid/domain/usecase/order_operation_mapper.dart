import '../../data/dto/new/order_operation_dto.dart';
import '../model/order_operation.dart';
import 'machine_mapper.dart';

class OrderOperationMapper {
  static OrderOperation fromOrderOperationDto(
    OrderOperationDto orderOperationDto,
  ) {
    return OrderOperation(
      id: orderOperationDto.orderOperationId,
      operationNumber: orderOperationDto.operationNumber,
      startDate: orderOperationDto.startDate,
      endDate: orderOperationDto.endDate,
      nextMachine: MachineMapper.fromMachineDTO(orderOperationDto.nextMachine),
      previousMachine:
          MachineMapper.fromMachineDTO(orderOperationDto.previousMachine),
    );
  }

  static OrderOperationDto toOrderOperationDto(
    OrderOperation orderOperation,
  ) {
    return OrderOperationDto(
      orderOperationId: orderOperation.id,
      operationNumber: orderOperation.operationNumber,
      startDate: orderOperation.startDate,
      endDate: orderOperation.endDate,
      nextMachine: MachineMapper.toMachineDTO(orderOperation.nextMachine),
      previousMachine:
          MachineMapper.toMachineDTO(orderOperation.previousMachine),
    );
  }
}
