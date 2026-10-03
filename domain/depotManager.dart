import 'user.dart';

class DepotManager extends User {
  DepotManager({
    required super.id,
    required super.phone,
    required super.name,
    required super.isActive,
    required super.createdAt,
    super.lastLogin,
  });
}

