import 'package:alkhudhrah_app/ui/dashboard_page.dart';
import 'package:alkhudhrah_app/ui/home.dart';
import 'package:alkhudhrah_app/ui/language_page.dart';
import 'package:alkhudhrah_app/ui/login_email.dart';
import 'package:alkhudhrah_app/ui/companies/order_delivered.dart';
import 'package:flutter/material.dart';
import 'package:alkhudhrah_app/ui/language_setting.dart';
import 'package:alkhudhrah_app/main.dart';
import 'package:alkhudhrah_app/router/route_constants.dart';


class CustomRouter {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginEmail());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => Homescreen());
      case languageRoute:
        return MaterialPageRoute(builder: (_) => LanguagePage());
      default:
        return MaterialPageRoute(builder: (_) => DashboardPage());
    }
  }

  static Route<dynamic> dlGeneratedRoute(RouteSettings routeSettings) {
    switch(routeSettings.name) {
      //Add Product Details page
     /* case "/productPage":
      if (args is Map) {
        return MaterialPageRoute(
          builder: (_) {
            return ProductDetails(productModel: productModel, language: language)
          }
         );
      } */

      default: 
      return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          body: Center(
            child: Container(
              child: Text('Page Not Found!'),
            ),
          ),
        );
      }
    );
  }
}

