import 'package:alkhudhrah_app/ui/order_delivered.dart';
import 'package:flutter/cupertino.dart';
import 'package:alkhudhrah_app/ui/login_email.dart';
import 'package:alkhudhrah_app/ui/dashboard_page.dart';

import '../main.dart';

const String homeRoute = "home";
const String aboutRoute = "about";
const String settingsRoute = "settings";
const String loginRoute = "login";
const String languageRoute = "language";
const String noPage = "noPage";
const String mainRoute = "mainRoute";
const String contactUs = "contactUs";
const String dashBoardRoute = "dashBoard";
const String walletRoute = "wallet";
const String deliveredRoute = "orderDelivered";

final Map<String, WidgetBuilder> routMap = {
  loginRoute: (BuildContext context) => new LoginEmail(),
  dashBoardRoute: (BuildContext context) => new DashboardPage(),
  deliveredRoute: (BuildContext context) => new OrderDelivered(),
};
