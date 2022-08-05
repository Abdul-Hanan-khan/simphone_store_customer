class AllPhoneApiResponse {
  AllPhoneApiResponse({
      bool? result, 
      String? message, 
      List<Mobiles>? mobiles,}){
    _result = result;
    _message = message;
    _mobiles = mobiles;
}

  AllPhoneApiResponse.fromJson(dynamic json) {
    _result = json['result'];
    _message = json['message'];
    if (json['mobiles'] != null) {
      _mobiles = [];
      json['mobiles'].forEach((v) {
        _mobiles?.add(Mobiles.fromJson(v));
      });
    }
  }
  bool? _result;
  String? _message;
  List<Mobiles>? _mobiles;

  bool? get result => _result;
  String? get message => _message;
  List<Mobiles>? get mobiles => _mobiles;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['result'] = _result;
    map['message'] = _message;
    if (_mobiles != null) {
      map['mobiles'] = _mobiles?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Mobiles {
  Mobiles({
      String? id, 
      String? deviceType, 
      String? network, 
      String? model, 
      String? name, 
      String? size, 
      int? price, 
      List<String>? pics, 
      int? v,}){
    _id = id;
    _deviceType = deviceType;
    _network = network;
    _model = model;
    _name = name;
    _size = size;
    _price = price;
    _pics = pics;
    _v = v;
}

  Mobiles.fromJson(dynamic json) {
    _id = json['_id'];
    _deviceType = json['deviceType'];
    _network = json['network'];
    _model = json['model'];
    _name = json['name'];
    _size = json['size'];
    _price = json['price'];
    _pics = json['pics'] != null ? json['pics'].cast<String>() : [];
    _v = json['__v'];
  }
  String? _id;
  String? _deviceType;
  String? _network;
  String? _model;
  String? _name;
  String? _size;
  int? _price;
  List<String>? _pics;
  int? _v;

  String? get id => _id;
  String? get deviceType => _deviceType;
  String? get network => _network;
  String? get model => _model;
  String? get name => _name;
  String? get size => _size;
  int? get price => _price;
  List<String>? get pics => _pics;
  int? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['deviceType'] = _deviceType;
    map['network'] = _network;
    map['model'] = _model;
    map['name'] = _name;
    map['size'] = _size;
    map['price'] = _price;
    map['pics'] = _pics;
    map['__v'] = _v;
    return map;
  }

}