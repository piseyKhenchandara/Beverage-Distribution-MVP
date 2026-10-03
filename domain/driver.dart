import 'user.dart';

class Driver extends User {
  String carPlateNumber;
  String depotId;
  String managerId;

  Driver({
    required this.carPlateNumber,
    required this.depotId,
    required  this.managerId,
    required super.id,
    required super.phone,
    required super.name,
    required super.isActive,
    required super.createdAt,
    required super.lastLogin,
  });
}
