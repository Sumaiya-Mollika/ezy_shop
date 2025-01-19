import 'dart:developer';

import 'package:ezy_shop/app/services/product_services.dart';
import 'package:get/get.dart';

import '../models/product_response.dart';

class ProductController extends GetxController {
  late final ProductServices _productService;
  @override
  void onInit() {
    _productService = ProductServices();

    super.onInit();
  }

  // Observables for products and loading state
  var products = <ProductResponse>[].obs;
  final product = Rx<ProductResponse?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Fetch products by title
  Future<void> fetchProducts() async {
    try {
      isLoading.value = true; // Set loading state
      errorMessage.value = ''; // Reset error message

      final response = await _productService.products();
      log(response.toString());
      if (response.data != null) {
        product.value = response.data!;
        log(response.data!.toString());
      } else {
        errorMessage.value = response.message ?? 'No products found';
      }
    } catch (e) {
      errorMessage.value = e.toString(); // Capture the error message
    } finally {
      isLoading.value = false; // Reset loading state
    }
  }
}
