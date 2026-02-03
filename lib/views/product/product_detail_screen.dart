import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/product_controller.dart';
import '../../core/constants/app_string.dart';
import '../../core/theme/colors.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int productId = Get.arguments;
    final ProductController productController = Get.find<ProductController>();
    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Product Details'), elevation: 0),
      body: FutureBuilder(
        future: productController.fetchProductById(productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('Failed to load product'));
          }

          final product = snapshot.data!;

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Theme.of(context).cardColor,
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: CachedNetworkImage(
                            imageUrl: product.image,
                            height: 300,
                            fit: BoxFit.contain,
                            placeholder: (_, __) =>
                                const CircularProgressIndicator(),
                            errorWidget: (_, __, ___) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Text(
                                  '₹${product.price}',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        size: 16,
                                        color: AppColors.ratingStar,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${product.rating.rate} (${product.rating.count})',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              product.category.toUpperCase(),
                              style: Theme.of(context).textTheme.labelMedium
                                  ?.copyWith(letterSpacing: 1),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Description',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              product.description,
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(height: 1.5),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() {
                final isInCart = cartController.isInCart(product.id);
                return Container(
                  padding: const EdgeInsets.all(16),
                  color: Theme.of(context).cardColor,
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: isInCart
                            ? AppColors.error
                            : AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        cartController.toggleCart(product);
                      },
                      child: Text(
                        isInCart
                            ? AppStrings.removeFromCart
                            : AppStrings.addToCart,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
