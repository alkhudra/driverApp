import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/designs/appbar_design.dart';
import 'package:alkhudhrah_app/designs/drawer_design.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({ Key? key }) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {

static String name = '', email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return notifCard();
        },
        //replace count by array.length
        itemCount: 10,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(bottom: 25),
      ),
      appBar: bnbAppBar(context, LocaleKeys.notifications_tab.tr()),
      //TODO: replace with drawer(name & email)
      endDrawer: drawerDesign(context),
    );
  }

  Widget notifCard() {
    return ListTile(
      title: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 5),
            width: MediaQuery.of(context).size.width*0.9,
            height: MediaQuery.of(context).size.height*0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              border: Border.all(
                color: kLogoGreen,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  child: Container(
                    width: 5,
                    height: MediaQuery.of(context).size.height*0.1,
                    color: kLogoGreen,
                  ),
                ),
                Positioned(
                  left: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.2,
                    height: MediaQuery.of(context).size.height*0.14,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/ic_fruit_green.png')
                      )
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          //replace by order no
                          child: Text('Order Num', style: TextStyle(
                            color: kLogoGreen,
                            fontSize: 18, 
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                        Container(
                          //replace by actual date
                          child: Text('25/01/2022', style: TextStyle(
                            color: kLogoGreen,
                            fontSize: 18, 
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                      ],
                    ),
                    Container(
                      //replace text by notification
                      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.12),
                      child: Text(LocaleKeys.on_the_way.tr(),
                      style: TextStyle(
                        fontSize: 16,
                        color: kDarkBlue
                      ),),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}