import 'package:smartproduction_planorama/src/machine-grid/domain/entitis/production_order.dart';

import '../../data/dto/new/production_order_dto.dart';

class ProductionOrderMapper {
  static ProductionOrder fromProductionOrderDTO(
      ProductionOrderDto productionOrderDTO) {
    return ProductionOrder(
      id: productionOrderDTO.productionOrderId,
      wea: productionOrderDTO.wea,
      description: productionOrderDTO.description,
      quantity: productionOrderDTO.quantity,
      customerAppointmentDate: productionOrderDTO.customerAppointmentDate,
      startDate: productionOrderDTO.startDate,
    );
  }

  static ProductionOrderDto toProductionOrderDTO(
      ProductionOrder productionOrder) {
    return ProductionOrderDto(
      productionOrderId: productionOrder.id,
      wea: productionOrder.wea,
      description: productionOrder.description,
      quantity: productionOrder.quantity,
      customerAppointmentDate: productionOrder.customerAppointmentDate,
      startDate: productionOrder.startDate,
    );
  }
}
