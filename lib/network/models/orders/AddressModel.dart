/// id : 2
/// phoneNumber : "0530998727"
/// address : "First Street"
/// cityId : 2
/// enCityName : "Jeddah"
/// arCityName : "جدة"
/// country : "KSA"
/// longitude : 100.6
/// latitude : 200.5
/// userId : "d7698b60-e64a-4e10-8fdd-e9fe9166ca7f"

class AddressModel {
  AddressModel({
    int? id,
    String? phoneNumber,
    String? address,
    int? cityId,
    String? enCityName,
    String? arCityName,
    String? country,
    num? longitude,
    num? latitude,
    String? userId,
  }) {
    _id = id;
    _phoneNumber = phoneNumber;
    _address = address;
    _cityId = cityId;
    _enCityName = enCityName;
    _arCityName = arCityName;
    _country = country;
    _longitude = longitude;
    _latitude = latitude;
    _userId = userId;
  }

  AddressModel.fromJson(dynamic json) {
    _id = json['id'];
    _phoneNumber = json['phoneNumber'];
    _address = json['address'];
    _cityId = json['cityId'];
    _enCityName = json['enCityName'];
    _arCityName = json['arCityName'];
    _country = json['country'];
    _longitude = json['longitude'];
    _latitude = json['latitude'];
    _userId = json['userId'];
  }
  int? _id;
  String? _phoneNumber;
  String? _address;
  int? _cityId;
  String? _enCityName;
  String? _arCityName;
  String? _country;
  num? _longitude;
  num? _latitude;
  String? _userId;

  int? get id => _id;
  String? get phoneNumber => _phoneNumber;
  String? get address => _address;
  int? get cityId => _cityId;
  String? get enCityName => _enCityName;
  String? get arCityName => _arCityName;
  String? get country => _country;
  num? get longitude => _longitude;
  num? get latitude => _latitude;
  String? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['phoneNumber'] = _phoneNumber;
    map['address'] = _address;
    map['cityId'] = _cityId;
    map['enCityName'] = _enCityName;
    map['arCityName'] = _arCityName;
    map['country'] = _country;
    map['longitude'] = _longitude;
    map['latitude'] = _latitude;
    map['userId'] = _userId;
    return map;
  }
}
