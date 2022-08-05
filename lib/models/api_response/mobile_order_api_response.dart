import '../data_models/captain.dart';

class MobileOrderApiResponse {
  MobileOrderApiResponse({
      bool? result, 
      String? message, 
      Order? order,}){
    _result = result;
    _message = message;
    _order = order;
}

  MobileOrderApiResponse.fromJson(dynamic json) {
    _result = json['result'];
    _message = json['message'];
    _order = json['order'] != null ? Order.fromJson(json['order']) : null;
  }
  bool? _result;
  String? _message;
  Order? _order;

  bool? get result => _result;
  String? get message => _message;
  Order? get order => _order;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['result'] = _result;
    map['message'] = _message;
    if (_order != null) {
      map['order'] = _order?.toJson();
    }
    return map;
  }

}

class Order {
  Order({
      int? totalBill, 
      String? status, 
      Customer? customer, 
      Captain? captain, 
      String? id, 
      String? date, 
      String? latitude, 
      String? longitude,}){
    _totalBill = totalBill;
    _status = status;
    _customer = customer;
    _captain = captain;
    _id = id;
    _date = date;
    _latitude = latitude;
    _longitude = longitude;
}

  Order.fromJson(dynamic json) {
    _totalBill = json['totalBill'];
    _status = json['status'];
    _customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    _captain = json['captain'] != null ? Captain.fromJson(json['captain']) : null;
    _id = json['_id'];
    _date = json['date'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }
  int? _totalBill;
  String? _status;
  Customer? _customer;
  Captain? _captain;
  String? _id;
  String? _date;
  String? _latitude;
  String? _longitude;

  int? get totalBill => _totalBill;
  String? get status => _status;
  Customer? get customer => _customer;
  Captain? get captain => _captain;
  String? get id => _id;
  String? get date => _date;
  String? get latitude => _latitude;
  String? get longitude => _longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalBill'] = _totalBill;
    map['status'] = _status;
    if (_customer != null) {
      map['customer'] = _customer?.toJson();
    }
    if (_captain != null) {
      map['captain'] = _captain?.toJson();
    }
    map['_id'] = _id;
    map['date'] = _date;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    return map;
  }

}


class Customer {
  Customer({
      String? id, 
      String? name, 
      int? phone,}){
    _id = id;
    _name = name;
    _phone = phone;
}

  Customer.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _phone = json['phone'];
  }
  String? _id;
  String? _name;
  int? _phone;

  String? get id => _id;
  String? get name => _name;
  int? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['phone'] = _phone;
    return map;
  }

}