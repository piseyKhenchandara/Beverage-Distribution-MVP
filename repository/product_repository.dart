import 'package:ecommerce_b2b/domain/product.dart';

class ProductRepository {
  final List<Product> _products = [];

  Product? findById(String id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  

  void save(Product product) {
    if (findById(product.id) != null) {
      throw Exception("Product ${product.id} already exists");
    }
    _products.add(product);
  }
}
