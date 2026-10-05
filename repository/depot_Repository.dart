import 'package:ecommerce_b2b/domain/depot.dart';

class DepotRepository {
  final List<Depot> _depots = [];

  Depot? findById(String depotId) {
    try {
      return _depots.firstWhere((depot) => depot.id == depotId);
    } catch (_) {
      return null;
    }
  }

  void save(Depot depot) {
    _depots.add(depot);
  }
}
