

import '../data_models/user.dart';

class SignInApiResponse {
  SignInApiResponse({
      bool? result, 
      String? message, 
      Data? data,}){
    _result = result;
    _message = message;
    _data = data;
}

  SignInApiResponse.fromJson(dynamic json) {
    _result = json['result'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _result;
  String? _message;
  Data? _data;

  bool? get result => _result;
  String? get message => _message;
  Data? get data => _data;


}

class Data {
  Data({
      String? token, 
      User? user,}){
    _token = token;
    _user = user;
}

  Data.fromJson(dynamic json) {
    _token = json['token'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? _token;
  User? _user;

  String? get token => _token;
  User? get user => _user;


}
