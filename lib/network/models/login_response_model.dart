

/// user : {"id":"897fd3ea-e138-4947-aa94-6749584d1a4b","email":"nolemohd.000@gmail.com","phoneNumber":"0576543980","driverName":"Manal test","companyName":"t","commercialRegistrationNo":"9998887779","branchNumber":4,"branches":[]}
/// token : "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI4OTdmZDNlYS1lMTM4LTQ5NDctYWE5NC02NzQ5NTg0ZDFhNGIiLCJ1bmlxdWVfbmFtZSI6Im5vbGVtb2hkLjAwMEBnbWFpbC5jb20iLCJyb2xlIjoiQ29tcGFueSIsIm5iZiI6MTY0MTA1MjA1NCwiZXhwIjoxNjQxMTM4NDU0LCJpYXQiOjE2NDEwNTIwNTR9.4Qj8Ooihja1_hP3V1_xb0GDUreo6CxRbFCiGYfxtp8F4198Ou0_GkwVryDlNCkbKcQZAMC632ZHOV3ZCPmQxTQ"

class LoginResponseModel {
  LoginResponseModel({
      User? user, 
     required String token,}){
    _user = user;
    _token = token;
}

  LoginResponseModel.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _token = json['token'];
  }
  User? _user;
  String _token = '';

  User? get user => _user;
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

/// id : "897fd3ea-e138-4947-aa94-6749584d1a4b"
/// email : "nolemohd.000@gmail.com"
/// phoneNumber : "0576543980"
/// ownerName : "Manal test"
/// companyName : "t"
/// commercialRegistrationNo : "9998887779"
/// branchNumber : 4
/// branches : []

class User {
  User({
     required String id,
      String? email, 
      String? phoneNumber, 
      String? driverName, 
});


  User.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _phoneNumber = json['phoneNumber'];
    _driverName = json['driverName'];
  }
  String _id='';
  String? _email;
  String? _phoneNumber;
  String? _driverName;



  String? get id => _id;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get driverName => _driverName;



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['phoneNumber'] = _phoneNumber;
    map['driverName'] = _driverName;

    return map;
  }

}