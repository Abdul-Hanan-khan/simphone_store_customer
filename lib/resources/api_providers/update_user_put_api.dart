import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/api_response/update_user_api_response.dart';
import '../../utils/api_constants/api_constants.dart';

class UpdateUserPutApi {
  Future<UpdateUserApiResponse> updateUserRequest(FormData _formData) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio.put(
        ApiConstants.updateUser,
        data: _formData,
      );
      if (response.statusCode == 200) {
        print(response.data);
        return UpdateUserApiResponse.fromJson(response.data);
      } else {
        return UpdateUserApiResponse(result: false);
      }
    } catch (e) {
      if (e is DioError) {
        print(e.response?.data);
        return UpdateUserApiResponse.fromJson(e.response?.data);
      } else {
        return UpdateUserApiResponse(result: false);
      }
    }
  }
}
