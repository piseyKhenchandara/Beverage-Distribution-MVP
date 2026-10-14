import 'package:ecommerce_b2b/domain/enum.dart';

class DeliveryOrder {
  final String id;
  final int number;
  final String managerId;
  String driverId;

  DateTime? assignedAt;
  DateTime? completedAt;
  DeliveryStatus status;

  static const int maxOrder = 5;

  DeliveryOrder({
    required this.id,
    required this.number,
    required this.managerId,
    required this.status,
    required this.driverId,
    this.assignedAt,
    this.completedAt,
  });
}
