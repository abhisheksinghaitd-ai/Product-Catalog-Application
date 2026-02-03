import 'package:get/get.dart';
import '../data/models/cart_item_model.dart';
import '../data/models/product_model.dart';

class CartController extends GetxController {
  final cartItems = <int, CartItem>{}.obs;

  bool isInCart(int productId) {
    return cartItems.containsKey(productId);
  }

  void toggleCart(Product product) {
    if (isInCart(product.id)) {
      cartItems.remove(product.id);
      Get.snackbar('Removed', 'Product removed from cart');
    } else {
      cartItems[product.id] = CartItem(product: product, quantity: 1);
      Get.snackbar('Added', 'Product added to cart');
    }
  }

  void increaseQuantity(int productId) {
    if (cartItems.containsKey(productId)) {
      cartItems[productId]!.quantity++;
      cartItems.refresh();
    }
  }

  void decreaseQuantity(int productId) {
    if (!cartItems.containsKey(productId)) return;

    if (cartItems[productId]!.quantity > 1) {
      cartItems[productId]!.quantity--;
    } else {
      cartItems.remove(productId);
    }
    cartItems.refresh();
  }

  void removeFromCart(int productId) {
    cartItems.remove(productId);
    cartItems.refresh();
  }

  double get totalPrice {
    return cartItems.values.fold(
      0,
      (sum, item) => sum + item.product.price * item.quantity,
    );
  }

  void clearCart() {
    cartItems.clear();
  }
}
