import 'package:ecommerce_b2b/domain/enum.dart';
import 'package:ecommerce_b2b/domain/order_item.dart';
import 'package:ecommerce_b2b/repository/delivery_repository.dart';
import 'package:ecommerce_b2b/repository/depot_repository.dart';
import 'package:ecommerce_b2b/repository/order_item_repository.dart';
import 'package:ecommerce_b2b/repository/order_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../domain/depot.dart';
import '../domain/order_req.dart';

class OrderService extends ChangeNotifier {
  final OrderRepository _orderRepository;
  final OrderitemRepository _orderItemRepository;
  final DepotRepository _depotRepository;
  final DeliveryRepository _deliveryRepository;

  OrderService({
    required OrderRepository orderRepository,
    required OrderitemRepository orderItemRepository,
    required DepotRepository depotRepository,
    required DeliveryRepository deliveryRepository,
  }) : _orderRepository = orderRepository,
       _orderItemRepository = orderItemRepository,
       _depotRepository = depotRepository,
       _deliveryRepository = deliveryRepository;

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

    notifyListeners();
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
    notifyListeners();
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

    checkOrder.status = OrderStatus.assigned;
    _orderRepository.update(checkOrder);
    notifyListeners();
  }

  void assignDriver(String depotManagerId, OrderReq order) {
    final checkOrder = _orderRepository.findById(order.id);
    if (checkOrder == null) throw Exception("Order ${order.id} not found");

    if (checkOrder.status != OrderStatus.accepted)
      throw Exception("Assignment allowed only for accepted orders");

    final checkDepot = _depotRepository.findById(checkOrder.depotId);
    if (checkDepot == null)
      throw Exception("Depot ${checkOrder.depotId} not found");

    if (checkDepot.managerId != depotManagerId)
      throw Exception("You are not allowed to assign driver for this order");

    checkOrder.status = OrderStatus.assigned;
    _orderRepository.update(checkOrder);
    notifyListeners();
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
    notifyListeners();
  }

  List<OrderReq> getOrders() {
    return _orderRepository.orders;
  }

  List<OrderReq> getByDeliveryId(String deliveryId) {
    return _orderRepository.findByDeliveryId(deliveryId);
  }

/*   List<OrderReq>? getByDeliveryId(String deliveryId) {
    final orders = _orderRepository.findByDeliveryId(deliveryId);
    return orders;
  } */
}
