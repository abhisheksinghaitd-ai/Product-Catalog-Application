import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/product_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../core/constants/app_routes.dart';
import '../../core/constants/app_string.dart';
import '../../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final ProductController productController = Get.put(ProductController());
    final ThemeController themeController = Get.find<ThemeController>();
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          AppStrings.appTitle,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          Obx(() {
            return IconButton(
              icon: Icon(
                themeController.isDarkMode.value
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
              ),
              onPressed: themeController.toggleTheme,
            );
          }),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => Get.toNamed(AppRoutes.cart),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: authController.logout,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: TextField(
              controller: searchController,
              onChanged: productController.searchProducts,
              cursorColor: Theme.of(context).colorScheme.primary,
              decoration: InputDecoration(
                hintText: 'Search products',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (productController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (productController.error.isNotEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.wifi_off_rounded, size: 96),
                        const SizedBox(height: 12),
                        Text(
                          productController.error.value,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: productController.fetchProducts,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (productController.filteredProducts.isEmpty) {
                return const Center(child: Text('No products found'));
              }

              return RefreshIndicator(
                onRefresh: productController.fetchProducts,
                child: GridView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: productController.filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = productController.filteredProducts[index];

                    return ProductCard(
                      product: product,
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.productDetail,
                          arguments: product.id,
                        );
                      },
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
