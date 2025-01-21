import 'package:dio/dio.dart';
import 'package:ezy_shop/app/models/product_response.dart';
import '../endpoints/products_endpoint.dart';
import '../models/generic_object_response.dart';
import '../network/api_client.dart';

class ProductServices {
  final _dio = ApiClient.dio;

  Future<GenericObjectResponse<ProductResponse>> products(
      Map<String, dynamic>? queryParameters) async {
    try {
      final response = await _dio.get(ProductsEndPoints.productsUrl,
          queryParameters: queryParameters);
      final data = GenericObjectResponse.fromJson(
          response.data, (data) => ProductResponse.fromJson(data));
      return data;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Sign-in failed');
    }
  }
}
