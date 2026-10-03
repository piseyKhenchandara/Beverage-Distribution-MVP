enum DeliveryStatus { pending, accepted, delivered, completed }

class DeliveryOrder {
  final String id;
  final String managerId;
  String? driverId;
  final DateTime createdAt;
  DateTime? assignedAt;
  DateTime? completedAt;
  DeliveryStatus status;

  DeliveryOrder({
    required this.id,
    required this.managerId,
    required this.status,
    DateTime? createdAt,
    this.driverId,
    this.assignedAt,
    this.completedAt,
  }) : createdAt = createdAt ?? DateTime.now();
}
