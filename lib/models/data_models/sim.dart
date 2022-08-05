import 'package:sim_phone/models/data_models/captain.dart';
import 'package:sim_phone/models/data_models/package.dart';

class Sims {
  Sims({
    String? id,
    String? network,
    String? type,
    String? series,
    String? no,
    int? price,
    bool? available,
    Captain? captain,
    Package? package,
    int? v,
    int? discount,
    int? discountPrice,}){
    _id = id;
    _network = network;
    _type = type;
    _series = series;
    _no = no;
    _price = price;
    _available = available;
    _captain = captain;
    _package = package;
    _v = v;
    _discount = discount;
    _discountPrice = discountPrice;
  }

  Sims.fromJson(dynamic json) {
    _id = json['_id'];
    _network = json['network'];
    _type = json['type'];
    _series = json['series'];
    _no = json['no'];
    _price = json['price'];
    _available = json['available'];
    _captain = json['captain'] != null ? Captain.fromJson(json['captain']) : null;
    _package = json['package'] != null ? Package.fromJson(json['package']) : null;
    _v = json['__v'];
    _discount = json['discount'];
    _discountPrice = json['discountPrice'];
  }
  String? _id;
  String? _network;
  String? _type;
  String? _series;
  String? _no;
  int? _price;
  bool? _available;
  Captain? _captain;
  Package? _package;
  int? _v;
  int? _discount;
  int? _discountPrice;

  String? get id => _id;
  String? get network => _network;
  String? get type => _type;
  String? get series => _series;
  String? get no => _no;
  int? get price => _price;
  bool? get available => _available;
  Captain? get captain => _captain;
  Package? get package => _package;
  int? get v => _v;
  int? get discount => _discount;
  int? get discountPrice => _discountPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['network'] = _network;
    map['type'] = _type;
    map['series'] = _series;
    map['no'] = _no;
    map['price'] = _price;
    map['available'] = _available;
    if (_captain != null) {
      map['captain'] = _captain?.toJson();
    }
    if (_package != null) {
      map['package'] = _package?.toJson();
    }
    map['__v'] = _v;
    map['discount'] = _discount;
    map['discountPrice'] = _discountPrice;
    return map;
  }

}