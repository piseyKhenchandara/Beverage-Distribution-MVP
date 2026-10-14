import 'package:ecommerce_b2b/domain/order_item.dart';
import 'package:ecommerce_b2b/repository/order_item_repository.dart';

class OrderitemService {
  final OrderitemRepository _orderItemRepository;

  OrderitemService({required OrderitemRepository orderItemRepository})
    : _orderItemRepository = orderItemRepository;

  List<OrderItem> getByOrderId(String orderId) {
    final listOrder = _orderItemRepository.findByOrderReqId(orderReqId:  orderId);
    return listOrder;

  }


  
}
