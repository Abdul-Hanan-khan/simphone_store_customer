class GetUserApiResponse {
  GetUserApiResponse({
      Location? location, 
      String? id, 
      String? name, 
      int? cnic, 
      String? email, 
      String? phone, 
      String? role, 
      String? status, 
      String? area, 
      List<dynamic>? inventory, 
      String? avatar, 
      int? v,}){
    _location = location;
    _id = id;
    _name = name;
    _cnic = cnic;
    _email = email;
    _phone = phone;
    _role = role;
    _status = status;
    _area = area;
    _inventory = inventory;
    _avatar = avatar;
    _v = v;
}

  GetUserApiResponse.fromJson(dynamic json) {
    _location = json['location'] != null ? Location.fromJson(json['location']) : null;
    _id = json['_id'];
    _name = json['name'];
    _cnic = json['cnic'];
    _email = json['email'];
    _phone = json['phone'];
    _role = json['role'];
    _status = json['status'];
    _area = json['area'];
    if (json['inventory'] != null) {
      _inventory = [];
      json['inventory'].forEach((v) {
        _inventory?.add(v);
      });
    }
    _avatar = json['avatar'];
    _v = json['__v'];
  }
  Location? _location;
  String? _id;
  String? _name;
  int? _cnic;
  String? _email;
  String? _phone;
  String? _role;
  String? _status;
  String? _area;
  List<dynamic>? _inventory;
  String? _avatar;
  int? _v;

  Location? get location => _location;
  String? get id => _id;
  String? get name => _name;
  int? get cnic => _cnic;
  String? get email => _email;
  String? get phone => _phone;
  String? get role => _role;
  String? get status => _status;
  String? get area => _area;
  List<dynamic>? get inventory => _inventory;
  String? get avatar => _avatar;
  int? get v => _v;


}

class Location {
  Location({
      String? type, 
      List<int>? coordinates,}){
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['coordinates'] = _coordinates;
    return map;
  }

}