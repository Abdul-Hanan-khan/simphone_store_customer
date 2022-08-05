
import 'package:dio/dio.dart';

import '../../models/api_response/all_captain_api_response.dart';
import '../../utils/api_constants/api_constants.dart';

class AllCaptainGetApi{

  Future<AllCaptainApiResponse> allCaptainRequest() async {
    try {
      final Dio dio = Dio();
      final Response response = await dio.get(
        ApiConstants.getAllCaptain,
      );
      if (response.statusCode == 200) {
        print(response.data);
        return AllCaptainApiResponse.fromJson(response.data);
      } else {
        return AllCaptainApiResponse(result: false);
      }
    } catch (e) {
      if (e is DioError) {
        return AllCaptainApiResponse.fromJson(e.response?.data);
      } else {
        return AllCaptainApiResponse(result: false);
      }
    }
  }

}