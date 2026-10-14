import 'package:ecommerce_b2b/domain/delivery_order.dart';
import 'package:ecommerce_b2b/domain/driver.dart';
import 'package:ecommerce_b2b/domain/enum.dart';
import 'package:ecommerce_b2b/domain/order_item.dart';
import 'package:ecommerce_b2b/domain/order_req.dart';
import 'package:ecommerce_b2b/domain/depot_owner.dart';
import 'package:ecommerce_b2b/service/delivery_service.dart';
import 'package:ecommerce_b2b/service/depot_owner_service.dart';
import 'package:ecommerce_b2b/service/driver_service.dart';
import 'package:ecommerce_b2b/service/order_item_service.dart';
import 'package:ecommerce_b2b/service/order_service.dart';
import 'package:ecommerce_b2b/service/product_service.dart';
import 'package:ecommerce_b2b/ui/widgets/depotManager/action_button.dart';
import 'package:ecommerce_b2b/ui/widgets/depotManager/select_driver.dart';
import 'package:ecommerce_b2b/ui/widgets/depotManager/status_badge.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomCard extends StatefulWidget {
  final OrderReq order;
  final String managerId;

  const CustomCard({super.key, required this.order, required this.managerId});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  late DepotOwner _owner;
  late List<OrderItem> _orderItems;
  late ProductService _productService;
  late OrderService _orderService;
  Driver? _driver;
  DeliveryOrder? _deliveryOrder;

  @override
  void initState() {
    super.initState();
    _owner = context.read<DepotOwnerService>().getByDepotId(
      widget.order.depotId,
    );
    _orderItems = context.read<OrderitemService>().getByOrderId(
      widget.order.id,
    );
    _productService = context.read<ProductService>();
    _orderService = context.read<OrderService>();

    final deliveryId = widget.order.deliveryId;
    if (deliveryId != null) {
      _deliveryOrder = context.read<DeliveryService>().getById(deliveryId);
      if (_deliveryOrder?.driverId != null) {
        _driver = context.read<DriverService>().getById(
          _deliveryOrder!.driverId!,
        );
      }
    }
  }

  void conditionDispalyDriver() {
    final deliveryId = widget.order.deliveryId;
    if (deliveryId != null) {
      _deliveryOrder = context.read<DeliveryService>().getById(deliveryId);
      if (_deliveryOrder?.driverId != null) {
        _driver = context.read<DriverService>().getById(
          _deliveryOrder!.driverId!,
        );
      }
    }
  }

  int get _totalQuantity => _orderItems.fold(0, (sum, i) => sum + i.quantity);


  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    final d = order.createdAt;

    final title = '${_owner.name}(order${d.month}-${d.day}-${d.year % 100})';

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
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                order.status == OrderStatus.completed
                    ? StatusBadge(status: order.status)
                    : _deliveryOrder != null && _driver != null
                        ? Container(
                          decoration: BoxDecoration(
                            color: _deliveryOrder!.status.color,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Image.asset("assets/driver.png", width: 20, height: 20),
                                const SizedBox(width: 4),
                                Text(
                                  "${_driver!.name} · ${_deliveryOrder!.status.label}",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        )
                        : StatusBadge(status: order.status),
              ],
            ),
            const SizedBox(height: 8),
            ..._orderItems.map((item) {
              final product = _productService.getById(item.productId);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(product.name), Text('${item.quantity} boxes')],
              );
            }),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '$_totalQuantity boxes',
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            ActionButtons(
              orderStatus: order.status,
              deliveryStatus: _deliveryOrder?.status,
              onAccept: () => _orderService.accepted(widget.managerId, order),
              onReject: () => _orderService.rejected(widget.managerId, order),
              onAssign: () =>
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => SelectDriver(
                      order: order,
                      managerId: widget.managerId,
                      titleCard: title,
                    ),
                  ).then(
                    (_) => setState(() {
                      conditionDispalyDriver();
                    }),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}



