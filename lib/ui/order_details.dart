import 'dart:ui';

import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/designs/bottom_nav_bar.dart';
import 'package:alkhudhrah_app/designs/drawer_design.dart';
import 'package:alkhudhrah_app/designs/order_details_design.dart';
import 'package:alkhudhrah_app/designs/textfield_design.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/ui/home.dart';
import 'package:alkhudhrah_app/ui/my_orders.dart';
import 'package:alkhudhrah_app/ui/notifications.dart';
import 'package:alkhudhrah_app/ui/wallet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'contact_us.dart';
import 'edit_profile.dart';
import 'language.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({ Key? key }) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {

  double subTotal = 0.0;
  double vat = 0.0;
  double total = 0.0;


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
                          width: 400,
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
                            padding: EdgeInsets.only(left: 8, bottom: 8),
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
                      ],
                    ),
                    SizedBox(height: 20,),
                    orderDetailsDesign(context, LocaleKeys.fruits.tr().toUpperCase(), 'Banana', 21, 3),
                    orderDetailsDesign(context, LocaleKeys.vegetables.tr().toUpperCase(), 'Broccoli', 15, 1),
                    //space after orders
                    SizedBox(height: MediaQuery.of(context).size.height*0.07,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: kLogoGreen,
                                ),
                                children: <TextSpan> [
                                  TextSpan(text: LocaleKeys.subtotal.tr(),
                                  style: TextStyle(
                                    color: kBlack,
                                  )),
                                  TextSpan(text: ': 23.8 SAR',
                                  style: TextStyle(
                                    color: kLogoGreen,
                                  )),
                                  ]
                                ),
                              ),
                            ),
                          SizedBox(height: 10,),
                          Container(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: kLogoGreen,
                                ),
                                children: <TextSpan> [
                                  TextSpan(text: LocaleKeys.vat.tr(),
                                  style: TextStyle(
                                    color: kBlack,
                                  )),
                                  TextSpan(text: ': 4.05 SAR',
                                  style: TextStyle(
                                    color: kLogoGreen,
                                  )),
                                  ]
                                ),
                              ),
                            ),
                          SizedBox(height: 10,),
                          Divider(
                            thickness: 1,
                            color: kGray,
                          ),
                          Container(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: <TextSpan> [
                                  TextSpan(text: LocaleKeys.total.tr(),
                                  style: TextStyle(
                                    color: kLogoGreen,
                                  )),
                                  TextSpan(text: ': 27.85 SAR',
                                  style: TextStyle(
                                    color: kLogoGreen,
                                  )),
                                  ]
                                ),
                              ),
                            ),
                          SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavBar(),
        endDrawer: drawerDesign(context),
      ),
    );
  }
}