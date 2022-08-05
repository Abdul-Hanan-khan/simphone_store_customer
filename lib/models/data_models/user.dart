class User {
  User({
    String? name,
    int? cnic,
    String? email,
    dynamic phone,
    String? role,
    String? status,
    String? area,
    String? id,
    List<dynamic>? inventory,
    String? avatar,
    String? password,
    int? v,}){
    _name = name;
    _cnic = cnic;
    _email = email;
    _phone = phone;
    _role = role;
    _status = status;
    _area = area;
    _id = id;
    _inventory = inventory;
    _avatar = avatar;
    _password = password;
    _v = v;
  }

  User.fromJson(dynamic json) {
    _name = json['name'];
    _cnic = json['cnic'];
    _email = json['email'];
    _phone = json['phone'];
    //_role = json['role'];
    _status = json['status'];
    _area = json['area'];
    _id = json['_id'];
    if (json['inventory'] != null) {
      _inventory = [];
      json['inventory'].forEach((v) {
        _inventory?.add(v);
      });
    }
    _avatar = json['avatar'];
    _password = json['password'];
    _v = json['__v'];
  }
  String? _name;
  int? _cnic;
  String? _email;
  dynamic _phone;
  String? _role;
  String? _status;
  String? _area;
  String? _id;
  List<dynamic>? _inventory;
  String? _avatar;
  String? _password;
  int? _v;

  String? get name => _name;
  int? get cnic => _cnic;
  String? get email => _email;
  dynamic get phone => _phone;
  String? get role => _role;
  String? get status => _status;
  String? get area => _area;
  String? get id => _id;
  List<dynamic>? get inventory => _inventory;
  String? get avatar => _avatar;
  String? get password => _password;
  int? get v => _v;


}