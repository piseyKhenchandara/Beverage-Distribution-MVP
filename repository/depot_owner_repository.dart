import 'package:ecommerce_b2b/domain/depotOwner.dart';

class DepotOwnerRepository {
  final List<DepotOwner> _owners = [];

  DepotOwner? findById(String id) {
    try {
      return _owners.firstWhere((o) => o.id == id);
    } catch (_) {
      return null;
    }
  }

  DepotOwner? findByDepotId(String depotId) {
    try {
      return _owners.firstWhere((o) => o.depotId == depotId);
    } catch (_) {
      return null;
    }
  }

  void save(DepotOwner owner) {
    if (findById(owner.id) != null) {
      throw Exception("DepotOwner ${owner.id} already exists");
    }
    _owners.add(owner);
  }
}
