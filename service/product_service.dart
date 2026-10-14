import 'package:ecommerce_b2b/domain/product.dart';
import 'package:ecommerce_b2b/repository/product_repository.dart';

class ProductService {
  final ProductRepository _repository;

  ProductService({required ProductRepository repository})
      : _repository = repository;

  Product getById(String id) {
    final product = _repository.findById(id);
    if (product == null) throw Exception("Product $id not found");
    return product;
  }
}
