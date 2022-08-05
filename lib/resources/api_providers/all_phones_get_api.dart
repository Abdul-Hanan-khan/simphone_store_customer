import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/api_response/all_phone_api_response.dart';
import '../../models/api_response/mobile_order_api_response.dart';
import '../../utils/api_constants/api_constants.dart';

class AllPhonesGetApi {
  Future<AllPhoneApiResponse> allPhonesRequest() async {
    try {
      final Dio dio = Dio();
      final Response response = await dio.get(
        ApiConstants.allPhones,
      );
      if (response.statusCode == 200) {
        return AllPhoneApiResponse.fromJson(response.data);
      } else {
        return AllPhoneApiResponse(result: false);
      }
    } catch (e) {
      if (e is DioError) {
        return AllPhoneApiResponse.fromJson(e.response?.data);
      } else {
        return AllPhoneApiResponse(result: false);
      }
    }
  }

  Future<MobileOrderApiResponse> mobileOrderRequest(Map data) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio.post(
          ApiConstants.mobileOrder,
          data: data
      );
      if (response.statusCode == 200) {
        return MobileOrderApiResponse.fromJson(response.data);
      } else {
        return MobileOrderApiResponse(result: false);
      }
    } catch (e) {
      if (e is DioError) {
        print(e.response?.data);
        print(e.response?.data);
        print(e.response?.data);
        return MobileOrderApiResponse.fromJson(e.response?.data);
      } else {
        return MobileOrderApiResponse(result: false);
      }
    }
  }
}
