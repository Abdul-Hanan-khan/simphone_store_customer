import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/api_response/get_user_api_response.dart';
import '../../utils/api_constants/api_constants.dart';

class UserGetApi {
  Future<GetUserApiResponse> getUserRequest() async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio.get(
        ApiConstants.getUser,
      );
      return GetUserApiResponse.fromJson(response.data);
    } catch (e) {
      return GetUserApiResponse.fromJson(e.toString());
    }
  }
}
