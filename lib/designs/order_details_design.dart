import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Widget orderDetailsDesign(context, category, proName, price, amount) {
  return Container(
    width: MediaQuery.of(context).size.width/1.2,
    height: MediaQuery.of(context).size.height/7,
    // color: kDarkBlue,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 60),
          width: 120,
          height: 120,
          child: Image.asset('assets/images/product_green.png'),
        ),
        // SizedBox(width: 2,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // padding: EdgeInsets.all(2),
              child: Text('$category', 
              style: TextStyle(color: kBlack.withOpacity(0.8), fontSize: 17),),
            ),
            SizedBox(height: 2,),
            Container(
              margin: EdgeInsets.only(left: 1, right: 1),
              child: Text('$proName', style: TextStyle(
                color: kLogoBrown, 
                fontSize: 16,
                fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 16,),
            Container(
              child: Text('$price SAR', style: TextStyle(
                color: kLogoGreen, 
                fontSize: 16,
                fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 5,),
          ],
        ),
        SizedBox(width: 115,),
        Container(
          alignment: Alignment.topRight,
          margin: EdgeInsets.only(top: 25),
          child: Text('$amount X', style: TextStyle(
            color: kBlack.withOpacity(0.8),
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),),
        ),
      ],
    ),
  );
}