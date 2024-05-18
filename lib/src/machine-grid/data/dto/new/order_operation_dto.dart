import 'package:smartproduction_planorama/src/machine-grid/data/dto/new/machine_dto.dart';

import '../../../../../common/toJson.abstract.dart';

class OrderOperationDto implements JsonSerializable {
  final String orderOperationId;
  final int operationNumber;
  final DateTime startDate;
  final DateTime endDate;
  final MachineDTO nextMachine;
  final MachineDTO previousMachine;

  OrderOperationDto({
    required this.orderOperationId,
    required this.operationNumber,
    required this.startDate,
    required this.endDate,
    required this.nextMachine,
    required this.previousMachine,
  });

  factory OrderOperationDto.fromJson(Map<String, dynamic> json) {
    return OrderOperationDto(
      orderOperationId: json['orderOperationId'],
      operationNumber: json['operationNumber'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      nextMachine: MachineDTO.fromJson(json['nextMachine']),
      previousMachine: MachineDTO.fromJson(json['previousMachine']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'orderOperationId': orderOperationId,
      'operationNumber': operationNumber,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'nextMachine': nextMachine.toJson(),
      'previousMachine': previousMachine.toJson(),
    };
  }
}
