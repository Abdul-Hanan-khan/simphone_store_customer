
import 'package:dio/dio.dart';

import '../../models/api_response/captain_sims_api_response.dart';
import '../../utils/api_constants/api_constants.dart';

class CaptainSimGetApi{

  Future<CaptainSimsApiResponse> captainAllSimsRequest(String id) async {
    try {
      final Dio dio = Dio();
      final Response response = await dio.get(
        ApiConstants.getCaptainSims + id,
      );
      print(response.data);
      if (response.statusCode == 200) {
        return CaptainSimsApiResponse.fromJson(response.data);
      } else {
        return CaptainSimsApiResponse(result: false);
      }
    } catch (e) {
      if (e is DioError) {
        return CaptainSimsApiResponse.fromJson(e.response?.data);
      } else {
        return CaptainSimsApiResponse(result: false);
      }
    }
  }

}