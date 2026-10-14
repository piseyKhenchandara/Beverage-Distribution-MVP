import 'package:ecommerce_b2b/data/data.dart';
import 'package:ecommerce_b2b/domain/app_role.dart';
import 'package:ecommerce_b2b/repository/delivery_repository.dart';
import 'package:ecommerce_b2b/repository/depot_repository.dart';
import 'package:ecommerce_b2b/repository/depot_owner_repository.dart';
import 'package:ecommerce_b2b/repository/driver_repository.dart';
import 'package:ecommerce_b2b/repository/order_item_repository.dart';
import 'package:ecommerce_b2b/repository/order_repository.dart';
import 'package:ecommerce_b2b/repository/product_repository.dart';
import 'package:ecommerce_b2b/service/delivery_service.dart';
import 'package:ecommerce_b2b/service/depot_owner_service.dart';
import 'package:ecommerce_b2b/service/order_item_service.dart';
import 'package:ecommerce_b2b/service/driver_service.dart';
import 'package:ecommerce_b2b/service/order_service.dart';
import 'package:ecommerce_b2b/service/product_service.dart';
import 'package:ecommerce_b2b/ui/screen/depot_manager.dart';
import 'package:ecommerce_b2b/ui/screen/depot_screen.dart';
import 'package:ecommerce_b2b/ui/screen/driver_screen.dart';


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  initialLocation: '/depotOwner/${Data.depots.first.id}',
  routes: [
    GoRoute(
      path: AppRole.depot.path,
      builder: (context, state) => DepotScreen(depotId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: AppRole.depotManager.path,
      builder: (context, state) => DepotManagerScreen(managerId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: AppRole.driver.path,
      builder: (context, state) => DriverScreen(driverId: state.pathParameters['id']!),
    ),
  ],
);

OrderRepository _buildOrderRepository() {
  final repo = OrderRepository();
  for (final order in Data.orderReqs) repo.save(order);
  return repo;
}

OrderitemRepository _buildOrderItemRepository() {
  final repo = OrderitemRepository();
  for (final item in Data.orderItems) repo.save(item);
  return repo;
}

DepotRepository _buildDepotRepository() {
  final repo = DepotRepository();
  for (final depot in Data.depots) repo.save(depot);
  return repo;
}

DepotOwnerRepository _buildDepotOwnerRepository() {
  final repo = DepotOwnerRepository();
  for (final owner in Data.depotOwners) repo.save(owner);
  return repo;
}

ProductRepository _buildProductRepository() {
  final repo = ProductRepository();
  for (final product in Data.products) repo.save(product);
  return repo;
}

DriverRepository _buildDriverRepository() {
  final repo = DriverRepository();
  for (final driver in Data.drivers) repo.save(driver);
  return repo;
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => _buildOrderRepository()),
        Provider(create: (_) => _buildOrderItemRepository()),
        Provider(create: (_) => _buildDepotRepository()),
        Provider(create: (_) => _buildDepotOwnerRepository()),
        Provider(create: (_) => _buildProductRepository()),
        Provider(
          create: (context) => ProductService(
            repository: context.read<ProductRepository>(),
          ),
        ),
        Provider(create: (_) => _buildDriverRepository()),
        Provider(
          create: (context) => DriverService(
            repository: context.read<DriverRepository>(),
          ),
        ),
        Provider(
          create: (context) => DepotOwnerService(
            repository: context.read<DepotOwnerRepository>(),
          ),
        ),
        Provider(
          create: (context) => OrderitemService(
            orderItemRepository: context.read<OrderitemRepository>(),
          ),
        ),
        Provider(create: (_) => DeliveryRepository()),
        ChangeNotifierProvider(
          create: (context) => OrderService(
            orderRepository: context.read<OrderRepository>(),
            orderItemRepository: context.read<OrderitemRepository>(),
            depotRepository: context.read<DepotRepository>(),
            deliveryRepository: context.read<DeliveryRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => DeliveryService(
            orderService: context.read<OrderService>(),
            driverRepository: context.read<DriverRepository>(),
            deliveryRepository: context.read<DeliveryRepository>(),
            orderRepository: context.read<OrderRepository>(),
            depotRepository: context.read<DepotRepository>(),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(title: "KDL Depot", routerConfig: router);
  }
}


  /* 
  return MaterialApp(title: 'KDL Depot', home: const DepotScreen()); */