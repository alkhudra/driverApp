import 'package:alkhudhrah_app/constants/api_const.dart';
import 'package:alkhudhrah_app/constants/cont.dart';
import 'package:alkhudhrah_app/designs/appbar_design.dart';
import 'package:alkhudhrah_app/designs/drawer_design.dart';
import 'package:alkhudhrah_app/designs/no_item_design.dart';
import 'package:alkhudhrah_app/designs/order_tile_design.dart';
import 'package:alkhudhrah_app/helper/custom_btn.dart';
import 'package:alkhudhrah_app/helper/shared_pref_helper.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/network/API/api_response.dart';
import 'package:alkhudhrah_app/network/API/api_response_type.dart';
import 'package:alkhudhrah_app/network/helper/exception_helper.dart';
import 'package:alkhudhrah_app/network/helper/network_helper.dart';
import 'package:alkhudhrah_app/network/models/driver_user.dart';
import 'package:alkhudhrah_app/network/models/orders/get_orders_response_model.dart';
import 'package:alkhudhrah_app/network/models/orders/order_header.dart';
import 'package:alkhudhrah_app/network/repository/order_repository.dart';
import 'package:alkhudhrah_app/ui/company_orders_page.dart';
import 'package:alkhudhrah_app/ui/order_history.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  static String name = '', email = '', image = '';
  @override
  void initState() {
    super.initState();
    setValues();
  }
  //------------------------
  void setValues() async {
    DriverUser user = await PreferencesHelper.getUser;
    //  image = user.image!;

    name = user.driverName != null ? user.driverName! : "";
    email = user.email != null ? user.email! : "";
    image = user.image != null ? user.image! : "";

    print('Driver Name:' + name);
    print('Driver Email:' + email);
    print('Driver Image:' + ApiConst.dashboard_url + image);
  }

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: appBarWithActions(context, LocaleKeys.orders.tr(), () {
              //display order history
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => OrderHistory()));
            }),
            endDrawer: drawerDesign(context, name, email, image),
            resizeToAvoidBottomInset: false,
           // backgroundColor: CustomColors.primaryWhiteColor,
            body: SafeArea(
                child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                       // backgroundColor: CustomColors.lightBlueColor,
                        // centerTitle: true,
                        // title: Text('Log IN',style: TextStyle(color: CustomColors.primaryWhiteColor,fontSize: 20)),
                        pinned: true,
                        floating: true,

                        bottom: TabBar(
                        // indicatorColor: CustomColors.primaryWhiteColor,
                          indicatorWeight: 2,
                          isScrollable: true,
                          tabs: [

                            Tab(
                                child: Text('Hospital',
                                    style: TextStyle(
                                        //color: CustomColors.primaryWhiteColor,
                                        fontSize: 20))),
                            Tab(
                                child: Text('Doctor',
                                    style: TextStyle(
                                      //  color: CustomColors.primaryWhiteColor,
                                        fontSize: 20))),
                          ],
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    children: <Widget>[

                      Center(
                        child: CompanyOrderPage(),
                      ),
                      Center(
                        child: CompanyOrderPage(),
                      ),
                    ],
                  ),
                ))),
      );





  }

}
