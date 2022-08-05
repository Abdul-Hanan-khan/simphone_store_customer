import '../data_models/user.dart';

class SignUpApiResponse {
  SignUpApiResponse({
      bool? result, 
      String? message, 
      User? user,}){
    _result = result;
    _message = message;
    _user = user;
}

  SignUpApiResponse.fromJson(dynamic json) {
    _result = json['result'];
    _message = json['message'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  bool? _result;
  String? _message;
  User? _user;

  bool? get result => _result;
  String? get message => _message;
  User? get user => _user;


}

