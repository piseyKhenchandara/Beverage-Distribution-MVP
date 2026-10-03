import 'package:ecommerce_b2b/domain/appRole.dart';
import 'package:ecommerce_b2b/ui/screen/depotManager.dart';
import 'package:ecommerce_b2b/ui/screen/depot_screen.dart';
import 'package:ecommerce_b2b/ui/screen/driver.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: AppRole.depot.path,
  routes: [
    GoRoute(path: AppRole.depot.path, 
    builder: (context, state) => DepotScreen(),
    ),
    GoRoute(path: AppRole.depotManager.path, 
    builder: (context, state) => DepotManagerScreen(),),
    GoRoute(path: AppRole.driver.path, builder: (context, state) => Driver() ,)
  ]
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "KDL Depot",
      routerConfig: router
    );
  }
}






/* 
return MaterialApp(title: 'KDL Depot', home: const DepotScreen()); */