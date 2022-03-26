import 'dart:developer';

import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/network/api/api_config.dart';
import 'package:alkhudhrah_app/network/api/api_response.dart';
import 'package:alkhudhrah_app/network/api/api_response_type.dart';
import 'package:alkhudhrah_app/network/models/error_response_model.dart';
import 'package:alkhudhrah_app/helper/shared_pref_helper.dart';
import 'package:alkhudhrah_app/network/helper/network_helper.dart';
import 'package:dio/dio.dart';

import 'package:easy_localization/easy_localization.dart';

class ContactUsRepository {
  late final RestClient _client;

  ContactUsRepository(Map<String, dynamic> headerMap) {
    _client = RestClient(Dio(
      BaseOptions(contentType: 'application/json', headers: headerMap),
    ));
  }

//-----------------

    Future<ApiResponse> getContactInfo() async {

      return await _client
          .getContactInfo()
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
              } else
                errorMessage = LocaleKeys.wrong_error.tr();
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

