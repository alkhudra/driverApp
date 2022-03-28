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
const String detailsRoute = "orderDetails";
const String deliveredRoute = "orderDelivered";

final Map<String, WidgetBuilder> routMap = {
  mainRoute: (BuildContext context) => new MyApp(),
  loginRoute: (BuildContext context) => new LoginEmail(),
  dashBoardRoute: (BuildContext context) => new DashboardPage(),
};
