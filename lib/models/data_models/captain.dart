class Captain {
  Captain({
    String? id,
    String? name,
    int? phone,
    String? area,}){
    _id = id;
    _name = name;
    _phone = phone;
    _area = area;
  }

  Captain.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _phone = json['phone'];
    _area = json['area'];
  }
  String? _id;
  String? _name;
  int? _phone;
  String? _area;

  String? get id => _id;
  String? get name => _name;
  int? get phone => _phone;
  String? get area => _area;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['phone'] = _phone;
    map['area'] = _area;
    return map;
  }

}