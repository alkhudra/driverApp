import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'companies/company_order_history.dart';
import 'individuals/individual_order_history.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
              child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: kLogoGreen,
                  // centerTitle: true,
                  title: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 7.5,
                            left: MediaQuery.of(context).size.width / 2.8),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/grapevector.png'),
                          ),
                        ),
                      ),
                      Container(
                        // margin: EdgeInsets.only(top: scHeight/7.5),
                        child: Center(
                          child: Text(
                            LocaleKeys.order_history.tr(),
                            style: TextStyle(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  pinned: true,
                  floating: true,

                  bottom: TabBar(
                    indicatorColor: kWhite,
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
                  child: CompanyOrderHistory(),
                ),
                Center(
                  child: IndividualOrderHistoryPage(),
                ),
              ],
            ),
          ))),
    );
  }
}
