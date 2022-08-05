import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/api_response/all_devices_api_response.dart';
import '../../models/api_response/device_order_api_response.dart';
import '../../utils/api_constants/api_constants.dart';

class AllDevicesGetApi {
  Future<AllDevicesApiResponse> allDevicesRequest() async {
    try {
      final Dio dio = Dio();
      final Response response = await dio.get(
        ApiConstants.allWifiDevices,
      );
      if (response.statusCode == 200) {
        return AllDevicesApiResponse.fromJson(response.data);
      } else {
        return AllDevicesApiResponse(result: false);
      }
    } catch (e) {
      if (e is DioError) {
        return AllDevicesApiResponse.fromJson(e.response?.data);
      } else {
        return AllDevicesApiResponse(result: false);
      }
    }
  }
  Future<DeviceOrderApiResponse> devicesOrderRequest(Map data) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio.post(
        ApiConstants.deviceOrder,
        data: data
      );
      if (response.statusCode == 200) {
        return DeviceOrderApiResponse.fromJson(response.data);
      } else {
        return DeviceOrderApiResponse(result: false);
      }
    } catch (e) {
      if (e is DioError) {
        print(e.response?.data);
        print(e.response?.data);
        print(e.response?.data);
        return DeviceOrderApiResponse.fromJson(e.response?.data);
      } else {
        return DeviceOrderApiResponse(result: false);
      }
    }
  }
}
