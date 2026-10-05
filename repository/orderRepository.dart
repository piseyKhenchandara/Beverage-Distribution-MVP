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
    if (findById(order.id) != null) {
      throw Exception("order : ${order.id} already existed");
    }
    _orders.add(order);
  }


  void update(OrderReq order) {
    final findOrderId = _orders.indexWhere((o) => o.id == order.id);
    if (findOrderId == -1)
      throw Exception("order : ${order.id} not found, can't not update");

    _orders[findOrderId] = order;
  }


  List<OrderReq> findByDepotId({required String depotId}) {
    final orders = _orders.where((order) => order.depotId == depotId).toList();

    if (orders.isEmpty) throw Exception("No orders for depot $depotId");
    return orders;
  }
  



  List<OrderReq> get orders => List.unmodifiable(_orders);
}
