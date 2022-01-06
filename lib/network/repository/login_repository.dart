import 'dart:collection';
import 'dart:developer';

import 'package:alkhudhrah_app/network/api/api_config.dart';
import 'package:alkhudhrah_app/network/api/api_response.dart';
import 'package:alkhudhrah_app/network/api/api_response_type.dart';

import 'package:dio/dio.dart';

class LoginRepository {
  final RestClient _client;

  //todo: handle error
  LoginRepository([RestClient? client])
      : _client = client ?? RestClient(Dio());

  //--------------------------

  Future<ApiResponse> loginUser(
      String email,
      String password) async {
    if (email == null ||
        password == null ) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }

    Map<String, dynamic> hashMap = {
      "email": email,
      "password": password,
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
          }
          break;
        default:
      }
      log("Got error : $errorCode -> $errorMessage");

      var apiResponseType = ApiResponse.convert(errorCode);
      return ApiResponse(apiResponseType, null, errorMessage);
    });
  }

//-----------------------------



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
  Future<ApiResponse> sendPasswordToken(String email,String token) async {
    if (email == null) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }

    Map<String, dynamic> hashMap = {
      "email": email,
      "token": token
    };

    return await _client
        .sendCodeForgetPassword(hashMap)
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
      String confirmPassword,String token) async {
    if (email == null) {
      return ApiResponse(ApiResponseType.BadRequest, null, '');
    }

    Map<String, dynamic> hashMap = {
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
      "token":token
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