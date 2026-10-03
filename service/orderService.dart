import 'package:ecommerce_b2b/domain/orderItem.dart';
import 'package:ecommerce_b2b/repository/orderRepository.dart';

import '../domain/depot.dart';
import '../domain/orderReq.dart';

class OrderService {
  final OrderRepository _orderRepository;

  OrderService({required OrderRepository orderRepository})
    : _orderRepository = orderRepository;




  OrderReq createOrder({
    required String depotId,
    required List<OrderItem> items,
    required DateTime deliveryDate,
  }) {
    final findOrderItems = items.where((item) => item.quantity > 0).toList();
    if (findOrderItems.isEmpty) throw Exception("Order must container 1 items");

    final order = OrderReq(
      id: DateTime.now().toString(),
      depotId: depotId,
      status: OrderStatus.pending,
      
    );

    _orderRepository.save(order);

    return order;
  }




  void cancelOrder({
    required String depotId,
    required String orderReqId,
  }) {
    final checkOrderReq = _orderRepository.findById( orderReqId);

    if (checkOrderReq == null)
      throw Exception(" order ${orderReqId} not found");
    if (checkOrderReq.depotId != depotId)
      throw Exception("you are not allowed to removed this order");

    if (checkOrderReq.status == OrderStatus.completed)
      throw Exception("can not cancel order is completed");

    final cancelled = OrderStatus.cancelled;
    checkOrderReq.status = cancelled;
    _orderRepository.save(checkOrderReq);

    
  }
}
