
import 'dart:developer';

import 'package:ezy_shop/app/services/product_services.dart';
import 'package:get/get.dart';

import '../models/product_response.dart';

class ProductController extends GetxController {
  late final ProductServices _productService;
  @override
  void onInit() {
    _productService = ProductServices();
    fetchProducts();
    super.onInit();
  }

  final allProducts = RxList<Products>([]);
  final products = RxList<Products>([]);
  // var products = <ProductResponse>[].obs;
  // final product = Rx<ProductResponse?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  final _debounce = Rxn<Function>();
  // Fetch products by title
  Future<void> fetchProducts() async {
    allProducts.clear();
    products.clear();
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _productService.products();

      if (response.data != null) {
        allProducts.addAll(response.data!.products!);
        products.addAll(response.data!.products!);
      } else {
        errorMessage.value = response.message ?? 'No products found';
      }
    } catch (e) {
      errorMessage.value = e.toString(); // Capture the error message
    } finally {
      isLoading.value = false; // Reset loading state
    }
  }

void onSearchChanged(String query) {
  log(query);
  debounce(
    products, 
    (_) {
      if (query.isEmpty) {
        products.value = allProducts;
      } else {
        products.value = allProducts.where((product) {
          final title = product.title?.toLowerCase() ?? '';
          return title.contains(query.toLowerCase());
        }).toList();
      }
      products.refresh();
    },
    
    time: const Duration(milliseconds: 500), // Delay
  );
}

}
