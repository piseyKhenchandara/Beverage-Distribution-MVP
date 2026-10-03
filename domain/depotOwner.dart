import 'package:ecommerce_b2b/domain/user.dart';

class DepotOwner extends User {
  final String depotId;

  DepotOwner({
    required this.depotId,
    required super.id,
    required super.phone,
    required super.name,
    required super.isActive,
    required super.createdAt,
    super.lastLogin,
  });
}
