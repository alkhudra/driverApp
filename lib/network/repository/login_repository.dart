import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:alkhudhrah_app/network/api/api_config.dart';
import 'package:alkhudhrah_app/network/api/api_response.dart';
import 'package:alkhudhrah_app/network/api/api_response_type.dart';
import 'package:alkhudhrah_app/network/models/auth/fail_reset_password_response_model.dart';
import 'package:alkhudhrah_app/network/models/error_response_model.dart';
import 'package:alkhudhrah_app/network/models/message_response_model.dart';
import 'package:dio/dio.dart';

class AuthRepository {
   late final RestClient _client;
   AuthRepository(Map<String,dynamic> headerMap) {
     _client = RestClient(Dio(
       BaseOptions(contentType: 'application/json',headers: headerMap),
     ));
   }




  //--------------------------

  Future<ApiResponse> loginUser(
      String email,
      String password,
      deviceId) async {
    if (email == null ||
        password == null || 
        deviceId == null) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }

      int isAndroiodDevice ;
    if(Platform.isAndroid)
    isAndroiodDevice =1;
     else isAndroiodDevice =2;

    Map<String, dynamic> hashMap = {
      "email": email,
      "password": password,
      "rememberMe": true,
      "isAndroiodDevice": true,
      "deviceId": deviceId,
      "deviceType" : isAndroiodDevice
    };

    return await _client
        .loginUser(hashMap)
        .then((value) => ApiResponse(ApiResponseType.OK, value, ''))
        .catchError((e) {
      int errorCode = 0;
      String errorMessage = "";
      switch (e.runtimeType) {
        case DioError:
          final res = (e as DioError).response;
          if (res != null) {
            errorCode = res.statusCode!;
            errorMessage = res.statusMessage!;

            if (errorCode == 400) {
              MessageResponseModel model =
              MessageResponseModel.fromJson(res.data);


              errorMessage =  model.message!;
            } else if (errorCode == 500) {
              errorMessage = res.data['Message'];
            }
          }
          break;
        default:
      }
      log("Got error : $errorCode -> $errorMessage");

      var apiResponseType = ApiResponse.convert(errorCode);
      return ApiResponse(apiResponseType, null, errorMessage);
    });
  }
 //--------------------------

  Future<ApiResponse> forgetPassword(String email) async {
    if (email == null) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }

    Map<String, dynamic> hashMap = {
      "email": email,
    };

    return await _client
        .forgetPassword(hashMap)
        .then((value) => ApiResponse(ApiResponseType.OK, value, ''))
        .catchError((e) {
      int errorCode = 0;
      String errorMessage = "";
      switch (e.runtimeType) {
        case DioError:
          final res = (e as DioError).response;
          if (res != null) {
            errorCode = res.statusCode!;
            errorMessage = res.statusMessage!;
            if(errorCode == 500)
              errorMessage = res.data['Message'];
            else  if(errorCode == 400) {
              // errorMessage = LocaleKeys.invalid_email.tr();
              ErrorResponseModel errorResponseModel = 
                  ErrorResponseModel.fromJson(res.data);
              errorMessage = errorResponseModel.error!.message!;
              print(errorMessage);
            }
          }
          break;
        default:
      }
      log("Got error : $errorCode -> $errorMessage");

      var apiResponseType = ApiResponse.convert(errorCode);
      return ApiResponse(apiResponseType, null, errorMessage);
    });
  }
  //-----------------

  Future<ApiResponse> resetPassword(String email, String password,
      String confirmPassword, String token) async {
    if (email == null) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }

    Map<String, dynamic> hashMap = {
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
      "token": token
    };

    return await _client
        .resetPassword(hashMap)
        .then((value) => ApiResponse(ApiResponseType.OK, value, ''))
        .catchError((e) {
      int errorCode = 0;
      String errorMessage = "";
      switch (e.runtimeType) {
        case DioError:
          final res = (e as DioError).response;
          if (res != null) {
            errorCode = res.statusCode!;
            errorMessage = res.statusMessage!;
            if (errorCode == 500) {
              errorMessage = res.data['Message'];
            }else if(errorCode ==400){
              print(res.data);
              String map = res.data.toString();
              if (map.contains('message')) {
                errorMessage = res.data['message'];
              } else {
                final de = jsonDecode(res.data.toString());
                FailResetPasswordResponseModel model = FailResetPasswordResponseModel.fromJson(de);
                if (model.errors!.confirmPassword!.isNotEmpty) {
                  errorMessage = model.errors!.confirmPassword!.first;
                }
               else if (model.errors!.email!.isNotEmpty) {
                  errorMessage = model.errors!.email!.first;
                }
              else  if (model.errors!.token!.isNotEmpty) {
                  errorMessage = model.errors!.token!.first;
                }
                else
                  errorMessage = model.errors!.password!.first;
              }
            }
          }
          break;
        default:
      }
      log("Got error : $errorCode -> $errorMessage");

      var apiResponseType = ApiResponse.convert(errorCode);
      return ApiResponse(apiResponseType, null, errorMessage);
    });
  }

}