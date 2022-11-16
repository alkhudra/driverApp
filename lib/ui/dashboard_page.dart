import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/ui/notifications.dart';
import 'package:alkhudhrah_app/ui/setting_page.dart';
import 'package:alkhudhrah_app/ui/home.dart';
import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({ Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  int currentTab = 1;

  late bool branchStatus;
  final PageStorageBucket bucket = PageStorageBucket();
  final List<Widget> screens = [
    //home is orders screen; both complete and incoming
    Homescreen(),
    SettingsScreen(),
    NotificationsScreen()
  ];

    Widget currentScreen = Homescreen();

  @override
  void initState() {
   // branchStatus = widget.isHasBranch;
    super.initState();
    print('welcome in dashboard ');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'HomeFAB',
        child: ImageIcon(
          AssetImage('assets/images/logo.png'),
          size: 35,
        ),
        onPressed: () {
          setState(() {
            //orders screen
            currentScreen = Homescreen();
            currentTab = 1;
          });
        },
        elevation: 0.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minWidth: 20,
                onPressed: () {
                  setState(() {
                    //ishasbranch could be set to false later
                    currentScreen = SettingsScreen();
                    currentTab = 0;
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width*0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.menu,
                        color: currentTab == 0 
                        ? kLogoGreen 
                        : kGray,
                      ),
                      SizedBox(height: 5,),
                      Text(
                        LocaleKeys.my_setting.tr(),
                        style: TextStyle(
                          fontSize: 13,
                          color: currentTab == 0 
                          ? kLogoGreen
                          : kGray,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //Home FAB Text
              Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 3),
                  alignment: Alignment.bottomCenter,
                  child: Text(LocaleKeys.orders.tr(),
                    style: TextStyle(
                      color: currentTab == 1
                              ? kLogoGreen
                              : kGray,
                      fontWeight: currentTab == 1
                              ? FontWeight.w600
                              : FontWeight.bold,
                    ),
                  ),
                ),
              ),
              //Notifications tab
              MaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minWidth: 20,
                onPressed: () {
                  setState(() {
                    currentScreen = NotificationsScreen();
                    currentTab = 2;
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width*0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.solidBell,
                        color: currentTab == 2 
                        ? kLogoGreen
                        : kGray,
                      ),
                      SizedBox(height: 5,),
                      Text(
                        LocaleKeys.notifications_tab.tr(),
                        style: TextStyle(
                          fontSize: 13,
                          color: currentTab == 2 
                          ? kLogoGreen
                          : kGray,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}