import 'package:alkhudhrah_app/network/models/driver_user.dart';


class SuccessLoginResponseModel {
  SuccessLoginResponseModel({
      DriverUser? user, 
     required String token,}){
    _user = user;
    _token = token;
}

  SuccessLoginResponseModel.fromJson(dynamic json) {
    _user = json['user'] != null ? DriverUser.fromJson(json['user']) : null;
    _token = json['token'];
  }
  DriverUser? _user;
  String _token = '';

  DriverUser? get user => _user;
  String get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['token'] = _token;
    return map;
  }

}


