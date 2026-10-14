import 'package:ecommerce_b2b/domain/driver.dart';

class DriverRepository {
  final List<Driver> _drivers = [];

  List<Driver> findByDepotId(String depotId) {
    return _drivers.where((d) => d.depotId == depotId).toList();
  }

  Driver? findById(String id) {
    try {
      return _drivers.firstWhere((d) => d.id == id);
    } catch (_) {
      return null;
    }
  }

  void save(Driver driver) {
    if (findById(driver.id) != null) {
      throw Exception("Driver ${driver.id} already exists");
    }
    _drivers.add(driver);
  }

  List<Driver> get all => List.unmodifiable(_drivers);
}
