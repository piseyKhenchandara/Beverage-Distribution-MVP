import 'package:ecommerce_b2b/data/data.dart';
import 'package:ecommerce_b2b/domain/depot.dart';
import 'package:ecommerce_b2b/domain/depotManager.dart';

class Depotrepository {
  Depot? findById({required String depotId}) {
    try {
      final depot = Data.depots.firstWhere((depot) => depot.id == depotId);
      return depot;
    } catch (_) {
      throw Exception("depot id: ${depotId} not found!");
    }
  }

  Depot? findByManagerId({required String managerId}) {
    try {
      final manager = Data.depots.firstWhere(
        (depot) => depot.managerId == managerId,
      );
      return manager;
    } catch (_) {
      throw Exception("manager id: ${managerId} for this depot not found!");
    }
  }

  
}
