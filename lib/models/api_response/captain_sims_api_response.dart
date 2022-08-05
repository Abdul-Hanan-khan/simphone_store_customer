import '../data_models/sim.dart';

class CaptainSimsApiResponse {
  CaptainSimsApiResponse({
      bool? result, 
      String? message, 
      List<Sims>? sims,}){
    _result = result;
    _message = message;
    _sims = sims;
}

  CaptainSimsApiResponse.fromJson(dynamic json) {
    _result = json['result'];
    _message = json['message'];
    if (json['sims'] != null) {
      _sims = [];
      json['sims'].forEach((v) {
        _sims?.add(Sims.fromJson(v));
      });
    }
  }
  bool? _result;
  String? _message;
  List<Sims>? _sims;

  bool? get result => _result;
  String? get message => _message;
  List<Sims>? get sims => _sims;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['result'] = _result;
    map['message'] = _message;
    if (_sims != null) {
      map['sims'] = _sims?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}





