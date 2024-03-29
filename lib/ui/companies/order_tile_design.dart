import 'package:alkhudhrah_app/network/API/api_response.dart';
import 'package:alkhudhrah_app/network/API/api_response_type.dart';
import 'package:alkhudhrah_app/network/helper/network_helper.dart';
import 'package:alkhudhrah_app/network/repository/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:alkhudhrah_app/constants/cont.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/helper/shared_pref_helper.dart';
import 'package:alkhudhrah_app/network/models/orders/order_header.dart';

import 'package:alkhudhrah_app/ui/companies/order_details.dart';
import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../network/models/orders/OrderHeaderIndividual.dart';
import '../individuals/order_details_individual.dart';

Widget orderTileDesign(context, userType,dynamic model, scWidth, scHeight) {
  String orderStatus = '';
  String orderDate = '';

  Color statusColor;
  if (model.orderStatus == underProcess) {
    orderDate = model.orderInitializedDate!;
    orderStatus = LocaleKeys.under_process.tr();
    statusColor = kLogoBrown;
  } else if (model.orderStatus == onDelivery) {
    orderDate = model.onDeliveryStatusDate!;
    orderStatus = LocaleKeys.on_delivery.tr();
    statusColor = kDarkBlue;
  } else {
    orderDate = model.deliveredStatusDate!;
    orderStatus = LocaleKeys.completed_order.tr();
    statusColor = kLogoGreen;
  }

  return ListTile(
    title: Center(
      child: GestureDetector(
        onTap: () {
          // navigate to order details page
          // print(model.orderStatus);
         userType == company? directToOrderDetails(context, model: model):directToIndividualOrderDetails(context, model: model);
        },
        child: Stack(
          children: [
            Positioned(
                left: 0,
                top: 2,
                child: Container(
                  width: 6,
                  height: scHeight * 0.12,
                  color: kLogoGreen,
                )),
            //background container
            Container(
              margin: EdgeInsets.symmetric(vertical: 2),
              alignment: Alignment.center,
              width: scWidth * 1.2,
              height: scHeight * 0.12,
              // scHeight*0.12
              decoration: BoxDecoration(
                border: Border.all(color: kLogoGreen),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                // gradient: LinearGradient(
                //   colors: [
                //     CustomColors().primaryGreenColor.withGreen(150),
                //     CustomColors().lightGreen.withOpacity(0.8),
                //   ]
                // ),
              ),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Image.asset('assets/images/ic_fruit_green.png'),
              ),
            ),
            //details container
            Container(
              alignment: Alignment.center,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //Order ID
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 17),
                        alignment: Alignment.center,
                        child: Text(
                          '#' + model.invoiceNumber.toString(),
                          style: TextStyle(
                            color: kLogoGreen,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      //Order Date
                      Container(
                        child: Text(
                          orderDate,
                          style: TextStyle(
                            color: kLogoGreen,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  //Order quantity
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: scWidth * 0.16),
                    child: Text(
                      orderStatus,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 19,
                      ),
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

void directToOrderDetails(context, {model, orderId}) async {
  String language = await PreferencesHelper.getSelectedLanguage;
  if (model == null) {
    Map<String, dynamic> headerMap = await getHeaderMap();

    OrderRepository orderRepository = OrderRepository(headerMap);

    ApiResponse apiResponse = await orderRepository.getOrderById(orderId);

    if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
      OrderHeader? responseModel = OrderHeader.fromJson(apiResponse.result);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) {

                return  OrderDetails(
                    orderModel: responseModel,
                    language: language,
                  );
              }));
    }
  } else
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OrderDetails(
                  orderModel: model,
                  language: language,
                )));
}

void directToIndividualOrderDetails(context,{model, orderId}) async {
  String language = await PreferencesHelper.getSelectedLanguage;
  if (model == null) {
    Map<String, dynamic> headerMap = await getHeaderMap();

    OrderRepository orderRepository = OrderRepository(headerMap);

    ApiResponse apiResponse = await orderRepository.getIndividualOrderById(orderId);

    if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
      OrderHeaderIndividual? responseModel = OrderHeaderIndividual.fromJson(apiResponse.result);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) {

                return  IndividualOrderDetails(
                  orderModel: responseModel,
                  language: language,
                );
              }));
    }
  } else
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => IndividualOrderDetails(
              orderModel: model,
              language: language,
            )));
}
