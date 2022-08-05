import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/api_response/update_user_api_response.dart';
import '../../utils/api_constants/api_constants.dart';

import 'package:http/http.dart' as http;

class UpdateUserPutApi {
  // Future<UpdateUserApiResponse> updateUserRequest(FormData _formData) async {
  //   try {
  //     final Dio dio = Dio();
  //     dio.options.headers["x-auth-token"] = GetStorage().read('token');
  //     final Response response = await dio.put(
  //       ApiConstants.updateUser,
  //       data: _formData,
  //     );
  //     if (response.statusCode == 200) {
  //       print(response.data);
  //       return UpdateUserApiResponse.fromJson(response.data);
  //     } else {
  //       return UpdateUserApiResponse(result: false);
  //     }
  //   } catch (e) {
  //     if (e is DioError) {
  //       print(e.response?.data);
  //       return UpdateUserApiResponse.fromJson(e.response?.data);
  //     } else {
  //       return UpdateUserApiResponse(result: false);
  //     }
  //   }
  // }

  Future<UpdateUserApiResponse> updateUserRequest({String ?name,String ?address,String ?phone,XFile ?imageFile}) async {
    Uri _uri=Uri.parse(ApiConstants.updateUser);
    try {
      http.MultipartRequest request =  http.MultipartRequest("PUT", _uri);
      request.fields['name'] = name!;
      request.fields['address'] = address!;
      request.fields['phone'] = phone!;

      http.MultipartFile multipartFile = await http.MultipartFile.fromPath('avatar', imageFile!.path, );
      request.files.add(multipartFile);
      print(multipartFile);
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Accept': '*/*',
        'x-auth-token': '${GetStorage().read('token')}',

      });
      print(GetStorage().read("token"));
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        return UpdateUserApiResponse.fromJson(jsonDecode(response.body));
      } else {
        return UpdateUserApiResponse(result: false);
      }
    } catch (e) {
      if (e is DioError) {
        return UpdateUserApiResponse.fromJson(e.response?.data);
      } else {
        return UpdateUserApiResponse(result: false);
      }
    }
  }
}
