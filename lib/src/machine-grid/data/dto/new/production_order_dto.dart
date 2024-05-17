class ProductionOrderDto {
  final String productionOrderId;
  final String wea;
  final String description;
  final int quantity;
  final DateTime customerAppointmentDate;
  final DateTime startDate;

  ProductionOrderDto({
    required this.productionOrderId,
    required this.wea,
    required this.description,
    required this.quantity,
    required this.customerAppointmentDate,
    required this.startDate,
  });

  factory ProductionOrderDto.fromJson(Map<String, dynamic> json) {
    return ProductionOrderDto(
      productionOrderId: json['\$id'],
      wea: json['wea'],
      description: json['description'],
      quantity: json['quantity'],
      customerAppointmentDate: DateTime.parse(json['customerAppointmentDate']),
      startDate: DateTime.parse(json['startDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': productionOrderId,
      'wea': wea,
      'description': description,
      'quantity': quantity,
      'customerAppointmentDate': customerAppointmentDate.toIso8601String(),
      'startDate': startDate.toIso8601String(),
    };
  }
}
