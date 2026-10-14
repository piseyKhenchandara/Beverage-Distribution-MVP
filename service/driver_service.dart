import 'package:ecommerce_b2b/domain/driver.dart';
import 'package:ecommerce_b2b/repository/driver_repository.dart';

class DriverService {
  final DriverRepository _repository;

  DriverService({required DriverRepository repository})
    : _repository = repository;

  List<Driver> getDriversByDepot(String depotId) {
    return _repository.findByDepotId(depotId);
  }

  List<Driver> getAllDriver() {
    return _repository.all;
  }

  Driver? getById(String id) {
    return _repository.findById(id);
  }
}
