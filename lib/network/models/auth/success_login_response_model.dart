/// user : {"id":"89c32cb8-a199-4ccb-bf9d-454b33b3c87b","email":"Salmetaha@gmail.com","phoneNumber":"0576543954","driverName":"Salma"}
/// token : "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI4OWMzMmNiOC1hMTk5LTRjY2ItYmY5ZC00NTRiMzNiM2M4N2IiLCJ1bmlxdWVfbmFtZSI6IlNhbG1ldGFoYUBnbWFpbC5jb20iLCJyb2xlIjoiRHJpdmVyIiwibmJmIjoxNjQxNDY3MTUxLCJleHAiOjE2NDE1NTM1NTEsImlhdCI6MTY0MTQ2NzE1MX0.qQq5vFDJVvZ6V3nf63ZG6gMDQBnS2a7NrzCcMuN7uvTVXV3JUY8k0w3NwBmalbx7yz3Zeucr451gv4-JuoCi3g"

class SuccessLoginResponseModel {
  SuccessLoginResponseModel({
      User? user, 
     required String token,}){
    _user = user;
    _token = token;
}

  SuccessLoginResponseModel.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _token = json['token'];
  }
  User? _user;
  String _token ='';

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

/// id : "89c32cb8-a199-4ccb-bf9d-454b33b3c87b"
/// email : "Salmetaha@gmail.com"
/// phoneNumber : "0576543954"
/// driverName : "Salma"

class User {
  User({
      required String id,
      String? email, 
      String? phoneNumber, 
      String? driverName,}){
    _id = id;
    _email = email;
    _phoneNumber = phoneNumber;
    _driverName = driverName;
}

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

  String get id => _id;
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