import 'package:smartproduction_planorama/src/machine-grid/domain/entitis/machine_model.dart';

class OrderOperation {
  final String id;
  final int operationNumber;
  final DateTime startDate;
  final DateTime endDate;
  final Machine nextMachine;
  final Machine previousMachine;

  OrderOperation({
    required this.id,
    required this.operationNumber,
    required this.startDate,
    required this.endDate,
    required this.nextMachine,
    required this.previousMachine,
  });
}
