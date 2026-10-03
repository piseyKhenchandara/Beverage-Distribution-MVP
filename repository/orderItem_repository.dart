import 'package:ecommerce_b2b/domain/orderItem.dart';

class OrderitemRepository {
  List<OrderItem> _orderItems = [];

  List<OrderItem> findByOrderReqId({required String orderReqId}) {
    try {
      final orderItems = _orderItems
          .where((orderItem) => orderItem.orderReqId == orderReqId)
          .toList();

      return orderItems;
    } catch (_) {
      throw Exception(" order id: ${orderReqId} not found!");
    }
  }

  void save(OrderItem orderItem) {
    _orderItems.add(orderItem);
  }
}
