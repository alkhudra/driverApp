import 'package:alkhudhrah_app/designs/appbar_design.dart';
import 'package:alkhudhrah_app/designs/textfield_design.dart';
import 'package:alkhudhrah_app/dialogs/message_dialog.dart';
import 'package:alkhudhrah_app/dialogs/progress_dialog.dart';
import 'package:alkhudhrah_app/helper/custom_btn.dart';
import 'package:alkhudhrah_app/helper/order_helper.dart';
import 'package:alkhudhrah_app/helper/snack_message.dart';
import 'package:alkhudhrah_app/network/API/api_response.dart';
import 'package:alkhudhrah_app/network/API/api_response_type.dart';
import 'package:alkhudhrah_app/network/helper/exception_helper.dart';
import 'package:alkhudhrah_app/network/helper/network_helper.dart';
import 'package:alkhudhrah_app/network/models/orders/get_orders_response_model.dart';
import 'package:alkhudhrah_app/network/repository/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/helper/route_helper.dart';
import 'package:alkhudhrah_app/network/models/orders/order_header.dart';
import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/router/route_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:ui' as ui;

class OrderDelivered extends StatefulWidget {
  final OrderHeader? model;

  const OrderDelivered({Key? key, 

    this.model
  })
    : super(key: key);

  @override
  _OrderDeliveredState createState() => _OrderDeliveredState();
}

class _OrderDeliveredState extends State<OrderDelivered> {

  bool hasPaid = false;

  @override
  Widget build(BuildContext context) {

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return kDarkBlue;
      }
      return kLogoGreen;
    }

    OrderHeader? orderModel = widget.model;

    String? checkCode = orderModel!.orderCheckCode;

    String frstNum = checkCode!.substring(0,1);
    String scndNum = checkCode.substring(1,2);
    String thrdNum = checkCode.substring(2,3);
    String frthNum = checkCode.substring(3,4);

    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: appBarDesign(context, LocaleKeys.delivery_confirmation.tr()),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        LocaleKeys.delivery_code.tr() + ' :',
                        style: TextStyle(
                            color: kLogoBrown,
                            fontWeight: FontWeight.w800,
                            fontSize: 17),
                      ),
                    ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Container(
                //       margin: EdgeInsets.symmetric(horizontal: 20),
                //       width: 130,
                //       child: Divider(
                //         thickness: 1.5,
                //         color: kGray,
                //         height: 20,
                //         // indent: 90,
                //         // endIndent: 90,
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 32),
                      width: scWidth,
                      child: Text(LocaleKeys.delivery_desc.tr(),
                      style: TextStyle(
                        color: kDarkGray,
                        fontSize: 15
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: scHeight * 0.2,),
                Directionality(
                  //To always display numbers from left to right
                  textDirection: ui.TextDirection.ltr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      deliveryCheckedCode(frstNum),
                      deliveryCheckedCode(scndNum),
                      deliveryCheckedCode(thrdNum),
                      deliveryCheckedCode(frthNum),
                    ],
                  ),
                ),
                SizedBox(height: scHeight * 0.06,), 
                Container(
                  // margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Checkbox(
                              checkColor: Colors.white,
                              fillColor: MaterialStateProperty.resolveWith(getColor),
                              value: hasPaid,
                              onChanged: (bool? value) {
                                setState(() {
                                  hasPaid = value!;
                                });
                              },
                            ),
                          ),
                          Container(
                            child: Text(LocaleKeys.cash_desc.tr(), style: TextStyle(
                              color: kDarkGray,
                              fontSize: 16
                            ),),
                          ),
                        ],
                      ),
                      Container(
                        child: Tooltip(
                          message: LocaleKeys.cash_info.tr(),
                          textStyle: TextStyle(
                            color: kWhite,
                            fontSize: 14
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: kDarkBlue.withOpacity(0.5),
                          ),
                          padding: EdgeInsets.all(8),
                          showDuration: Duration(seconds: 10),
                          child: Icon(Icons.info_outline_rounded,
                          color: kDarkGray.withOpacity(0.6),),
                          triggerMode: TooltipTriggerMode.tap,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: scHeight * 0.18,
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: greenBtn(LocaleKeys.confirm_Delivery.tr(), EdgeInsets.symmetric(horizontal: 60), () async {
                    //invoke orderDelivered and movestack to home
                    hasPaid = hasPaid;
                    print(orderModel.invoiceNumber!);

                    //----------show progress----------------

                    showLoaderDialog(context);

                    //----------start api ----------------
                    
                    Map<String, dynamic> headerMap = await getHeaderMap();

                    OrderRepository orderRepository = OrderRepository(headerMap);

                    ApiResponse apiResponse =
                        await orderRepository.orderDelivered(orderModel.invoiceNumber!, hasPaid);

                    if(apiResponse.apiStatus.code != ApiResponseType.OK.code) {
                      Navigator.pop(context);
                      showErrorMessageDialog(context, apiResponse.message);
                      return;
                    }

                    showDialog<String>(
                      context: context, 
                      builder: (BuildContext context) => showMessageDialog(context, LocaleKeys.completed_order.tr(), LocaleKeys.completed_thanks.tr(), dashBoardRoute)
                    );

                   // showSuccessMessage(context,  LocaleKeys.completed_order.tr());

                    
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
