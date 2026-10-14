import 'package:flutter/material.dart';

enum DeliveryStatus {
  pending("Pending", Color.fromARGB(255, 167, 154, 41)),
  accepted("Accepted", Colors.green),
  delivering("delivery", Colors.grey),
  completed("Completed", Colors.grey);

  final String label;
  final Color color;
  const DeliveryStatus(this.label, this.color);
}

enum OrderStatus {
  pending("Pending", Color.fromARGB(255, 167, 154, 41)),
  accepted("Accepted", Colors.green),
  assigned("Assigned", Colors.teal),
  rejected("Rejected", Colors.red),
  completed("Completed", Colors.grey),
  cancelled("Cancelled", Colors.grey);


  final String label;
  final Color color;
  const OrderStatus(this.label, this.color);
}
