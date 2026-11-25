import 'dart:convert';

import 'package:assignment1/models/product_model.dart';
import 'package:assignment1/services/product_service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  ProductService productService = ProductService();

  final products = <Product>[].obs;
  final isLoading = false.obs;
  final error = ''.obs;
  final cart = <int, int>{}.obs;

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      error.value = '';
      String response = await productService.fetchProducts();
      var data= jsonDecode(response);
      var productList = data['products'];
      List<Product> productData = [];

      for (var item in productList) {
        Product product = Product.fromJson(item);
        productData.add(product);
      }
      
      products.value = productData;
    } catch (err) {
      error.value = err.toString();
    } finally {
      isLoading.value = false;
    }
  }

  int get cartCount {
    int count = 0;
    for (var quantity in cart.values) {
      count = count + quantity;
    }
    return count;
  }

  void addToCart(Product product) {
    if (cart.containsKey(product.id)) {
      cart[product.id] = cart[product.id]! + 1;
    } else {
      cart[product.id] = 1;
    }

    Get.snackbar('Success', 'product added to cart');
  }

  void quantityIncrease(int productId) {
    cart[productId] = cart[productId]! + 1;
  }

  void quantityDerease(int productId) {
    if (cart[productId]! > 1) {
      cart[productId] = cart[productId]! - 1;
    } else {
      cart.remove(productId);
    }
  }

  void removeCart(int productId) {
    cart.remove(productId);
  }

  double get totalAmount {
    double total = 0;
    for (var item in cart.entries) {
      Product product = products.firstWhere((p) => p.id == item.key);
      total = total + (product.price * item.value);
    }
    return total;
  }
}
