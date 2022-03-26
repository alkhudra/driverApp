import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/helper/contact_helper.dart';
import 'package:alkhudhrah_app/helper/custom_btn.dart';
import 'package:alkhudhrah_app/helper/order_helper.dart';
import 'package:alkhudhrah_app/helper/shared_pref_helper.dart';
import 'package:alkhudhrah_app/helper/route_helper.dart';
import 'package:alkhudhrah_app/network/models/orders/order_header.dart';
import 'package:alkhudhrah_app/network/models/orders/delivered_order_success_response_model.dart';
import 'package:alkhudhrah_app/ui/dashboard_page.dart';
import 'package:alkhudhrah_app/ui/order_details.dart';
import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/router/route_constants.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_localization/easy_localization.dart';

class OrderDelivered extends StatefulWidget {
  final bool? isSuccess;
  final OrderDeliveredSuccessResponseModel? model;

  const OrderDelivered({Key? key, this.isSuccess, this.model})
      : super(key: key);

  @override
  _OrderDeliveredState createState() => _OrderDeliveredState();
}

class _OrderDeliveredState extends State<OrderDelivered> {
  @override
  Widget build(BuildContext context) {
    String txt = widget.isSuccess!
        ? LocaleKeys.order_complete_successfully.tr()
        : LocaleKeys.order_complete_fail.tr();
    String lottieUrl = widget.isSuccess!
        ? 'images/order_complete.json'
        : 'images/order_fail.json';


    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Lottie.asset(
                    lottieUrl,
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    txt,
                    style: TextStyle(
                      color: kLogoGreen,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (widget.isSuccess == true && widget.model != null)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          LocaleKeys.order_no.tr() +
                              '#' +
                              (widget.model!.orderHeader!.invoiceNumber!)
                                  .toString(),
                          style: TextStyle(
                            color: kLogoGreen,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      greenBtn(LocaleKeys.display_invoice.tr(),
                          EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                          () {
                        print(widget.model!.orderHeader!
                            .hasOrderCreatedFromDashboard!);
                        OrderHelper.displayInvoice(
                            widget.model!.invoicePDFPath,
                            widget.model!.orderHeader!
                                .hasOrderCreatedFromDashboard!);
                      }),
                    ],
                  ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    moveToNewStack(context, dashBoardRoute);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(LocaleKeys.main_page.tr(),
                        style: TextStyle(
                            fontSize: 15,
                            color: kLogoGreen)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
