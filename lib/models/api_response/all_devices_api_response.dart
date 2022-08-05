class AllDevicesApiResponse {
  AllDevicesApiResponse({
      bool? result, 
      String? message, 
      List<Devices>? devices,}){
    _result = result;
    _message = message;
    _devices = devices;
}

  AllDevicesApiResponse.fromJson(dynamic json) {
    _result = json['result'];
    _message = json['message'];
    if (json['devices'] != null) {
      _devices = [];
      json['devices'].forEach((v) {
        _devices?.add(Devices.fromJson(v));
      });
    }
  }
  bool? _result;
  String? _message;
  List<Devices>? _devices;

  bool? get result => _result;
  String? get message => _message;
  List<Devices>? get devices => _devices;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['result'] = _result;
    map['message'] = _message;
    if (_devices != null) {
      map['devices'] = _devices?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Devices {
  Devices({
      String? id, 
      String? deviceType, 
      String? network, 
      String? name, 
      int? price, 
      List<String>? pics, 
      int? v,}){
    _id = id;
    _deviceType = deviceType;
    _network = network;
    _name = name;
    _price = price;
    _pics = pics;
    _v = v;
}

  Devices.fromJson(dynamic json) {
    _id = json['_id'];
    _deviceType = json['deviceType'];
    _network = json['network'];
    _name = json['name'];
    _price = json['price'];
    _pics = json['pics'] != null ? json['pics'].cast<String>() : [];
    _v = json['__v'];
  }
  String? _id;
  String? _deviceType;
  String? _network;
  String? _name;
  int? _price;
  List<String>? _pics;
  int? _v;

  String? get id => _id;
  String? get deviceType => _deviceType;
  String? get network => _network;
  String? get name => _name;
  int? get price => _price;
  List<String>? get pics => _pics;
  int? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['deviceType'] = _deviceType;
    map['network'] = _network;
    map['name'] = _name;
    map['price'] = _price;
    map['pics'] = _pics;
    map['__v'] = _v;
    return map;
  }

}