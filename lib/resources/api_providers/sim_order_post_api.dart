import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/api_response/order_product_api_response.dart';
import '../../utils/api_constants/api_constants.dart';

class SimOrderPostApi {
  Future<OrderProductApiResponse> simOrderRequest(Map _formData) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio.post(
        ApiConstants.productOrder,
        data: _formData,
      );
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        return OrderProductApiResponse.fromJson(response.data);
      } else {
        return OrderProductApiResponse(result: false);
      }
    } catch (e) {
      if (e is DioError) {
        print(e.response?.data);
        return OrderProductApiResponse.fromJson(e.response?.data);
      } else {
        return OrderProductApiResponse(result: false);
      }
    }
  }
}
