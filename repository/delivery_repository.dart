import 'package:ecommerce_b2b/domain/delivery_order.dart';

class DeliveryRepository {
  final List<DeliveryOrder> _deliveries = [];
  int _count = 0;

  int get nextNumber => ++_count;

  void save(DeliveryOrder delivery) {
    _deliveries.add(delivery);
  }

  DeliveryOrder? findById(String id) {
    try {
      return _deliveries.firstWhere((d) => d.id == id);
    } catch (_) {
      return null;
    }
  }

  /*   List<DeliveryOrder> findByOrderId(String orderId) {
    return _deliveries.where((d) => d.id == orderId).toList();
  } */

  List<DeliveryOrder> findByDriverID(String driverId) {
    return _deliveries.where((d) => d.driverId == driverId).toList();
  }

  List<DeliveryOrder> get getAll => List.unmodifiable(_deliveries);

  void update(DeliveryOrder del) {
    final delivery = _deliveries.indexWhere(
      (delivery) => delivery.id == del.id,
    );
    if (delivery == -1)
      throw Exception("delivery : ${del.id} not found, can't not update");

    _deliveries[delivery] = del;
  }
}
