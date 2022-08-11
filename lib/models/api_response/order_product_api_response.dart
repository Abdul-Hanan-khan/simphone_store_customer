import '../data_models/captain.dart';

class OrderProductApiResponse {
  OrderProductApiResponse({
      bool? result, 
      String? message, 
      Order? order,}){
    _result = result;
    _message = message;
    _order = order;
}

  OrderProductApiResponse.fromJson(dynamic json) {
    _result = json['result']??false;
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
      String? lat, 
      String? long, 
      String? recieverName, 
      String? contactNo, 
      String? email, 
      String? deliveryAddress, 
      Product? product, 
      Customer? customer, 
      Captain? captain, 
      String? id, 
      String? date, 
      int? v,}){
    _totalBill = totalBill;
    _status = status;
    _lat = lat;
    _long = long;
    _recieverName = recieverName;
    _contactNo = contactNo;
    _email = email;
    _deliveryAddress = deliveryAddress;
    _product = product;
    _customer = customer;
    _captain = captain;
    _id = id;
    _date = date;
    _v = v;
}

  Order.fromJson(dynamic json) {
    _totalBill = json['totalBill'];
    _status = json['status'];
    _lat = json['lat'];
    _long = json['long'];
    _recieverName = json['recieverName'];
    _contactNo = json['contactNo'];
    _email = json['email'];
    _deliveryAddress = json['deliveryAddress'];
    _product = json['product'] != null ? Product.fromJson(json['product']) : null;
    _customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    _captain = json['captain'] != null ? Captain.fromJson(json['captain']) : null;
    _id = json['_id'];
    _date = json['date'];
    _v = json['__v'];
  }
  int? _totalBill;
  String? _status;
  String? _lat;
  String? _long;
  String? _recieverName;
  String? _contactNo;
  String? _email;
  String? _deliveryAddress;
  Product? _product;
  Customer? _customer;
  Captain? _captain;
  String? _id;
  String? _date;
  int? _v;

  int? get totalBill => _totalBill;
  String? get status => _status;
  String? get lat => _lat;
  String? get long => _long;
  String? get recieverName => _recieverName;
  String? get contactNo => _contactNo;
  String? get email => _email;
  String? get deliveryAddress => _deliveryAddress;
  Product? get product => _product;
  Customer? get customer => _customer;
  Captain? get captain => _captain;
  String? get id => _id;
  String? get date => _date;
  int? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalBill'] = _totalBill;
    map['status'] = _status;
    map['lat'] = _lat;
    map['long'] = _long;
    map['recieverName'] = _recieverName;
    map['contactNo'] = _contactNo;
    map['email'] = _email;
    map['deliveryAddress'] = _deliveryAddress;
    if (_product != null) {
      map['product'] = _product?.toJson();
    }
    if (_customer != null) {
      map['customer'] = _customer?.toJson();
    }
    if (_captain != null) {
      map['captain'] = _captain?.toJson();
    }
    map['_id'] = _id;
    map['date'] = _date;
    map['__v'] = _v;
    return map;
  }

}


class Customer {
  Customer({
      String? id, 
      String? name,
      String? phone,}){
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
  String? _phone;

  String? get id => _id;
  String? get name => _name;
  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['phone'] = _phone;
    return map;
  }

}

class Product {
  Product({
      String? id, 
      String? type, 
      String? network, 
      String? nameOrNum, 
      int? price,}){
    _id = id;
    _type = type;
    _network = network;
    _nameOrNum = nameOrNum;
    _price = price;
}

  Product.fromJson(dynamic json) {
    _id = json['_id'];
    _type = json['type'];
    _network = json['network'];
    _nameOrNum = json['NameOrNum'];
    _price = json['price'];
  }
  String? _id;
  String? _type;
  String? _network;
  String? _nameOrNum;
  int? _price;

  String? get id => _id;
  String? get type => _type;
  String? get network => _network;
  String? get nameOrNum => _nameOrNum;
  int? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['type'] = _type;
    map['network'] = _network;
    map['NameOrNum'] = _nameOrNum;
    map['price'] = _price;
    return map;
  }

}