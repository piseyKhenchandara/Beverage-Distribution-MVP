
class User {
  final String id;
  String phone;
  String name;
  bool isActive;
  final DateTime createdAt;
  DateTime? lastLogin;

  User({
    required this.id,
    required this.phone,
    required this.name,
    required this.isActive,
    required this.createdAt, 
    this.lastLogin,
  });
}
