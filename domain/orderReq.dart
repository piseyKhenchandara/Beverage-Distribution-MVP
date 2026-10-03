import 'orderItem.dart';

enum OrderStatus { pending, accepted, rejected, cancelled, completed }

class OrderReq {
  final String id;
  final String depotId;
  String? deliveryId;
  DateTime deliveryDate;
  OrderStatus status;

  

  OrderReq({
    required this.id,
    required this.depotId,
    this.deliveryId,
    DateTime? deliveryDate,
    required this.status,
    
  }) : deliveryDate = deliveryDate ?? DateTime.now();
}

