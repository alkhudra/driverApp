// import 'package:alkhudhrah_app/constants/colors.dart';
// import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
// import 'package:alkhudhrah_app/ui/home.dart';
// import 'package:alkhudhrah_app/ui/my_orders.dart';
// import 'package:alkhudhrah_app/ui/notifications.dart';
// import 'package:alkhudhrah_app/ui/wallet.dart';
// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:easy_localization/easy_localization.dart';


// //TODO: Change app bar
// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({ Key? key }) : super(key: key);

//   @override
//   _BottomNavBarState createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {

//   List pages = [
//     LocaleKeys.new_orders.tr(),
//     LocaleKeys.wallet.tr(),
//     LocaleKeys.my_orders.tr(),
//     LocaleKeys.notifications_tab.tr(),
//   ];
//   int index = 0;
  
//   @override
//   Widget build(BuildContext context) {
//     return GNav(
//       backgroundColor: kWhite,
//       rippleColor: kGray, // tab button ripple color when pressed
//       hoverColor: kGray, // tab button hover color
//       haptic: true, // haptic feedback
//       tabBorderRadius: 20, 
//       tabActiveBorder: Border.all(color: kLogoGreen, width: 1), // tab button border
//       // tabBorder: Border.all(color: kLightGreen, width: 1), // tab button border
//       // tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)], // tab button shadow
//       curve: Curves.easeOutCubic, // tab animation curves
//       duration: Duration(milliseconds: 500), // tab animation duration
//       gap: 8, // the tab button gap between icon and text 
//       color: kBlack.withOpacity(0.4), // unselected icon color
//       activeColor: kWhite, // selected icon and text color
//       iconSize: 28, // tab button icon size
//       tabBackgroundColor: kLogoGreen, // selected tab background color
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // navigation bar padding
//       onTabChange: (int pageIndex) {pageIndex = index;},
//       tabs: [
//         GButton(
//           icon: Icons.add_shopping_cart_outlined,
//           text: LocaleKeys.new_orders.tr(),
//           onPressed: () {
//             Navigator.push(context, MaterialPageRoute(
//               builder: (context) => Homescreen(),
//             ));
//           },
//         ),
//         GButton(
//           icon: Icons.price_change,
//           text: LocaleKeys.wallet.tr(),
//           onPressed: () {
//             Navigator.push(context, MaterialPageRoute(
//               builder: (context) => WalletScreen(),
//             ));
//           },
//         ),
//         GButton(
//           icon: Icons.checklist_outlined,
//           text: LocaleKeys.my_orders.tr(),
//           onPressed: () {
//             Navigator.push(context, MaterialPageRoute(
//               builder: (context) => MyOrdersScreen(),
//             ));
//           },
//         ),
//         GButton(
//           icon: Icons.notifications_none_outlined,
//           text: LocaleKeys.notifications_tab.tr(),
//           onPressed: () {
//             Navigator.push(context, MaterialPageRoute(
//             builder: (context) => NotificationsScreen(),
//             ));
//           },
//         )
//       ]
//     );
//   }
// }
