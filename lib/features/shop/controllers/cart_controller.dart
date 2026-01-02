import 'package:get/get.dart';
import 'package:kkn_store/features/shop/models/cart_item_model.dart';
import 'package:kkn_store/features/shop/models/product_model.dart';
import 'package:kkn_store/utils/local_storage/storage_utility.dart';
import 'package:kkn_store/utils/popups/loaders.dart';
import 'package:kkn_store/features/shop/models/promo_model.dart';
import 'package:kkn_store/data/repositories/promo/promo_repository.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  // Variables
  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  
  // Promo Vars
  final _promoRepository = Get.put(PromoRepository());
  Rx<PromoModel?> appliedPromo = Rx<PromoModel?>(null);
  RxDouble discountAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    // Re-verify promo when cart changes
    ever(totalCartPrice, (_) => _updateDiscount());
    loadCartItems();
  }

  // --- Promo Code Logic ---
  void applyPromoCode(String code) async {
    try {
      if (code.isEmpty) return;

      TLoaders.customToast(message: 'Applying promo...');
      final promo = await _promoRepository.fetchPromo(code);
      if (promo == null) {
        TLoaders.errorSnackBar(title: 'Invalid Code', message: 'Promo code does not exist.');
        return;
      }

      // Check Expiry
      if (DateTime.now().isAfter(promo.endDate)) {
        TLoaders.errorSnackBar(title: 'Expired', message: 'This promo code has expired.');
        return;
      }
      
      if (DateTime.now().isBefore(promo.startDate)) {
         TLoaders.errorSnackBar(title: 'Not yet active', message: 'This promo code is not valid yet.');
         return;
      }

      // Apply
      appliedPromo.value = promo;
      _updateDiscount();
      
      TLoaders.successSnackBar(title: 'Success', message: 'Promo applied: ${promo.discountPercent}% off!');
      
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  void removePromoCode() {
    appliedPromo.value = null;
    discountAmount.value = 0.0;
    TLoaders.customToast(message: 'Promo removed');
  }

  void _updateDiscount() {
    if (appliedPromo.value == null) {
      discountAmount.value = 0.0;
      return;
    }

    final discount = totalCartPrice.value * (appliedPromo.value!.discountPercent / 100);
    discountAmount.value = discount;
  }
  
  double get finalTotalPrice => totalCartPrice.value - discountAmount.value;

  // --- Cart Logic ---

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
      // Already in cart, check limit
      if (product.stock < selectedCartItem.quantity) {
         TLoaders.warningSnackBar(title: 'Stock Limit', message: 'Not enough stock available.');
         return;
      }
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      if (product.stock < selectedCartItem.quantity) {
         TLoaders.warningSnackBar(title: 'Stock Limit', message: 'Not enough stock available.');
         return;
      }
      cartItems.add(selectedCartItem);
    }

    updateCart();
    TLoaders.customToast(message: 'Your Product has been added to the Cart.');
  }

  // Add one item to cart logic (Fixed)

  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere(
      (cartItem) =>
          cartItem.productId == item.productId &&
          cartItem.variationId == item.variationId,
    );

    if (index >= 0) {
      if (cartItems[index].quantity >= cartItems[index].stock) {
         TLoaders.warningSnackBar(title: 'Stock Limit', message: 'No more quantity available.');
         return;
      }
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
        // Show dialog before removing the last item
        removeFromCartDialog(index);
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
      stock: product.stock,
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
