import 'package:get/get.dart';
import '../data/models/product_model.dart';
import '../data/repositories/product_repository.dart';
import '../data/services/api_services.dart';

class ProductController extends GetxController {
  final ProductRepository repository = ProductRepository(
    apiService: ApiService(),
  );

  final products = <Product>[].obs;
  final filteredProducts = <Product>[].obs;

  final isLoading = false.obs;
  final error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts({int limit = 10}) async {
    try {
      isLoading.value = true;
      error.value = '';

      final fetchedProducts = await repository.getProducts(limit: limit);

      products.value = fetchedProducts;
      filteredProducts.value = fetchedProducts;
    } catch (e) {
      error.value = 'Failed to load products';
    } finally {
      isLoading.value = false;
    }
  }

  void searchProducts(String query) {
    if (query.trim().isEmpty) {
      filteredProducts.value = products;
      return;
    }

    filteredProducts.value = products
        .where(
          (product) =>
              product.title.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  Future<Product?> fetchProductById(int id) async {
    try {
      return await repository.getProductById(id);
    } catch (_) {
      return null;
    }
  }
}
