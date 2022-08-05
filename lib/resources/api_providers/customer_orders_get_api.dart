import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/api_response/customer_orders_api_response.dart';
import '../../utils/api_constants/api_constants.dart';

class CustomerOrdersGetApi {
  Future<CustomerOrdersApiResponse> customerOrdersRequest() async {
    try {
      final Dio dio = Dio();
      dio.options.headers["x-auth-token"] = GetStorage().read('token');
      final Response response = await dio.get(
        ApiConstants.customerOrder,
      );
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        return CustomerOrdersApiResponse.fromJson(response.data);
      } else {
        return CustomerOrdersApiResponse(result: false);
      }
    } catch (e) {
      if (e is DioError) {
        return CustomerOrdersApiResponse.fromJson(e.response?.data);
      } else {
        return CustomerOrdersApiResponse(result: false);
      }
    }
  }
}
