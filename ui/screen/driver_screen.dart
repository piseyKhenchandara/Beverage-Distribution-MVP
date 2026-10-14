import 'package:ecommerce_b2b/data/data.dart';
import 'package:ecommerce_b2b/domain/driver.dart';
import 'package:ecommerce_b2b/domain/order_req.dart';
import 'package:ecommerce_b2b/service/delivery_service.dart';
import 'package:ecommerce_b2b/service/driver_service.dart';
import 'package:ecommerce_b2b/service/order_service.dart';
import 'package:ecommerce_b2b/ui/widgets/custom_appbar.dart';
import 'package:ecommerce_b2b/ui/widgets/driver/driver_custom_card.dart';
import 'package:ecommerce_b2b/ui/widgets/show_role_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DriverScreen extends StatefulWidget {
  final String driverId;
  const DriverScreen({super.key, required this.driverId});

  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  late Driver _driver;
  late OrderService _orderService;

  @override
  void initState() {
    super.initState();
    _driver = context.read<DriverService>().getById(widget.driverId)!;
    _orderService = context.read<OrderService>();
  }

  List<OrderReq> _getOrders(String deliveryId) {
    return _orderService.getByDeliveryId(deliveryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        _driver.name,
        onMenuPressed: () => showRoleMenu(context),
      ),
      body: Column(
        children: [
          const Text("New orders"),
          Expanded(
            child: Consumer<DeliveryService>(
              builder: (context, deliveryService, _) {
                final deliveries = deliveryService.getByDriverId(widget.driverId);
                return ListView.builder(
                  itemCount: deliveries.length,
                  itemBuilder: (context, index) {
                    final delivery = deliveries[index];
                    return DriverCustomCard(
                      delivery: delivery,
                      orders: _getOrders(delivery.id),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
