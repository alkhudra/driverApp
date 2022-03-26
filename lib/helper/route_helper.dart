import 'package:flutter/cupertino.dart';
import 'package:alkhudhrah_app/router/route_constants.dart';
import 'package:flutter/material.dart';

void moveToNewStack(BuildContext context , String routeString){
  Navigator.of(context).pushNamedAndRemoveUntil(routeString, (Route<dynamic> route) => false);

}
void moveToNewStackWithArgs(context, MaterialPageRoute materialPageRoute) {
  Navigator.pushAndRemoveUntil(context,  materialPageRoute, (route) => false);

}
