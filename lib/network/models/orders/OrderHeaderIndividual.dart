import 'package:alkhudhrah_app/network/models/driver_user.dart';
import 'package:alkhudhrah_app/network/models/orders/AddressModel.dart';
import 'package:alkhudhrah_app/network/models/orders/order_items.dart';

import 'OrderItemIndividaul.dart';

/// id : 47
/// userId : "d7698b60-e64a-4e10-8fdd-e9fe9166ca7f"
/// addressId : 2
/// address : {"id":2,"phoneNumber":"0530998727","address":"First Street","cityId":2,"enCityName":"Jeddah","arCityName":"جدة","country":"KSA","longitude":100.6,"latitude":200.5,"userId":"d7698b60-e64a-4e10-8fdd-e9fe9166ca7f"}
/// orderStatus : "on_delivery"
/// orderCheckCode : "5482"
/// invoiceNumber : 1047
/// orderInitializedDate : "2022-10-21"
/// onDeliveryStatusDate : "2022-10-23 17:35"
/// deliveredStatusDate : null
/// driverId : "9fe2450d-8fa9-441b-86fc-842fb58d15a4"
/// driverUser : null
/// paymentType : "Cash"
/// paymentTypeAr : "كاش"
/// hasPaid : false
/// totalOrderPrice : 10
/// totalNetOrderPrice : 11.5
/// totalOrderVAT15 : 1.5
/// hasDiscount : false
/// hasCoupon : false
/// discountPercentage : 0
/// couponPercentage : 0
/// totalDiscount : 0
/// invoicePDFPath : "/HTMLFiles/1047.html"
/// orderCreatedFromDashboard : false
/// individualOrderItems : []

class OrderHeaderIndividual {
  OrderHeaderIndividual({
      int? id, 
      String? userId, 
      int? addressId, 
      AddressModel? address,
      String? orderStatus, 
      String? orderCheckCode, 
      int? invoiceNumber, 
      String? orderInitializedDate, 
      String? onDeliveryStatusDate,
    String? deliveredStatusDate,
      String? driverId, 
      DriverUser? driverUser,
      String? paymentType, 
      String? paymentTypeAr, 
      bool? hasPaid,
    num? totalOrderPrice,
    num? totalNetOrderPrice,
    num? totalOrderVAT15,
      bool? hasDiscount, 
      bool? hasCoupon,
    num? discountPercentage,
      num? couponPercentage,
    num? totalDiscount,
      String? invoicePDFPath, 
      bool? orderCreatedFromDashboard, 
      List<OrderItemIndividaul>? individualOrderItems,}){
    _id = id;
    _userId = userId;
    _addressId = addressId;
    _address = address;
    _orderStatus = orderStatus;
    _orderCheckCode = orderCheckCode;
    _invoiceNumber = invoiceNumber;
    _orderInitializedDate = orderInitializedDate;
    _onDeliveryStatusDate = onDeliveryStatusDate;
    _deliveredStatusDate = deliveredStatusDate;
    _driverId = driverId;
    _driverUser = driverUser;
    _paymentType = paymentType;
    _paymentTypeAr = paymentTypeAr;
    _hasPaid = hasPaid;
    _totalOrderPrice = totalOrderPrice;
    _totalNetOrderPrice = totalNetOrderPrice;
    _totalOrderVAT15 = totalOrderVAT15;
    _hasDiscount = hasDiscount;
    _hasCoupon = hasCoupon;
    _discountPercentage = discountPercentage;
    _couponPercentage = couponPercentage;
    _totalDiscount = totalDiscount;
    _invoicePDFPath = invoicePDFPath;
    _orderCreatedFromDashboard = orderCreatedFromDashboard;
    _individualOrderItems = individualOrderItems;
}

  OrderHeaderIndividual.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _addressId = json['addressId'];
    _address = json['address'] != null ? AddressModel.fromJson(json['address']) : null;
    _orderStatus = json['orderStatus'];
    _orderCheckCode = json['orderCheckCode'];
    _invoiceNumber = json['invoiceNumber'];
    _orderInitializedDate = json['orderInitializedDate'];
    _onDeliveryStatusDate = json['onDeliveryStatusDate'];
    _deliveredStatusDate = json['deliveredStatusDate'];
    _driverId = json['driverId'];
    _driverUser = json['driverUser'] != null ? DriverUser.fromJson(json['driverUser']) : null;
    _paymentType = json['paymentType'];
    _paymentTypeAr = json['paymentTypeAr'];
    _hasPaid = json['hasPaid'];
    _totalOrderPrice = json['totalOrderPrice'];
    _totalNetOrderPrice = json['totalNetOrderPrice'];
    _totalOrderVAT15 = json['totalOrderVAT15'];
    _hasDiscount = json['hasDiscount'];
    _hasCoupon = json['hasCoupon'];
    _discountPercentage = json['discountPercentage'];
    _couponPercentage = json['couponPercentage'];
    _totalDiscount = json['totalDiscount'];
    _invoicePDFPath = json['invoicePDFPath'];
    _orderCreatedFromDashboard = json['orderCreatedFromDashboard'];
    if (json['individualOrderItems'] != null) {
      _individualOrderItems = [];
      json['individualOrderItems'].forEach((v) {
        _individualOrderItems?.add(OrderItemIndividaul.fromJson(v));
      });
    }
  }
  int? _id;
  String? _userId;
  int? _addressId;
  AddressModel? _address;
  String? _orderStatus;
  String? _orderCheckCode;
  int? _invoiceNumber;
  String? _orderInitializedDate;
  String? _onDeliveryStatusDate;
  String? _deliveredStatusDate;
  String? _driverId;
  DriverUser? _driverUser;
  String? _paymentType;
  String? _paymentTypeAr;
  bool? _hasPaid;
  num? _totalOrderPrice;
  num? _totalNetOrderPrice;
  num? _totalOrderVAT15;
  bool? _hasDiscount;
  bool? _hasCoupon;
  num? _discountPercentage;
  num? _couponPercentage;
  num? _totalDiscount;
  String? _invoicePDFPath;
  bool? _orderCreatedFromDashboard;
  List<OrderItemIndividaul>? _individualOrderItems;

  int? get id => _id;
  String? get userId => _userId;
  int? get addressId => _addressId;
  AddressModel? get address => _address;
  String? get orderStatus => _orderStatus;
  String? get orderCheckCode => _orderCheckCode;
  int? get invoiceNumber => _invoiceNumber;
  String? get orderInitializedDate => _orderInitializedDate;
  String? get onDeliveryStatusDate => _onDeliveryStatusDate;
  String? get deliveredStatusDate => _deliveredStatusDate;
  String? get driverId => _driverId;
  DriverUser? get driverUser => _driverUser;
  String? get paymentType => _paymentType;
  String? get paymentTypeAr => _paymentTypeAr;
  bool? get hasPaid => _hasPaid;
  num? get totalOrderPrice => _totalOrderPrice;
  num? get totalNetOrderPrice => _totalNetOrderPrice;
  num? get totalOrderVAT15 => _totalOrderVAT15;
  bool? get hasDiscount => _hasDiscount;
  bool? get hasCoupon => _hasCoupon;
  num? get discountPercentage => _discountPercentage;
  num? get couponPercentage => _couponPercentage;
  num? get totalDiscount => _totalDiscount;
  String? get invoicePDFPath => _invoicePDFPath;
  bool? get orderCreatedFromDashboard => _orderCreatedFromDashboard;
  List<OrderItemIndividaul>? get orderItems => _individualOrderItems;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    map['addressId'] = _addressId;
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    map['orderStatus'] = _orderStatus;
    map['orderCheckCode'] = _orderCheckCode;
    map['invoiceNumber'] = _invoiceNumber;
    map['orderInitializedDate'] = _orderInitializedDate;
    map['onDeliveryStatusDate'] = _onDeliveryStatusDate;
    map['deliveredStatusDate'] = _deliveredStatusDate;
    map['driverId'] = _driverId;
    map['driverUser'] = _driverUser;
    map['paymentType'] = _paymentType;
    map['paymentTypeAr'] = _paymentTypeAr;
    map['hasPaid'] = _hasPaid;
    map['totalOrderPrice'] = _totalOrderPrice;
    map['totalNetOrderPrice'] = _totalNetOrderPrice;
    map['totalOrderVAT15'] = _totalOrderVAT15;
    map['hasDiscount'] = _hasDiscount;
    map['hasCoupon'] = _hasCoupon;
    map['discountPercentage'] = _discountPercentage;
    map['couponPercentage'] = _couponPercentage;
    map['totalDiscount'] = _totalDiscount;
    map['invoicePDFPath'] = _invoicePDFPath;
    map['orderCreatedFromDashboard'] = _orderCreatedFromDashboard;
    if (_individualOrderItems != null) {
      map['individualOrderItems'] = _individualOrderItems?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
