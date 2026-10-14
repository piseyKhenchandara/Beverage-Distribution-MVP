import 'package:ecommerce_b2b/data/data.dart';
import 'package:ecommerce_b2b/domain/order_req.dart';
import 'package:ecommerce_b2b/service/depot_owner_service.dart';
import 'package:ecommerce_b2b/service/order_service.dart';
import 'package:ecommerce_b2b/ui/widgets/custom_appbar.dart';
import 'package:ecommerce_b2b/ui/widgets/depotManager/custom_card.dart';
import 'package:ecommerce_b2b/ui/widgets/show_role_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DepotManagerScreen extends StatefulWidget {
  final String managerId;
  const DepotManagerScreen({super.key, required this.managerId});

  @override
  State<DepotManagerScreen> createState() => _DepotManagerScreenState();
}

class _DepotManagerScreenState extends State<DepotManagerScreen> {
  
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        widget.managerId,
        onMenuPressed: () => showRoleMenu(context),
      ),
      body: Consumer<OrderService>(
        builder: (context, orderService, _) {
          final orders = orderService.getOrders();
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return CustomCard(
                order: order,
                managerId: Data.managers.first.id,
              );
            },
          );
        },
      ),
    );
  }
}
