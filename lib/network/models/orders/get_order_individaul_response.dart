

import 'OrderHeaderIndividual.dart';



class GetOrdersIndividualResponseModel {
  List<OrderHeaderIndividual> _orderList = [];
  String? message;

  List<OrderHeaderIndividual> get orderList =>
      _orderList;

  GetOrdersIndividualResponseModel.fromJson(dynamic json) {

    if (json != null) {
      _orderList = [];
      json.forEach((v) {
        _orderList.add(OrderHeaderIndividual.fromJson(v));
      });
    }
  }


  @override
  String toString() {
    return 'GetOrdersResponseModel{_orderList: $_orderList}';
  }

  GetOrdersIndividualResponseModel();

}

