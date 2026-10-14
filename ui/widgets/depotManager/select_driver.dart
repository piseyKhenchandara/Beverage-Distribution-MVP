import 'package:ecommerce_b2b/domain/delivery_order.dart';
import 'package:ecommerce_b2b/domain/driver.dart';
import 'package:ecommerce_b2b/domain/order_req.dart';
import 'package:ecommerce_b2b/service/delivery_service.dart';
import 'package:ecommerce_b2b/service/driver_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectDriver extends StatefulWidget {
  final String titleCard;
  final OrderReq order;
  final String managerId;

  const SelectDriver({
    super.key,
    required this.order,
    required this.managerId,
    required this.titleCard,
  });

  @override
  State<SelectDriver> createState() => _SelectDriverState();
}

class _SelectDriverState extends State<SelectDriver> {
  late List<Driver> _drivers;
  late DeliveryService _deliveryService;
  late List<DeliveryOrder> _deliveries;

  @override
  void initState() {
    super.initState();
    _drivers = context.read<DriverService>().getAllDriver();
    _deliveryService = context.read<DeliveryService>();
    _deliveries = _deliveryService.getAll();
  }

  void _onDriverTap(Driver driver) {
    _deliveryService.assignDriver(
      managerId: widget.managerId,
      driverId: driver.id,
      o: widget.order,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.titleCard, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          if (_deliveries.isNotEmpty) ...[
            const Text("Add to existing delivery:"),
            SizedBox(
              height: 120,
              child: ListView.builder(
                itemCount: _deliveries.length,
                itemBuilder: (context, index) {
                  final delivery = _deliveries[index];
                  return ElevatedButton(
                    onPressed: () {
                      _deliveryService.addOrderToDelivery(delivery.id, widget.order);
                      Navigator.pop(context);
                    },
                    child: Text("Delivery #${delivery.number}"),
                  );
                },
              ),
            ),
            const Divider(),
          ],
          const Text("Assign new driver:"),
          Expanded(
            child: ListView.builder(
              itemCount: _drivers.length,
              itemBuilder: (context, index) => ListTile(
                leading: Image.asset("assets/driver.png"),
                title: Text(_drivers[index].name),
                subtitle: Text(_drivers[index].carPlateNumber),
                trailing: ElevatedButton(
                  onPressed: () => _onDriverTap(_drivers[index]),
                  child: const Icon(Icons.add),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
