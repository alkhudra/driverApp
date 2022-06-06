

import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:flutter/material.dart';

// void showSuccessMessage(BuildContext context,String message){
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//     content: Text(message),
//   ));
// }

void showSuccessMessage(BuildContext context,String message){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration:Duration( seconds: 3),
    content: Text(message,style: TextStyle(
      color:  kWhite,
    ),),
    backgroundColor: kLogoGreen,
    behavior: SnackBarBehavior.floating,
  ));
}
