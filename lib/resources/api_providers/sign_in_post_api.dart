import 'package:dio/dio.dart';

import '../../models/api_response/sign_in_api_response.dart';
import '../../utils/api_constants/api_constants.dart';

class SignInPostApi {
  Future<SignInApiResponse> signInRequest(Map _formData) async {
    try {
      final Dio dio = Dio();
      final Response response = await dio.post(
        ApiConstants.login,
        data: _formData,
      );
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        return SignInApiResponse.fromJson(response.data);
      } else {
        return SignInApiResponse(result: false);
      }
    } catch (e) {
      if (e is DioError) {
        return SignInApiResponse.fromJson(e.response?.data);
      } else {
        return SignInApiResponse(result: false);
      }
    }
  }
}
