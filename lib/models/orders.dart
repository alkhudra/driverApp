import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


class Orders {

  String productName = ""; 
  int productAmount = 0;
  //TODO: modify to include real time
  DateTime orderTime = DateTime.now();
  String orderBy = ""; 
  

  Orders(proName, proAmount, orTime, orBy) {
    productName = proName; 
    productAmount = proAmount; 
    orderBy = orBy;
    String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(orderTime);
    orTime = formattedDate;
  }

}