import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/models/orders.dart';
import 'package:alkhudhrah_app/ui/contact_us.dart';
import 'package:alkhudhrah_app/ui/edit_profile.dart';
import 'package:alkhudhrah_app/ui/language.dart';
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
                    builder: (context) => LanguageScreen()
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
          title: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Text('Welcome back,',
                  style: TextStyle(
                    color: kBlack.withOpacity(0.7), 
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
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