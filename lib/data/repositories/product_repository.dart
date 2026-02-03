import 'package:product_catalog/data/services/api_services.dart';

import '../models/product_model.dart';

class ProductRepository {
  final ApiService apiService;

  ProductRepository({required this.apiService});

  Future<List<Product>> getProducts({int limit = 10}) async {
    final List<dynamic> response = await apiService.fetchProducts(limit: limit);

    return response.map((json) => Product.fromJson(json)).toList();
  }

  Future<Product> getProductById(int id) async {
    final Map<String, dynamic> response = await apiService.fetchProductById(id);

    return Product.fromJson(response);
  }
}
