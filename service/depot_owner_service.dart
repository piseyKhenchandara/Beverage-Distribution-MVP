import 'package:ecommerce_b2b/domain/depotOwner.dart';
import 'package:ecommerce_b2b/repository/depot_owner_repository.dart';

class DepotOwnerService {
  final DepotOwnerRepository _repository;

  DepotOwnerService({required DepotOwnerRepository repository})
      : _repository = repository;

  DepotOwner getByDepotId(String depotId) {
    final owner = _repository.findByDepotId(depotId);
    if (owner == null) throw Exception("No owner found for depot $depotId");
    return owner;
  }
}