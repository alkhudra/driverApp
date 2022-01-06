import 'package:alkhudhrah_app/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:alkhudhrah_app/ui/language.dart';
import 'package:alkhudhrah_app/ui/login.dart';
import 'package:alkhudhrah_app/main.dart';
import 'package:alkhudhrah_app/router/route_constants.dart';


class CustomRouter {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => Login());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => Homescreen());
      case languageRoute:
        return MaterialPageRoute(builder: (_) => LanguageSetting());
      case welcomeRoute:
        return MaterialPageRoute(builder: (_) => MyHomepage());
      default:
        return MaterialPageRoute(builder: (_) => MyHomepage());
    }
  }
}