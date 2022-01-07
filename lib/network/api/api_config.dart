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

  @POST(ApiConst.forget_password_url)
  Future<ForgetPasswordResponseModel> forgetPassword(@Body() Map<String, dynamic> hashMap);

  @POST(ApiConst.reset_password_url)
  Future<dynamic> resetPassword(@Body() Map<String, dynamic> hashMap);
}
