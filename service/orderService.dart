import 'package:ecommerce_b2b/domain/orderItem.dart';
import 'package:ecommerce_b2b/repository/depot_Repository.dart';
import 'package:ecommerce_b2b/repository/orderItem_repository.dart';
import 'package:ecommerce_b2b/repository/orderRepository.dart';
import 'package:uuid/uuid.dart';
import '../domain/depot.dart';
import '../domain/orderReq.dart';

class OrderService {
  final OrderRepository _orderRepository;
  final OrderitemRepository _orderItemRepository;
  final DepotRepository _depotRepository;

  OrderService({
    required OrderRepository orderRepository,
    required OrderitemRepository orderItemRepository,
    required DepotRepository depotRepository,
  }) : _orderRepository = orderRepository,
       _orderItemRepository = orderItemRepository,
       _depotRepository = depotRepository;

  OrderReq createOrder({
    required String depotId,
    required List<OrderItem> items,
    required DateTime deliveryDate,
  }) {
    final validItems = items.where((item) => item.quantity > 0).toList();
    if (validItems.isEmpty) throw Exception("Order must contain 1 items");


    final order = OrderReq(
      id: const Uuid().v4(),
      depotId: depotId,
      deliveryDate: deliveryDate,
      status: OrderStatus.pending,
    );

    _orderRepository.save(order);

    for (final validItem in validItems) {
      final item = OrderItem(
        id: const Uuid().v4(),
        orderReqId: order.id,
        productId: validItem.productId,
        quantity: validItem.quantity,
      );
      _orderItemRepository.save(item);
    }

    return order;
  }



  void cancelOrder({required String depotId, required String orderReqId}) {
    final checkOrderReq = _orderRepository.findById(orderReqId);

    if (checkOrderReq == null)
      throw Exception(" order ${orderReqId} not found");

    if (checkOrderReq.depotId != depotId)
      throw Exception("you are not allowed to removed this order");

    if (checkOrderReq.status == OrderStatus.completed)
      throw Exception("can not cancel order is completed");

    final cancelled = OrderStatus.cancelled;
    checkOrderReq.status = cancelled;
    _orderRepository.update(checkOrderReq);
  }




  void accepted(String depotManagerId, OrderReq order) {
    final checkOrder = _orderRepository.findById(order.id);

    if (checkOrder == null) throw Exception("Order ${order.id} not found");

    if (checkOrder.status != OrderStatus.pending)
      throw Exception("acceptation allow only for pending status");

    final checkDepot = _depotRepository.findById(checkOrder.depotId);
    if (checkDepot == null)
      throw Exception("depot : ${checkOrder.depotId} not found");

    if (checkDepot.managerId != depotManagerId)
      throw Exception("You are not allowed to rejected this order");

    checkOrder.status = OrderStatus.accepted;
    _orderRepository.update(checkOrder);
  }





  void rejected(String depotManagerId, OrderReq order) {
    final checkOrder = _orderRepository.findById(order.id);

    if (checkOrder == null) throw Exception("Order ${order.id} not found");

    if (checkOrder.status != OrderStatus.pending)
      throw Exception("Order: ${order.id} accept only pending status");

    final checkDepot = _depotRepository.findById(checkOrder.depotId);
    if (checkDepot == null)
      throw Exception("depot : ${checkOrder.depotId} not found");

    if (checkDepot.managerId != depotManagerId)
      throw Exception("You are not allowed to rejected this order");

    checkOrder.status = OrderStatus.rejected;
    _orderRepository.update(checkOrder);
  }



  List<OrderReq> getOrders() {
    return _orderRepository.orders;
  }
}
