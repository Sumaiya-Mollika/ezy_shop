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

  final products = RxList<Products>([]);
  final searchQuery = RxString("");

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> fetchProducts() async {
    products.clear();
    try {
      isLoading.value = true;
      errorMessage.value = '';
      Map<String, dynamic>? queryParameters = {
        if (searchQuery.value.isNotEmpty) "title": searchQuery.value
      };
      final response = await _productService.products(queryParameters);

      if (response.data != null) {
        products.clear();
        products.addAll(response.data!.products!);
      } else {
        errorMessage.value = response.message ?? 'No products found';
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    fetchProducts();
  }
}
