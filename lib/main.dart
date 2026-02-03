import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/auth_controller.dart';
import 'controllers/cart_controller.dart';
import 'controllers/theme_controller.dart';
import 'core/constants/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'views/auth/login_screen.dart';
import 'views/home/home_screen.dart';
import 'views/product/product_detail_screen.dart';
import 'views/cart/cart_screen.dart';

void main() {
  Get.put(CartController(), permanent: true);
  Get.put(AuthController(), permanent: true);
  Get.put(ThemeController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Product Catalog',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.isDarkMode.value
            ? ThemeMode.dark
            : ThemeMode.light,
        initialRoute: AppRoutes.login,
        getPages: [
          GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
          GetPage(name: AppRoutes.home, page: () => const HomeScreen()),
          GetPage(
            name: AppRoutes.productDetail,
            page: () => const ProductDetailScreen(),
          ),
          GetPage(name: AppRoutes.cart, page: () => const CartScreen()),
        ],
      );
    });
  }
}
