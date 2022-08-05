import '../data_models/captain.dart';
import '../data_models/sim.dart';

class AllSimApiResponse {
  AllSimApiResponse({
      bool? result, 
      String? message, 
      List<CaptainSims>? data,}){
    _result = result;
    _message = message;
    _data = data;
}

  AllSimApiResponse.fromJson(dynamic json) {
    _result = json['result'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CaptainSims.fromJson(v));
      });
    }
  }
  bool? _result;
  String? _message;
  List<CaptainSims>? _data;

  bool? get result => _result;
  String? get message => _message;
  List<CaptainSims>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['result'] = _result;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class CaptainSims {
  CaptainSims({
      Captain? captain, 
      List<Sims>? sims,}){
    _captain = captain;
    _sims = sims;
}

  CaptainSims.fromJson(dynamic json) {
    _captain = json['captain'] != null ? Captain.fromJson(json['captain']) : null;
    if (json['sims'] != null) {
      _sims = [];
      json['sims'].forEach((v) {
        _sims?.add(Sims.fromJson(v));
      });
    }
  }
  Captain? _captain;
  List<Sims>? _sims;

  Captain? get captain => _captain;
  List<Sims>? get sims => _sims;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_captain != null) {
      map['captain'] = _captain?.toJson();
    }
    if (_sims != null) {
      map['sims'] = _sims?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

