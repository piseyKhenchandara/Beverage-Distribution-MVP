import 'package:flutter/material.dart';
import 'package:ecommerce_b2b/domain/appRole.dart';
import 'package:ecommerce_b2b/ui/screen/depot_screen.dart';
import 'package:ecommerce_b2b/ui/screen/depotManager.dart';
import 'package:ecommerce_b2b/ui/screen/driver.dart';
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
            context.go(role.path);
          },
        );
      }).toList(),
    ),
  );
}

