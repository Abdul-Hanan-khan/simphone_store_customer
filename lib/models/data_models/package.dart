class Package {
  Package({
    String? packageName,
    int? sameNetworkMins,
    int? otherNetworkMins,
    String? data,
    int? messages,
    String? expiry,
    String? id,}){
    _packageName = packageName;
    _sameNetworkMins = sameNetworkMins;
    _otherNetworkMins = otherNetworkMins;
    _data = data;
    _messages = messages;
    _expiry = expiry;
    _id = id;
  }

  Package.fromJson(dynamic json) {
    _packageName = json['packageName'];
    _sameNetworkMins = json['sameNetworkMins'];
    _otherNetworkMins = json['otherNetworkMins'];
    _data = json['data'];
    _messages = json['messages'];
    _expiry = json['expiry'];
    _id = json['_id'];
  }
  String? _packageName;
  int? _sameNetworkMins;
  int? _otherNetworkMins;
  String? _data;
  int? _messages;
  String? _expiry;
  String? _id;

  String? get packageName => _packageName;
  int? get sameNetworkMins => _sameNetworkMins;
  int? get otherNetworkMins => _otherNetworkMins;
  String? get data => _data;
  int? get messages => _messages;
  String? get expiry => _expiry;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['packageName'] = _packageName;
    map['sameNetworkMins'] = _sameNetworkMins;
    map['otherNetworkMins'] = _otherNetworkMins;
    map['data'] = _data;
    map['messages'] = _messages;
    map['expiry'] = _expiry;
    map['_id'] = _id;
    return map;
  }

}