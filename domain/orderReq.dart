import 'orderItem.dart';

enum OrderStatus { pending, accepted, rejected, cancelled, completed }

class OrderReq {
  final String id;
  final String depotId;
  String? deliveryId;
  DateTime deliveryDate;
  OrderStatus status;
  final DateTime createdAt;

  OrderReq({
    required this.id,
    required this.depotId,
    this.deliveryId,
    DateTime? deliveryDate,
    required this.status,
    DateTime? createdAt,
  })  : deliveryDate = deliveryDate ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now();
}

