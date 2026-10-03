import 'package:ecommerce_b2b/data/data.dart';
import 'package:ecommerce_b2b/domain/orderReq.dart';

class OrderRepository {
  final List<OrderReq> _orders = [];


  OrderReq? findById(String id) {
    try {
      return _orders.firstWhere((o) => o.id == id);
    } catch (_) {
      return null;
    }
  }

  void save(OrderReq order) {
    _orders.add(order);
  }

  List<OrderReq> findByDepotId({required String depotId}) {
    try{
      final listOrder = _orders.where((order) => order.depotId == depotId).where();

    }
  }


}
