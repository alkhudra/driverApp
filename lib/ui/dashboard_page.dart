import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/ui/notifications.dart';
import 'package:alkhudhrah_app/ui/wallet.dart';
import 'package:alkhudhrah_app/ui/home.dart';
import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardPage extends StatefulWidget {
  //final bool isHasBranch;
  const DashboardPage({ Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  int currentTab = 1;
  // late bool branchStatus = widget.isHasBranch;

  late bool branchStatus;
  final PageStorageBucket bucket = PageStorageBucket();
  final List<Widget> screens = [
    //home is orders screen; both complete and incoming
    Homescreen(),
    WalletScreen(),
    NotificationsScreen()
  ];

    Widget currentScreen = Homescreen();

  @override
  void initState() {
    // TODO: implement initState
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
                minWidth: 10,
                onPressed: () {
                  setState(() {
                    //ishasbranch could be set to false later
                    currentScreen = WalletScreen();
                    currentTab = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.wallet,
                      color: currentTab == 0 
                      ? kLogoGreen 
                      : kGray,
                    ),
                    SizedBox(height: 5,),
                    Text(
                      LocaleKeys.wallet.tr(),
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
              //Home FAB Text
              Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 5),
                  alignment: Alignment.bottomCenter,
                  // color: Colors.red,
                  child: Text(LocaleKeys.home.tr(),
                    style: TextStyle(
                      color: currentTab == 1
                              ? kLogoGreen
                              : kGray,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.notifications_rounded,
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
            ],
          ),
        ),
      ),
    );
  }
}