import 'package:ecommerce_b2b/data/data.dart';
import 'package:ecommerce_b2b/domain/orderReq.dart';
import 'package:ecommerce_b2b/service/depot_owner_service.dart';
import 'package:ecommerce_b2b/service/orderService.dart';
import 'package:ecommerce_b2b/ui/widgets/customAppbar.dart';
import 'package:ecommerce_b2b/ui/widgets/showRoleMenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DepotManagerScreen extends StatefulWidget {
  const DepotManagerScreen({super.key});

  @override
  State<DepotManagerScreen> createState() => _DepotManagerScreenState();
}

class _DepotManagerScreenState extends State<DepotManagerScreen> {
  late OrderService _orderService;
  late DepotOwnerService _depotOwnerService;

  @override
  void initState() {
    super.initState();
    _orderService = context.read<OrderService>();
    _depotOwnerService = context.read<DepotOwnerService>();
  }

  String _cardTitle(OrderReq order) {
    final owner = _depotOwnerService.getByDepotId(order.depotId);
    final d = order.createdAt;
    return '${owner.name}(order${d.month}-${d.day}-${d.year % 100})';
  }

  @override
  Widget build(BuildContext context) {
    final orders = _orderService.getOrders();
    return Scaffold(
      appBar: CustomAppBar(
        Data.managers.first.name,
        onMenuPressed: () => showRoleMenu(context),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.red,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(_cardTitle(order)),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
