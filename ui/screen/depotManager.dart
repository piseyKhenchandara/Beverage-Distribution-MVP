import 'package:ecommerce_b2b/data/data.dart';
import 'package:ecommerce_b2b/ui/widgets/customAppbar.dart';
import 'package:ecommerce_b2b/ui/widgets/showRoleMenu.dart';
import 'package:flutter/material.dart';

class DepotManagerScreen extends StatefulWidget {
  const DepotManagerScreen({super.key});

  @override
  State<DepotManagerScreen> createState() => _DepotManagerScreenState();
}

class _DepotManagerScreenState extends State<DepotManagerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        Data.managers.first.name,
        onMenuPressed: () => showRoleMenu(context),
      ),
    );
  }
}