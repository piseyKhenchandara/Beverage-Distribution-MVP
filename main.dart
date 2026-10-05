import 'package:ecommerce_b2b/data/data.dart';
import 'package:ecommerce_b2b/domain/appRole.dart';
import 'package:ecommerce_b2b/repository/depot_Repository.dart';
import 'package:ecommerce_b2b/repository/depot_owner_repository.dart';
import 'package:ecommerce_b2b/repository/orderItem_repository.dart';
import 'package:ecommerce_b2b/repository/orderRepository.dart';
import 'package:ecommerce_b2b/service/depot_owner_service.dart';
import 'package:ecommerce_b2b/service/orderService.dart';
import 'package:ecommerce_b2b/ui/screen/depotManager.dart';
import 'package:ecommerce_b2b/ui/screen/depot_screen.dart';
import 'package:ecommerce_b2b/ui/screen/driver.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  initialLocation: AppRole.depot.path,
  routes: [
    GoRoute(
      path: AppRole.depot.path,
      builder: (context, state) => DepotScreen(),
    ),
    GoRoute(
      path: AppRole.depotManager.path,
      builder: (context, state) => DepotManagerScreen(),
    ),
    GoRoute(path: AppRole.driver.path, builder: (context, state) => Driver()),
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

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => _buildOrderRepository()),
        Provider(create: (_) => _buildOrderItemRepository()),
        Provider(create: (_) => _buildDepotRepository()),
        Provider(create: (_) => _buildDepotOwnerRepository()),
        Provider(
          create: (context) => DepotOwnerService(
            repository: context.read<DepotOwnerRepository>(),
          ),
        ),
        Provider(
          create: (context) => OrderService(
            orderRepository: context.read<OrderRepository>(),
            orderItemRepository: context.read<OrderitemRepository>(),
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