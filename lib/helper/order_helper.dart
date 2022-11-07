import 'package:flutter/material.dart';
import 'package:alkhudhrah_app/constants/api_const.dart';
import 'package:alkhudhrah_app/helper/contact_helper.dart';
import 'package:alkhudhrah_app/helper/route_helper.dart';
import 'package:alkhudhrah_app/ui/companies/order_delivered.dart';

class OrderHelper {
  // static callApi(BuildContext context, UserCart userCart,
  //     BranchModel selectedBranch, bool hasPaid, String paymentMethod) async {
  //   //----------show progress----------------
  //   showLoaderDialog(context);
  //   //----------start api ----------------
  //   Map<String, dynamic> headerMap = await getHeaderMap();
  //   ApiResponse apiResponse;
  //   OrderRepository orderRepository = OrderRepository(headerMap);

  //   List<SubmitOrderItems> orderItemsList = [];
  //   for (CartProductsList cartItems in userCart.cartProductsList!) {
  //     orderItemsList.add(SubmitOrderItems(
  //         productId: cartItems.productModel?.productId!,
  //         userProductQuantity: cartItems.userProductQuantity,
  //         totalNetProductPrice: cartItems.totalNetProductPrice,
  //         totalProductPrice: cartItems.totalProductPrice,
  //         totalProductVAT15: cartItems.totalProductVAT15,
  //         orderedProductPrice: cartItems.productModel?.hasSpecialPrice == true
  //             ? cartItems.productModel?.specialPrice
  //             : cartItems.productModel?.originalPrice));
  //   }

  //   print(orderItemsList.toString());
  //   apiResponse = await orderRepository.submitOrder(
  //       paymentType: paymentMethod,
  //       hasPaid: hasPaid,
  //       branchId: selectedBranch.id,
  //       companyId: selectedBranch.companyId,
  //       totalOrderPrice: userCart.totalCartPrice,
  //       totalNetOrderPrice: userCart.totalNetCartPrice,
  //       totalOrderVAT15: userCart.totalCartVAT15,
  //       hasDiscount: userCart.hasDiscount,
  //       discountPercentage: userCart.discountPercentage,
  //       totalDiscount: 0,
  //       orderItem: orderItemsList);

  //   if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
  //     OrderDeliveredSuccessResponseModel model =
  //         OrderDeliveredSuccessResponseModel.fromJson(apiResponse.result);
  //     print(model.toString());
  //     Navigator.pop(context);
  //     OrderHelper. viewCompleteOrderPage(context , true ,model: model);

  //   } else {
  //     Navigator.pop(context);
  //     //return apiResponse.message;
  //     OrderHelper. viewCompleteOrderPage(context , false);

  //     throw ExceptionHelper(apiResponse.message);
  //   }



  // }

  static displayInvoice(url, isFromDashBoard) {
    if (isFromDashBoard == true)
      openURL(ApiConst.dashboard_url + url);
    else
      openURL(ApiConst.pdf_url +url);
  }


  static viewCompleteOrderPage(context , isSuccess,{model}){

    moveToNewStackWithArgs(context ,MaterialPageRoute(builder: (context) {
      return OrderDelivered(
        // isSuccess: isSuccess,
        model: model);
    } ));

  }


}
