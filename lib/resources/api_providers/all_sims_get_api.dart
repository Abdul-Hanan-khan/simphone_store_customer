import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/api_response/all_sim_api_response.dart';
import '../../utils/api_constants/api_constants.dart';

class AllSimsGetApi {
  Future<AllSimApiResponse> allSimsRequest() async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio.get(
        ApiConstants.allSims,
      );
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        return AllSimApiResponse.fromJson(response.data);
      } else {
        return AllSimApiResponse(result: false);
      }
    } catch (e) {
      if (e is DioError) {
        return AllSimApiResponse.fromJson(e.response?.data);
      } else {
        return AllSimApiResponse(result: false);
      }
    }
  }
  Future<AllSimApiResponse> searchSimsRequest(Map data) async {
    try {
      final Dio dio = Dio();
      final Response response = await dio.post(
        ApiConstants.simSearch,
        data: data,
      );
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        return AllSimApiResponse.fromJson(response.data);
      } else {
        return AllSimApiResponse(result: false);
      }
    } catch (e) {
      if (e is DioError) {
        return AllSimApiResponse.fromJson(e.response?.data);
      } else {
        return AllSimApiResponse(result: false);
      }
    }
  }
}
