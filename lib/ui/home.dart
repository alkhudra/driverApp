import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/models/orders.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({ Key? key }) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  // List<String> orders = <String>[];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: Icon(Icons.arrow_back_ios, color: kLogoBrown,),
          title: Row(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text('Welcome back,',
                    style: TextStyle(
                          color: kLogoBrown, 
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),),
                  ),
                  //TODO: replace name wuth username variable
                  Container(
                    child: Text('John Doe',
                    style: TextStyle(
                          color: kLogoGreen,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),),
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: Colors.grey[100],
        bottomNavigationBar: FancyBottomNavigation(
          inactiveIconColor: kLogoGreen,
          circleColor: kLogoGreen ,
          tabs: [
            TabData(iconData: Icons.add_shopping_cart_outlined, title: 'New Orders'),
            TabData(iconData: Icons.price_change, title: 'Wallet'),
            TabData(iconData: Icons.checklist_outlined, title: 'My Orders'),
            TabData(iconData: Icons.notifications_none_outlined, title: 'Notifications'),
          ], 
          onTabChangedListener: (int position) { 
            setState(() {
              currentPage = position;
            });
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // column for name and greeting
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Container(
              //       margin: EdgeInsets.only(top: 20, right: 230),
              //       child: Text('Welcome Back,', 
              //       style: TextStyle(
              //         color: kLogoBrown, 
              //         fontSize: 15,
              //         fontWeight: FontWeight.w500,
              //       ),),
              //     ),
              //     SizedBox(height: 5,),
              //     //TODO: replace username with variable
              //     Container(
              //       margin: EdgeInsets.only(left: 10),
              //       child: Text('John Doe', 
              //       style: TextStyle(
              //         color: kLogoGreen,
              //         fontSize: 25,
              //         fontWeight: FontWeight.w600,
              //       ),),
              //     ),
              //   ],
              // ),
              SizedBox(height: 50,),
              //column for incoming orders
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width/0.4,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    getOrder('Carrots', 35, TimeOfDay.now(), 'Jane Doe'),
                    SizedBox(height: 10,),
                    getOrder('Tomatoes', 10, TimeOfDay.now(), 'John Doe'),
                    // SizedBox(height: 10,),
                  ],
                ),
              ),
        
            ],
          ),
        ),
      ),
    );
  }
}

getOrder(orName, orAmount, orTime, orBy) {
  return Container(
    width: 400,
    height: 230,
    decoration: BoxDecoration(
      color: kWhite,
      borderRadius: BorderRadius.circular(40),

    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              child: Text(orName, style: TextStyle(
                color: kLogoGreen,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),),
            ),
            SizedBox(width: 120,),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.check_circle_outline_outlined,
              color: kLogoGreen,
              size: 30,),
            ),
            SizedBox(width: 5,),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.cancel_outlined,
              color: kLogoBrown,
              size: 30,),
            ),
          ],
        ),
        SizedBox(height: 20,),
        Container(
          padding: EdgeInsets.all(12.0),
          child: Text('Order By: $orBy', style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),),
        ),
        SizedBox(height: 5,),
        Container(
          padding: EdgeInsets.all(12.0),
          child: Text('Amount: $orAmount', style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),),
        ),
        SizedBox(height: 5,),
        Container(
          padding: EdgeInsets.all(12.0),
          child: Text('Time made: $orTime', style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),),
        ),
      ],
    ),
  );
}