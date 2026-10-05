import 'package:ecommerce_b2b/repository/orderItem_repository.dart';

class OrderitemService {
  final OrderitemRepository _orderItemRepository;

  OrderitemService({required OrderitemRepository orderItemRepository})
    : _orderItemRepository = orderItemRepository;


}
