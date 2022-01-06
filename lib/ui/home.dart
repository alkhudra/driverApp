import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/models/orders.dart';
import 'package:alkhudhrah_app/ui/contact_us.dart';
import 'package:alkhudhrah_app/ui/edit_profile.dart';
import 'package:alkhudhrah_app/ui/language.dart';
import 'package:alkhudhrah_app/ui/order_details.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:easy_localization/easy_localization.dart';

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
        endDrawer: Drawer(
          child: ListView(
            children: [
              Container(
                width: 100,
                height: 300,
                decoration: BoxDecoration(
                  color: kLogoGreen,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 40),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/male_avatar.png'),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      //TODO: replace with company variable from DB
                      child: Text('Company Name', style: TextStyle(
                        color: kWhite,
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                      ),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      //TODO: replace with email variable from DB
                      child: Text('company@email.com', style: TextStyle(
                        color: kWhite,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),),
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => EditProfile())
                        );
                      },
                      child: Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Center(child: Text(LocaleKeys.edit_profile.tr(),
                        style: TextStyle(color: kLogoGreen,
                        fontWeight: FontWeight.w700))),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kLangBG
                      ),
                      child: Icon(Icons.language, color: kLang,),
                    ),
                    SizedBox(width: 10,),
                    Text(LocaleKeys.languages.tr(), style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context) => LanguageSetting()
                    ),
                  );
                },
              ),
              Divider(
                thickness: 2.5,
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kConBG
                      ),
                      child: Icon(Icons.verified_user_rounded, color: kCon,),
                    ),
                    SizedBox(width: 10,),
                    Text(LocaleKeys.contact_us.tr(), style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context) => ContactUs()
                    ),
                  );
                },
              ),
              Divider(
                thickness: 2.5,
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kLogOutBG
                      ),
                      child: Icon(Icons.logout, color: kLogOut,),
                    ),
                    SizedBox(width: 10,),
                    Text(LocaleKeys.log_out.tr(), style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context) => EditProfile()
                    ),
                  );
                },
              ),
            ],
          ),
        ),
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