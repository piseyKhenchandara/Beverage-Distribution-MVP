import 'package:ecommerce_b2b/ui/screen/depot_screen.dart';
import 'package:ecommerce_b2b/ui/widgets/depot/inputForm.dart';
import 'package:flutter/material.dart';


class ProductOrderCard extends StatelessWidget {
  final String productUrl;
  final String productName;
  final TextEditingController controller;
  final void Function(int) onChanged; // not VoidCallback

  const ProductOrderCard({
    super.key,
    required this.productUrl,
    required this.productName,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Image.asset(productUrl, width: 120, height: 120, fit: BoxFit.cover),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InputForm(
                      controller: controller,
                      onChanged: onChanged,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
