import 'depotOwner.dart';
import 'orderItem.dart';
import 'orderReq.dart';
import 'product.dart';

class OrderLineItem {
  final Product product;
  final int quantity;

  const OrderLineItem({required this.product, required this.quantity});
}

class OrderDetail {
  final OrderReq order;
  final DepotOwner owner;
  final List<OrderLineItem> lineItems;

  const OrderDetail({
    required this.order,
    required this.owner,
    required this.lineItems,
  });

  int get totalQuantity => lineItems.fold(0, (sum, i) => sum + i.quantity);
}
