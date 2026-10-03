import 'package:flutter/material.dart';
import 'package:ecommerce_b2b/domain/appRole.dart';
import 'package:ecommerce_b2b/ui/screen/depot_screen.dart';
import 'package:ecommerce_b2b/ui/screen/depotManager.dart';
import 'package:ecommerce_b2b/ui/screen/driver.dart';

void showRoleMenu(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: AppRole.values.map((role) {
        return ListTile(
          title: Text(role.label),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => _screenForRole(role)),
            );
          },
        );
      }).toList(),
    ),
  );
}

Widget _screenForRole(AppRole role) {
  switch (role) {
    case AppRole.depot:
      return const DepotScreen();
    case AppRole.depotManager:
      return const DepotManagerScreen();
    case AppRole.driver:
      return const Driver();
  }
}
