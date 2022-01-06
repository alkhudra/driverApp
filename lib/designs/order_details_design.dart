import 'package:flutter/material.dart';

Widget orderDetailsDesign(context) {
  return Container(
    width: MediaQuery.of(context).size.width/2,
    height: MediaQuery.of(context).size.height/5,
    child: Row(
      children: [
        Container(
          width: 100,
          height: 100,
          child: Image.asset('assets/images/product_green.png'),
        ),
        SizedBox(width: 10,),
        // Column(
        //   children: [
            
        //   ],
        // ),
      ],
    ),
  );
}