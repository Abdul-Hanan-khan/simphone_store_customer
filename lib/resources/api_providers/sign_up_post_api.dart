import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/api_response/sign_up_api_response.dart';
import '../../utils/api_constants/api_constants.dart';
import 'package:http/http.dart' as http;

class SignUpPostApi {
  // Future<SignUpApiResponse> signUpRequest(Map _formData) async {
  //   try {
  //     final Dio dio = Dio();
  //     final Response response = await dio.post(
  //       ApiConstants.signUp,
  //       data: _formData,
  //     );
  //     print(response.data);
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       print(response.data);
  //       return SignUpApiResponse.fromJson(response.data);
  //     } else {
  //       return SignUpApiResponse(result: false);
  //     }
  //   } catch (e) {
  //     if (e is DioError) {
  //       return SignUpApiResponse.fromJson(e.response?.data);
  //     } else {
  //       return SignUpApiResponse(result: false);
  //     }
  //   }
  // }

  Future<SignUpApiResponse> signUpRequest({
    String? name,
    String? cnic,
    String? email,
    String? phone,
    String? password,
    String? address,
    String? lat,
    String? long,
    XFile? avatarFile,
  }) async {
    Uri _uri = Uri.parse(ApiConstants.customerSignUp);
    try {
      http.MultipartRequest request = http.MultipartRequest("POST", _uri);
      request.fields['name'] = name!;
      request.fields['cnic'] = cnic!;
      request.fields['email'] = email!;
      request.fields['phone'] = phone!;
      request.fields['password'] = password!;
      request.fields['address'] = address!;
      request.fields['lat'] = lat!;
      request.fields['long'] = long!;

      if (avatarFile != null) {
        http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'avatar',
          avatarFile.path,
        );
        request.files.add(multipartFile);
        print(multipartFile);
      }
      // request.headers.addAll({
      //   'Content-Type': 'multipart/form-data',
      //   'Accept': '*/*',
      //   'x-auth-token': '${GetStorage().read('token')}',
      // });
      print(GetStorage().read("token"));
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        return SignUpApiResponse.fromJson(jsonDecode(response.body));
      } else {
        return SignUpApiResponse(result: false);
      }
    } catch (e) {
      if (e is DioError) {
        return SignUpApiResponse.fromJson(e.response?.data);
      } else {
        return SignUpApiResponse(result: false);
      }
    }
  }
}
