import 'package:alkhudhrah_app/designs/appbar_design.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({ Key? key }) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDesign(context, LocaleKeys.order_history.tr()),
      
    );
  }
}