import 'package:get/get.dart';
import 'package:kkn_store/features/shop/models/cart_item_model.dart';
import 'package:kkn_store/features/shop/models/product_model.dart';
import 'package:kkn_store/utils/local_storage/storage_utility.dart';
import 'package:kkn_store/utils/popups/loaders.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  // Variables
  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  @override
  void onInit() {
    loadCartItems();
    super.onInit();
  }

  // Add Item to Cart
  void addToCart(ProductModel product) {
    if (productQuantityInCart.value < 1) {
      TLoaders.customToast(message: 'Select Quantity');
      return;
    }

    // Check if item already exists
    final selectedCartItem = convertProductToCartItem(
      product,
      productQuantityInCart.value,
    );

    int index = cartItems.indexWhere(
      (cartItem) =>
          cartItem.productId == selectedCartItem.productId &&
          cartItem.variationId == selectedCartItem.variationId,
    );

    if (index >= 0) {
      // Already in cart, update quantity
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }

    updateCart();
    TLoaders.customToast(message: 'Your Product has been added to the Cart.');
  }

  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere(
      (cartItem) =>
          cartItem.productId == item.productId &&
          cartItem.variationId == item.variationId,
    );

    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }
    updateCart();
  }

  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere(
      (cartItem) =>
          cartItem.productId == item.productId &&
          cartItem.variationId == item.variationId,
    );

    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        // Show dialog to remove? Or just remove.
        // For now, just remove if 1
        cartItems[index].quantity == 1
            ? removeFromCartDialog(index)
            : cartItems[index].quantity -= 1;
      }
      updateCart();
    }
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are you sure you want to remove this product?',
      onConfirm: () {
        cartItems.removeAt(index);
        updateCart();
        TLoaders.customToast(message: 'Product removed from the Cart.');
        Get.back();
      },
      onCancel: () => () => Get.back(),
    );
  }

  // Initialize already added Item's Count in the cart.
  void updateAlreadyAddedProductCount(ProductModel product) {
    // If product has no variations then calculate cart entries and display total number.
    // Else make default selection and check if it's in cart.
    // For now, assuming simple products or handling variations later.

    // Check if product is in cart
    // Since we don't have variations fully implemented, we check by productId
    productQuantityInCart.value = getProductQuantityInCart(product.id);
  }

  int getProductQuantityInCart(String productId) {
    final foundItem = cartItems.firstWhere(
      (item) => item.productId == productId,
      orElse: () => CartItemModel.empty(),
    );
    return foundItem.quantity;
  }

  // Convert ProductModel to CartItemModel
  CartItemModel convertProductToCartItem(ProductModel product, int quantity) {
    return CartItemModel(
      productId: product.id,
      title: product.title,
      price: product.salePrice > 0 ? product.salePrice : product.price,
      quantity: quantity,
      variationId: '', // TODO: Handle variations
      image: product.thumbnail,
      brandName: product.brand?.name,
    );
  }

  // Update Cart Values
  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void updateCartTotals() {
    double calculatedTotalPrice = 0.0;

    for (var item in cartItems) {
      calculatedTotalPrice += (item.price) * item.quantity.toDouble();
    }

    // ❌ DO NOT COUNT QUANTITY
    // ✔ SHOW ONLY UNIQUE PRODUCT COUNT
    noOfCartItems.value = cartItems.length;

    totalCartPrice.value = calculatedTotalPrice;
  }

  void saveCartItems() {
    final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
    TLocalStorage().saveData('cartItems', cartItemStrings);
  }

  void loadCartItems() {
    final cartItemStrings = TLocalStorage().readData<List<dynamic>>(
      'cartItems',
    );
    if (cartItemStrings != null) {
      cartItems.assignAll(
        cartItemStrings
            .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
      updateCartTotals();
    }
  }

  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }
}
