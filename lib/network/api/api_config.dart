import 'dart:collection';

import 'package:alkhudhrah_app/network/models/auth/forget_password_response_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:alkhudhrah_app/constants/api_const.dart';
import 'package:alkhudhrah_app/network/models/register_response_model.dart';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'api_config.g.dart';
/*flutter pub run build_runner watch
*
* run when made any changes here
* */
@RestApi(baseUrl: ApiConst.basic_url)
abstract class RestClient {
  factory RestClient(Dio dio,{String? baseUrl}) = _RestClient;

  @POST(ApiConst.login_url)
  Future<dynamic> loginUser(@Body() Map<String, dynamic> hashMap);

  @GET(ApiConst.logout_url)
  Future<dynamic> logoutUser();

  @POST(ApiConst.forget_password_url)
  Future<ForgetPasswordResponseModel> forgetPassword(@Body() Map<String, dynamic> hashMap);

  @POST(ApiConst.reset_password_url)
  Future<dynamic> resetPassword(@Body() Map<String, dynamic> hashMap);

  @GET(ApiConst.get_contact_url)
  Future<dynamic> getContactInfo();

  @POST(ApiConst.check_password_token_url)
  Future<String> sendCodeForgetPassword(@Body() Map<String, dynamic> hashMap);

  //--------------- orders ----------------
  @GET(ApiConst.get_orders)
  Future<dynamic> getOrders(@Query('PageNumber') int pageNumber, @Query('PageSize') int  pageSize, @Query('ProductName') String  productName);

  @POST(ApiConst.order_delivered)
  Future<dynamic> orderDelivered(@Query('invoiceNumber') int invoiceNumber, @Query('hasPaid') bool hasPaid,);

  //--------------- Notifications ----------------
  @POST(ApiConst.send_notification)
  Future<dynamic> sendNotification(@Body() Map<String, dynamic> hashMap);

  @GET(ApiConst.get_user_notification)
  Future<dynamic> getUserNotification();

}
