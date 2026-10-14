import 'package:ecommerce_b2b/domain/enum.dart';
import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final OrderStatus orderStatus;
  final DeliveryStatus? deliveryStatus;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final VoidCallback? onAssign;
  bool? isOpen;

  ActionButtons({
    super.key,
    required this.orderStatus,
    this.onAccept,
    this.onReject,
    this.onAssign,
    this.isOpen,
    this.deliveryStatus,
  });

  @override
  void setState() {
    isOpen = !isOpen!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          if (orderStatus == OrderStatus.pending) ...[
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: onAccept,
                child: const Text(
                  'Accept',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: onReject,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text(
                  'Reject',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],

          if (orderStatus == OrderStatus.assigned && deliveryStatus != DeliveryStatus.accepted)
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: orderStatus.color,
                ),
                onPressed: onAssign,
                child: const Text(
                  "Assign Driver",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
