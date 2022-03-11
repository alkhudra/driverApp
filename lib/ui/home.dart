import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/designs/appbar_design.dart';
import 'package:alkhudhrah_app/designs/bottom_nav_bar.dart';
import 'package:alkhudhrah_app/designs/drawer_design.dart';
import 'package:alkhudhrah_app/designs/order_tile_design.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/ui/order_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:easy_localization/easy_localization.dart';


class Homescreen extends StatefulWidget {
  const Homescreen({ Key? key }) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen>  with SingleTickerProviderStateMixin {
  // List<String> orders = <String>[];

  int currentPage = 0;

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    return Scaffold(
      appBar: bnbAppBar(context, LocaleKeys.home.tr()),
      endDrawer: drawerDesign(context),
      backgroundColor: kBackgroundColor,
      // bottomNavigationBar: BottomNavBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              height: 40,
              width: 320,
              decoration: BoxDecoration(
                // color: CustomColors().primaryWhiteColor,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: kLogoGreen),
              ),
              child: TabBar(
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: kLogoGreen,
                ),
                labelColor: kWhite,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Almarai',
                  fontSize: 16
                ),
                unselectedLabelColor: kDarkBlue,
                tabs: [
                  // first tab [you can add an icon using the icon property]
                  Tab(
                    text: LocaleKeys.current_orders.tr(),
                  ),

                  // second tab [you can add an icon using the icon property]
                  Tab(
                    text: LocaleKeys.completed_orders.tr(),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // first tab bar view widget 
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20,),
                  child: ListView.builder(
                      itemBuilder: ((context, index) {
                        return orderTileDesign(context, scWidth, scHeight);
                      }),
                      itemCount: 10,
                    ),
                ),


                // second tab bar view widget
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
                    itemBuilder: ((context, index) {
                      return orderTileDesign(context, scWidth, scHeight);
                    }),
                    itemCount: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
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