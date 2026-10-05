class OrderItem {
  final String? id;
  final String? orderReqId;
  final String productId;
  int quantity;

  OrderItem({this.id, this.orderReqId, required this.productId, required this.quantity});
}
