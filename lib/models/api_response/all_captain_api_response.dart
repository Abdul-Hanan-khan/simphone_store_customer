class AllCaptainApiResponse {
  AllCaptainApiResponse({
      bool? result, 
      String? message, 
      List<Captains>? captains,}){
    _result = result;
    _message = message;
    _captains = captains;
}

  AllCaptainApiResponse.fromJson(dynamic json) {
    _result = json['result'];
    _message = json['message'];
    if (json['captains'] != null) {
      _captains = [];
      json['captains'].forEach((v) {
        _captains?.add(Captains.fromJson(v));
      });
    }
  }
  bool? _result;
  String? _message;
  List<Captains>? _captains;

  bool? get result => _result;
  String? get message => _message;
  List<Captains>? get captains => _captains;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['result'] = _result;
    map['message'] = _message;
    if (_captains != null) {
      map['captains'] = _captains?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Captains {
  Captains({
      String? id, 
      String? name, 
      String? area, 
      dynamic long,
      dynamic lat,}){
    _id = id;
    _name = name;
    _area = area;
    _long = long;
    _lat = lat;
}

  Captains.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _area = json['area'];
    _long = json['long'];
    _lat = json['lat'];
  }
  String? _id;
  String? _name;
  String? _area;
  dynamic _long;
  dynamic _lat;

  String? get id => _id;
  String? get name => _name;
  String? get area => _area;
  dynamic get long => _long;
  dynamic get lat => _lat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['area'] = _area;
    map['long'] = _long;
    map['lat'] = _lat;
    return map;
  }

}