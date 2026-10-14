import 'package:ecommerce_b2b/data/data.dart';
import 'package:ecommerce_b2b/domain/app_role.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showRoleMenu(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (sheetContext) => Column(
      mainAxisSize: MainAxisSize.min,
      children: AppRole.values.map((role) {
        return ListTile(
          title: Text(role.label),
          onTap: () {
            Navigator.pop(sheetContext);
            if (role == AppRole.driver) {
              context.go('/driver/${Data.drivers.first.id}');
            } else if (role == AppRole.depot) {
              context.go('/depotOwner/${Data.depots.first.id}');
            } else if (role == AppRole.depotManager) {
              context.go('/depot_manager/${Data.managers.first.id}');
            }
          },
        );
      }).toList(),
    ),
  );
}

