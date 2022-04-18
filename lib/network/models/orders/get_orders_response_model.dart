
import 'package:alkhudhrah_app/network/models/orders/order_header.dart';



class GetOrdersResponseModel {
  List<OrderHeader> _orderList = [];
  String? message;

  List<OrderHeader> get orderList =>
      _orderList; 

  GetOrdersResponseModel.fromJson(dynamic json) {

    if (json != null) {
      _orderList = [];
      json.forEach((v) {
        _orderList.add(OrderHeader.fromJson(v));
      });
    }
  }


  @override
  String toString() {
    return 'GetOrdersResponseModel{_orderList: $_orderList}';
  }

  GetOrdersResponseModel();

}

