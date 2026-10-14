import 'package:ecommerce_b2b/domain/delivery_order.dart';
import 'package:ecommerce_b2b/domain/driver.dart';
import 'package:ecommerce_b2b/domain/enum.dart';
import 'package:ecommerce_b2b/domain/order_req.dart';
import 'package:ecommerce_b2b/repository/delivery_repository.dart';
import 'package:ecommerce_b2b/repository/depot_repository.dart';
import 'package:ecommerce_b2b/repository/driver_repository.dart';
import 'package:ecommerce_b2b/repository/order_repository.dart';
import 'package:ecommerce_b2b/service/order_service.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class DeliveryService extends ChangeNotifier {
  final DeliveryRepository _deliveryRepository;
  final OrderRepository _orderRepository;
  final DepotRepository _depotRepository;
  final DriverRepository _driverRepository;
  final OrderService _orderService;

  DeliveryService({
    required DeliveryRepository deliveryRepository,
    required OrderRepository orderRepository,
    required DepotRepository depotRepository,
    required DriverRepository driverRepository,
    required OrderService orderService,
  }) : _deliveryRepository = deliveryRepository,
       _orderRepository = orderRepository,
       _depotRepository = depotRepository,
       _driverRepository = driverRepository,
       _orderService = orderService;

  DeliveryOrder? getById(String id) {
    return _deliveryRepository.findById(id);
  }

  void assignDriver({
    required String managerId,
    required String driverId,
    required OrderReq o,
  }) {
    final order = _orderRepository.findById(o.id);
    if (order == null) throw Exception("order id : ${o.id} is not found");

    if (order.status != OrderStatus.assigned) {
      throw Exception("can only assign driver to an accepted order");
    }

    final depot = _depotRepository.findById(order.depotId);

    if (depot == null)
      throw Exception("depot id : ${order.depotId} is not found");

    if (managerId != depot.managerId) {
      {
        throw Exception(" manager id : $managerId is not found");
      }
    }

    final delivery = DeliveryOrder(
      id: Uuid().v4(),
      number: _deliveryRepository.nextNumber,
      managerId: managerId,
      driverId: driverId,
      status: DeliveryStatus.pending,
      assignedAt: DateTime.now(),
    );

    _deliveryRepository.save(delivery);

    order.deliveryId = delivery.id;
    order.status = OrderStatus.assigned;
    _orderRepository.update(order);
    notifyListeners();
  }

  void addOrderToDelivery(String deliveryId, OrderReq o) {
    final order = _orderRepository.findById(o.id);
    if (order == null) throw Exception("order id : ${o.id} is not found");

    if (order.status != OrderStatus.assigned) {
      throw Exception("can only assign driver to an accepted order");
    }

    final _existDelivery = _deliveryRepository.findById(deliveryId);

    if (_existDelivery != null) {
      order.deliveryId = _existDelivery.id;
      order.status = OrderStatus.assigned;
      _orderRepository.update(order);
    }
    notifyListeners();
  }

  List<DeliveryOrder> getByDriverId(String driverId) {
    return _deliveryRepository.findByDriverID(driverId);
  }

  List<DeliveryOrder> getAll() {
    final list = _deliveryRepository.getAll;

    return list;
  }

  void acceptedDelivery(String driverId, DeliveryOrder del) {
    final delivery = _deliveryRepository.findById(del.id);

    if (delivery == null)
      throw Exception("delivery id : ${del.id} is not found");

    if (delivery.status != DeliveryStatus.pending)
      throw Exception("only ${DeliveryStatus.pending} can be accpeted");

    final driver = _driverRepository.findById(driverId);
    if (driver == null) throw Exception("driver id : $driverId not found");
    if (driver.id != driverId)
      throw Exception("You are not belong to this order");

    delivery.status = DeliveryStatus.accepted;

    _deliveryRepository.update(delivery);
    notifyListeners();
  }

  void completeOrder(DeliveryOrder del, OrderReq o) {
    final delivery = _deliveryRepository.findById(del.id);
    if (delivery == null) throw Exception("delivery ${del.id} not found");

    if (delivery.status != DeliveryStatus.accepted) {
      throw Exception("delivery must be accepted before completing orders");
    }

    final order = _orderRepository.findById(o.id);
    if (order == null) throw Exception("order ${o.id} not found");

    order.status = OrderStatus.completed;
    _orderRepository.update(order);

    final allOrders = _orderRepository.findByDeliveryId(delivery.id);
    final allCompleted = allOrders.every(
      (ord) => ord.status == OrderStatus.completed,
    );
    if (allCompleted) {
      delivery.status = DeliveryStatus.completed;
      _deliveryRepository.update(delivery);
    }
    _orderService.notifyListeners();
    notifyListeners();
  }
}
