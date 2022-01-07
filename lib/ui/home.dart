import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/designs/drawer_design.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/ui/contact_us.dart';
import 'package:alkhudhrah_app/ui/edit_profile.dart';
import 'package:alkhudhrah_app/ui/language.dart';
import 'package:alkhudhrah_app/ui/order_details.dart';
import 'package:alkhudhrah_app/ui/wallet.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'my_orders.dart';
import 'notifications.dart';

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
        endDrawer: drawerDesign(context),
        appBar: AppBar(
          title: Text('Welcome Back, John Doe', style: TextStyle(
            color: kLogoBrown, 
            fontWeight: FontWeight.w600
          ),),
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: kLogoBrown,
          ),
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios), 
            color: kLogoBrown,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        backgroundColor: Colors.grey[100],
        bottomNavigationBar: GNav(
          backgroundColor: kWhite,
          rippleColor: kGray, // tab button ripple color when pressed
          hoverColor: kGray, // tab button hover color
          haptic: true, // haptic feedback
          tabBorderRadius: 20, 
          tabActiveBorder: Border.all(color: kLogoGreen, width: 1), // tab button border
          // tabBorder: Border.all(color: kLightGreen, width: 1), // tab button border
          // tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)], // tab button shadow
          curve: Curves.easeOutCubic, // tab animation curves
          duration: Duration(milliseconds: 500), // tab animation duration
          gap: 8, // the tab button gap between icon and text 
          color: kBlack.withOpacity(0.4), // unselected icon color
          activeColor: kWhite, // selected icon and text color
          iconSize: 28, // tab button icon size
          tabBackgroundColor: kLogoGreen, // selected tab background color
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // navigation bar padding
          tabMargin: EdgeInsets.symmetric(horizontal: 3, vertical: 8),
          tabs: [
            GButton(
              icon: Icons.add_shopping_cart_outlined,
              text: LocaleKeys.new_orders.tr(),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Homescreen(),
                ));
              },
            ),
            GButton(
              icon: Icons.price_change,
              text: LocaleKeys.wallet.tr(),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => WalletScreen(),
                ));
              },
            ),
            GButton(
              icon: Icons.checklist_outlined,
              text: LocaleKeys.my_orders.tr(),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => MyOrdersScreen(),
                ));
              },
            ),
            GButton(
              icon: Icons.notifications_none_outlined,
              text: LocaleKeys.notifications_tab.tr(),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                builder: (context) => NotificationsScreen(),
                ));
              },
            )
          ]
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                      getOrder(context, 'Carrots', 35, "12:43 PM", 'Restaurant A'),
                      SizedBox(height: 10,),
                      getOrder(context, 'Tomatoes', 10, "09:07 AM", 'Restaurant B'),
                      SizedBox(height: 10,),
                      getOrder(context, 'Leek', 53, "06:35 PM", 'Restaurant C'),
                      SizedBox(height: 10,),
                      getOrder(context, 'Oranges', 200, "08:29 PM", 'Restaurant D'),
                      // SizedBox(height: 10,),
                    ],
                  ),
                ),
        
              ],
            ),
          ),
        ),
      ),
    );
  }
}

getOrder(context, orName, orAmount, orTime, orBy) {
  return GestureDetector(
    child: Container(
      width: 400,
      height: 230,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.2, 3.0),
            blurRadius: 4.0,
            spreadRadius: -2.0
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Text(orName, style: TextStyle(
                  color: kLogoGreen,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),),
              ),
              SizedBox(width: 130,),
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
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text('Order By: $orBy', style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
            ),),
          ),
          SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Text('Amount: $orAmount', style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
            ),),
          ),
          SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text('Time made: $orTime', style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
            ),),
          ),
        ],
      ),
    ),
    onTap: () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => OrderDetails(),
        ),
      );
    },
  );
}