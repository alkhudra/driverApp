import 'dart:developer';

import 'package:alkhudhrah_app/network/API/api_response.dart';
import 'package:alkhudhrah_app/network/API/api_response_type.dart';
import 'package:alkhudhrah_app/network/api/api_config.dart';
import 'package:alkhudhrah_app/network/models/message_response_model.dart';
import 'package:dio/dio.dart';

class NotifRepository {
    late final RestClient _client;

    NotifRepository(Map<String, dynamic> headerMap) {
      _client = RestClient(Dio(
      BaseOptions(contentType: 'application/json', headers: headerMap),
    ));
  }


  //------------Send Notifications--------------

  Future<ApiResponse> sendNotification(
      String deviceId,
      bool isAndroidDevice, 
      String  title,
      String  body) async {
    if (deviceId == null || title == null || body == null) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }

      Map<String, dynamic> hashMap = {
      "deviceId": deviceId,
      //temp true for ios in development stage
      "isAndroiodDevice": true,
      "title": title,
      "body": body
    };

    return await _client
        .sendNotification(hashMap)
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

    //------------Get User Notifications--------------

  Future<ApiResponse> getUserNotification() async {

    return await _client
        .getUserNotification()
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
}