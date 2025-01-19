import 'package:dio/dio.dart';
import 'package:ezy_shop/app/models/generic_object_response.dart';

import '../endpoints/auth_endpoints.dart';

import '../models/user_data.dart';
import '../network/api_client.dart';

class AuthServices {
  final dio = DioClient.dio;

  Future<GenericObjectResponse<UserData>> signIn(
      Map<String, dynamic> request) async {
    try {
      final response = await dio.post(AuthEndPoints.signInUrl(), data: request);
      //   final jsonResponse = jsonDecode(response.data);
      return GenericObjectResponse.fromJson(
          response.data, (data) => UserData.fromJson(data));
      // return User.fromJson(jsonResponse);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Sign-in failed');
    }
  }
}
