import 'package:smartproduction_planorama/src/machine-grid/domain/model/machine_model.dart';

class OrderOperation {
  final String id;
  final int operationNumber;
  final DateTime startDate;
  final DateTime? endDate;
  final Duration? duration;
  final Machine nextMachine;
  final Machine previousMachine;

  OrderOperation({
    required this.id,
    required this.operationNumber,
    required this.startDate,
    this.endDate,
    this.duration,
    required this.nextMachine,
    required this.previousMachine,
  }) : assert(
          (endDate != null && duration == null) ||
              (endDate == null && duration != null),
          'Either end or duration must be provided, but not both',
        );
  DateTime get calculatedEnd => endDate ?? startDate.add(duration!);
  Duration get calculatedDuration =>
      duration ?? calculatedEnd.difference(startDate);
}
