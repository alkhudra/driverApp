import 'dart:developer';

import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/network/API/api_response.dart';
import 'package:alkhudhrah_app/network/API/api_response_type.dart';
import 'package:alkhudhrah_app/network/api/api_config.dart';
import 'package:alkhudhrah_app/network/models/message_response_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:dio/dio.dart';

class OrderRepository{

late final RestClient _client;

  OrderRepository(Map<String,dynamic> headerMap) {
    _client = RestClient(Dio(
      BaseOptions(contentType: 'application/json', headers: headerMap),
    ));
  }

    //------------Get Orders--------------

  Future<ApiResponse> getOrders(
      int pageNumber,
      int  pageSize, 
      String  productName) async {
    if (pageSize == null || pageNumber == null ) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }

    return await _client
        .getOrders(pageNumber, pageSize, productName)
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

    //------------Delivered Orders--------------

  Future<ApiResponse> orderDelivered(
    int invoiceNumber,
    bool hasPaid
  ) async {
    if (invoiceNumber == null ||
        hasPaid == null ) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }

    return await _client
        .orderDelivered(invoiceNumber, hasPaid)
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


    //------------Get Order By ID--------------


    Future<ApiResponse> getOrderById(
      int orderId,

      ) async {
    if (orderId == null ) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }

    return await _client
        .getOrderById(orderId)
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
            } else {
              errorMessage = LocaleKeys.wrong_error.tr();
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
  //-----------------------------------

  

}