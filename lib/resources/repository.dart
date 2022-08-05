import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sim_phone/models/api_response/all_captain_api_response.dart';
import 'package:sim_phone/models/api_response/captain_sims_api_response.dart';
import 'package:sim_phone/models/api_response/customer_orders_api_response.dart';
import 'package:sim_phone/models/api_response/update_user_api_response.dart';
import 'package:sim_phone/resources/api_providers/all_captain_get_api.dart';
import 'package:sim_phone/resources/api_providers/captain_sims_get_api.dart';
import 'package:sim_phone/resources/api_providers/customer_orders_get_api.dart';
import 'package:sim_phone/resources/api_providers/sim_order_post_api.dart';
import 'package:sim_phone/resources/api_providers/update_user_put_api.dart';

import '../models/api_response/all_devices_api_response.dart';
import '../models/api_response/all_phone_api_response.dart';
import '../models/api_response/all_sim_api_response.dart';
import '../models/api_response/device_order_api_response.dart';
import '../models/api_response/get_user_api_response.dart';
import '../models/api_response/mobile_order_api_response.dart';
import '../models/api_response/order_product_api_response.dart';
import '../models/api_response/sign_in_api_response.dart';
import '../models/api_response/sign_up_api_response.dart';
import 'api_providers/all_devices_get_api.dart';
import 'api_providers/all_phones_get_api.dart';
import 'api_providers/all_sims_get_api.dart';
import 'api_providers/sign_in_post_api.dart';
import 'api_providers/sign_up_post_api.dart';
import 'api_providers/user_get_api.dart';

class Repository {
  Future<SignUpApiResponse> signUp({String? name,String ?cnic,String ?email,String ?phone,String ?address,String? password,String ?lat,String ?long, XFile? imageFile}) {
    final signUpPost = SignUpPostApi();
    return signUpPost.signUpRequest(name: name,cnic: cnic,email: email,phone: phone,address: address,password: password,lat: lat,long: long,avatarFile: imageFile);
  }

  Future<SignInApiResponse> signIn(Map data) {
    final signUpPost = SignInPostApi();
    return signUpPost.signInRequest(data);
  }

  Future<AllSimApiResponse> allSim() async {
    return AllSimsGetApi().allSimsRequest();
  }

  Future<AllSimApiResponse> searchSim(Map data) async {
    return AllSimsGetApi().searchSimsRequest(data);
  }

  Future<AllDevicesApiResponse> allDevices() async {
    return AllDevicesGetApi().allDevicesRequest();
  }

  Future<DeviceOrderApiResponse> deviceOrder(Map data) async {
    return AllDevicesGetApi().devicesOrderRequest(data);
  }

  Future<AllPhoneApiResponse> allPhone() async {
    return AllPhonesGetApi().allPhonesRequest();
  }

  Future<MobileOrderApiResponse> phoneOrder(Map data) async {
    return AllPhonesGetApi().mobileOrderRequest(data);
  }

  Future<OrderProductApiResponse> simOrderRequest(Map data) async {
    return SimOrderPostApi().simOrderRequest(data);
  }

  Future<CustomerOrdersApiResponse> customerRequest() async {
    return CustomerOrdersGetApi().customerOrdersRequest();
  }

  Future<GetUserApiResponse> getUserRequest() async {
    return UserGetApi().getUserRequest();
  }

  Future<AllCaptainApiResponse> allCaptain() async {
    return AllCaptainGetApi().allCaptainRequest();
  }

  Future<CaptainSimsApiResponse> allCaptainSims(String id) async {
    return CaptainSimGetApi().captainAllSimsRequest(id);
  }

  Future<UpdateUserApiResponse> updateUser({String ? name,String ? address,String ? phone,XFile ? imageFile,}) async {
    return UpdateUserPutApi().updateUserRequest(name: name,phone: phone,address: address,imageFile: imageFile);
  }
}
