import '../data_models/captain.dart';

class SimOrderApiResponse {
  SimOrderApiResponse({
      bool? result, 
      String? message, 
      Order? order,}){
    _result = result;
    _message = message;
    _order = order;
}

  SimOrderApiResponse.fromJson(dynamic json) {
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
      String? latitude, 
      String? longitude, 
      Sim? sim, 
      Customer? customer, 
      Captain? captain, 
      String? id, 
      String? date, 
      List<dynamic>? sims, 
      List<dynamic>? wifiDevices, 
      List<dynamic>? mobiles, 
      int? v,}){
    _totalBill = totalBill;
    _status = status;
    _latitude = latitude;
    _longitude = longitude;
    _sim = sim;
    _customer = customer;
    _captain = captain;
    _id = id;
    _date = date;
    _sims = sims;
    _wifiDevices = wifiDevices;
    _mobiles = mobiles;
    _v = v;
}

  Order.fromJson(dynamic json) {
    _totalBill = json['totalBill'];
    _status = json['status'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _sim = json['sim'] != null ? Sim.fromJson(json['sim']) : null;
    _customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    _captain = json['captain'] != null ? Captain.fromJson(json['captain']) : null;
    _id = json['_id'];
    _date = json['date'];
    if (json['sims'] != null) {
      _sims = [];
      json['sims'].forEach((v) {
        _sims?.add(v);
      });
    }
    if (json['wifiDevices'] != null) {
      _wifiDevices = [];
      json['wifiDevices'].forEach((v) {
        _wifiDevices?.add(v);
      });
    }
    if (json['mobiles'] != null) {
      _mobiles = [];
      json['mobiles'].forEach((v) {
        _mobiles?.add(v);
      });
    }
    _v = json['__v'];
  }
  int? _totalBill;
  String? _status;
  String? _latitude;
  String? _longitude;
  Sim? _sim;
  Customer? _customer;
  Captain? _captain;
  String? _id;
  String? _date;
  List<dynamic>? _sims;
  List<dynamic>? _wifiDevices;
  List<dynamic>? _mobiles;
  int? _v;

  int? get totalBill => _totalBill;
  String? get status => _status;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  Sim? get sim => _sim;
  Customer? get customer => _customer;
  Captain? get captain => _captain;
  String? get id => _id;
  String? get date => _date;
  List<dynamic>? get sims => _sims;
  List<dynamic>? get wifiDevices => _wifiDevices;
  List<dynamic>? get mobiles => _mobiles;
  int? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalBill'] = _totalBill;
    map['status'] = _status;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    if (_sim != null) {
      map['sim'] = _sim?.toJson();
    }
    if (_customer != null) {
      map['customer'] = _customer?.toJson();
    }
    if (_captain != null) {
      map['captain'] = _captain?.toJson();
    }
    map['_id'] = _id;
    map['date'] = _date;
    if (_sims != null) {
      map['sims'] = _sims?.map((v) => v.toJson()).toList();
    }
    if (_wifiDevices != null) {
      map['wifiDevices'] = _wifiDevices?.map((v) => v.toJson()).toList();
    }
    if (_mobiles != null) {
      map['mobiles'] = _mobiles?.map((v) => v.toJson()).toList();
    }
    map['__v'] = _v;
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

class Sim {
  Sim({
      String? id, 
      String? network, 
      int? series, 
      int? no, 
      int? price,}){
    _id = id;
    _network = network;
    _series = series;
    _no = no;
    _price = price;
}

  Sim.fromJson(dynamic json) {
    _id = json['_id'];
    _network = json['network'];
    _series = json['series'];
    _no = json['no'];
    _price = json['price'];
  }
  String? _id;
  String? _network;
  int? _series;
  int? _no;
  int? _price;

  String? get id => _id;
  String? get network => _network;
  int? get series => _series;
  int? get no => _no;
  int? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['network'] = _network;
    map['series'] = _series;
    map['no'] = _no;
    map['price'] = _price;
    return map;
  }

}