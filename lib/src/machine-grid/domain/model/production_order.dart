import 'order_operation.dart';

class ProductionOrder {
  final String id;
  final String wea;
  final String description;
  List<OrderOperation>? op;
  final int quantity;
  final DateTime customerAppointmentDate;
  late final DateTime deliveryDate;
  final DateTime startDate;

  ProductionOrder({
    required this.id,
    required this.wea,
    required this.description,
    this.op,
    required this.quantity,
    required this.customerAppointmentDate,
    required this.startDate,
  }) {
    deliveryDate = customerAppointmentDate;
  }

  void addOperation(OrderOperation operation) {
    op?.add(operation);
  }
}
