import 'package:ecommerce_b2b/data/data.dart';
import 'package:ecommerce_b2b/domain/delivery_order.dart';
import 'package:ecommerce_b2b/domain/enum.dart';
import 'package:ecommerce_b2b/domain/order_req.dart';
import 'package:ecommerce_b2b/service/delivery_service.dart';
import 'package:ecommerce_b2b/service/depot_owner_service.dart';
import 'package:ecommerce_b2b/service/order_item_service.dart';
import 'package:ecommerce_b2b/service/product_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DriverCustomCard extends StatefulWidget {
  final DeliveryOrder delivery;
  final List<OrderReq> orders;

  const DriverCustomCard({
    super.key,
    required this.delivery,
    required this.orders,
  });

  @override
  State<DriverCustomCard> createState() => _DriverCustomCardState();
}

class _DriverCustomCardState extends State<DriverCustomCard> {
  late DeliveryService _deliveryService;
  late OrderitemService _orderItemService;
  late ProductService _productService;
  late DepotOwnerService _depotOwnerService;

  @override
  void initState() {
    super.initState();
    _deliveryService = context.read<DeliveryService>();
    _orderItemService = context.read<OrderitemService>();
    _productService = context.read<ProductService>();
    _depotOwnerService = context.read<DepotOwnerService>();
  }

  Widget _statusBadge(DeliveryStatus status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: status.color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Delivery #${widget.delivery.number}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                _statusBadge(widget.delivery.status),
              ],
            ),
            ...widget.orders.map((o) {
              final depotOwner = _depotOwnerService.getByDepotId(o.depotId);
              final orderItems = _orderItemService.getByOrderId(o.id);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      depotOwner.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...orderItems.map((item) {
                    final product = _productService.getById(item.productId);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(product.name),
                        Text('${item.quantity} boxes'),
                      ],
                    );
                  }),
                  if (o.status == OrderStatus.assigned &&
                      widget.delivery.status == DeliveryStatus.accepted)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () => setState(() {
                            _deliveryService.completeOrder(widget.delivery, o);
                          }),
                          child: const Text('Mark As Complete'),
                        ),
                      ),
                    ),
                ],
              );
            }),
            if (widget.delivery.status == DeliveryStatus.pending)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => setState(() {
                      _deliveryService.acceptedDelivery(
                        Data.drivers.first.id,
                        widget.delivery,
                      );
                    }),
                    child: const Text('Accept'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
