import 'package:ecommerce_b2b/data/data.dart';
import 'package:ecommerce_b2b/domain/depot.dart';
import 'package:ecommerce_b2b/domain/enum.dart';
import 'package:ecommerce_b2b/domain/order_item.dart';
import 'package:ecommerce_b2b/domain/order_req.dart';
import 'package:ecommerce_b2b/domain/product_image.dart';
import 'package:ecommerce_b2b/repository/order_repository.dart';
import 'package:ecommerce_b2b/service/order_service.dart';
import 'package:ecommerce_b2b/ui/widgets/custom_appbar.dart';

import 'package:ecommerce_b2b/ui/widgets/depot/product_order_card.dart';
import 'package:ecommerce_b2b/ui/widgets/depot/summary_section.dart';
import 'package:ecommerce_b2b/ui/widgets/show_role_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DepotScreen extends StatefulWidget {
  final String depotId;
  const DepotScreen({super.key, required this.depotId});

  @override
  State<DepotScreen> createState() => _DepotScreenState();
}

class _DepotScreenState extends State<DepotScreen> {
  late OrderService _orderService;
  late List<OrderItem> orderItems;
  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();

    orderItems = Data.products
        .map((p) => OrderItem(productId: p.id, quantity: 0))
        .toList();
    controllers = Data.products.map((_) => TextEditingController()).toList();

    _orderService = context.read<OrderService>();
  }

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  int get total {
    int sum = 0;
    for (final item in orderItems) {
      sum += item.quantity;
    }
    return sum;
  }

  void _showSuccessDialog(int boxes) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Order placed"),
        content: Text("You ordered $boxes boxes."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void confirmOrder() {
    final orderedTotal = total;

    try {
      _orderService.createOrder(
        depotId: Data.depots.first.id,
        items: orderItems,
        deliveryDate: DateTime.now(),
      );
      setState(() {
        orderItems = Data.products
            .map((p) => OrderItem(productId: p.id, quantity: 0))
            .toList();
      });
      _showSuccessDialog(orderedTotal);

      for (final c in controllers) {
        c.clear();
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        Data.depots.first.name,
        profile: "assets/profiles/depot_profile.png",
        onMenuPressed: () => showRoleMenu(context),
      ),
      body: Column(
        children: [
          Consumer<OrderService>(
            builder: (context, orderService, _) {
              final orders = orderService.getOrders()
                  .where((o) => o.depotId == Data.depots.first.id)
                  .toList();
              if (orders.isEmpty) return const SizedBox();
              final latest = orders.last;
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Latest order:"),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red, width: 2),
                        color: latest.status.color,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      
                      child: latest.status == OrderStatus.assigned ? Text(DeliveryStatus.delivering.name) : Text(latest.status.label),
                    ),
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: Data.products.length,
              itemBuilder: (context, index) {
                final product = Data.products[index];
                final imageUrl = Data.productImages
                    .firstWhere((img) => img.productId == product.id)
                    .url;
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: ProductOrderCard(
                      productUrl: imageUrl,
                      productName: product.name,
                      controller: controllers[index],
                      onChanged: (val) =>
                          setState(() => orderItems[index].quantity = val),
                    ),
                  ),
                );
              },
            ),
          ),

          SummarySection(total: total, confirmOrder: confirmOrder),
        ],
      ),
    );
  }
}
