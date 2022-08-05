import '../data_models/user.dart';

class UpdateUserApiResponse {
  UpdateUserApiResponse({
    bool? result,
    String? message,
    User? user,
  }) {
    _result = result;
    _message = message;
    _user = user;
  }

  UpdateUserApiResponse.fromJson(dynamic json) {
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

class Location {
  Location({
    String? type,
    List<int>? coordinates,
  }) {
    _type = type;
    _coordinates = coordinates;
  }

  Location.fromJson(dynamic json) {
    _type = json['type'];
    _coordinates = json['coordinates'] != null ? json['coordinates'].cast<int>() : [];
  }

  String? _type;
  List<int>? _coordinates;

  String? get type => _type;

  List<int>? get coordinates => _coordinates;
}
