import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/ui/order_status.dart';
import 'package:flutter/material.dart';


Widget orderTileDesign(context, scWidth, scHeight) {
  return ListTile(
    title: Center(
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 2,
            child: Container(
              width: 6, 
              height: scHeight*0.12,
              color: kLogoGreen,
            )
          ),
          //background container
          GestureDetector(
            
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 2),
              alignment: Alignment.center,
              width: scWidth*1.2,
              height: scHeight*0.12,
              // scHeight*0.12
              decoration: BoxDecoration(
                border: Border.all(color: kLogoGreen),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                // gradient: LinearGradient(
                //   colors: [
                //     CustomColors().primaryGreenColor.withGreen(150),
                //     CustomColors().lightGreen.withOpacity(0.8),
                //   ]
                // ),
              ),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Image.asset('assets/images/ic_fruit_green.png'),
              ),
            ),
            onTap: () {
              // navigate to order status page
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => OrderStatus())
              );
            },
          ),
          //details container
          GestureDetector(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //Order ID
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 17),
                        alignment: Alignment.center,
                        child: Text('Order ID', 
                        style: TextStyle(
                          color: kLogoGreen,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),),
                      ),
                      //Order Date
                        Container(
                          child: Text('17/11/2021', 
                          style: TextStyle(
                            color: kLogoGreen,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  //Order quantity
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: scWidth*0.145),
                    child: Text('2 items', 
                      style: TextStyle(
                        color: kDarkBlue,
                        fontWeight: FontWeight.w400,
                        fontSize: 19,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              // navigate to order status page
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => OrderStatus())
              );
            },
          ),
        ],
      ),
    ),
  );
}