import 'dart:ui';

import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/designs/order_details_design.dart';
import 'package:alkhudhrah_app/designs/textfield_design.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'contact_us.dart';
import 'edit_profile.dart';
import 'language.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({ Key? key }) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: true,
              // collapsedHeight: 200,
              title: Text(LocaleKeys.order_details.tr(), style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 22
              ),),
              flexibleSpace: Stack(
                children: [
                  Positioned.fill(
                    left: 180,
                    child: Image.asset('assets/images/grapevector.png'),
                  ),
                ],
              ),
              expandedHeight: 160,
              elevation: 0.0,
              backgroundColor: kLogoGreen,
              iconTheme: IconThemeData(color: kWhite),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios), 
                color: kWhite,
                onPressed: () => Navigator.pop(context),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                // margin: EdgeInsets.only(top: 100),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: kWhite,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        //Add order detail container
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                          alignment: Alignment.center,
                          width: 300,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              colors: [
                                kLogoGreen,
                                kLightGreen.withOpacity(0.7),
                              ]
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.only(left: 5, bottom: 10),
                            child: Image.asset('assets/images/green_grape.png'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                          alignment: Alignment.center,
                          width: 300,
                          height: 100,
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                    alignment: Alignment.center,
                                    child: Text('Order Num', 
                                    style: TextStyle(
                                      color: kWhite,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),),
                                  ),
                                  SizedBox(width: 70,),
                                    Container(
                                      child: Text('17/11/2021', 
                                      style: TextStyle(
                                        color: kWhite,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text('2 items', 
                                  style: TextStyle(
                                    color: kWhite,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 19,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //list of products

                        //subtotal, VAT, total

                        //PDF icon
  
                      ],
                    ),
                    SizedBox(height: 20,),
                    orderDetailsDesign(context),
                  ],
                ),
              ),
            ),
          ],
        ),
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
                        fontWeight: FontWeight.w700),)),
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
      ),
    );
  }
}