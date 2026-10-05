import 'package:ecommerce_b2b/data/data.dart';
import 'package:ecommerce_b2b/domain/depot.dart';
import 'package:ecommerce_b2b/domain/orderItem.dart';
import 'package:ecommerce_b2b/domain/orderReq.dart';
import 'package:ecommerce_b2b/domain/productImage.dart';
import 'package:ecommerce_b2b/repository/orderRepository.dart';
import 'package:ecommerce_b2b/service/orderService.dart';
import 'package:ecommerce_b2b/ui/widgets/customAppbar.dart';

import 'package:ecommerce_b2b/ui/widgets/depot/productOrderCard.dart';
import 'package:ecommerce_b2b/ui/widgets/depot/summarySection.dart';
import 'package:ecommerce_b2b/ui/widgets/showRoleMenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DepotScreen extends StatefulWidget {
  const DepotScreen({super.key});

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
