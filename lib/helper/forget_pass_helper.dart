import 'package:alkhudhrah_app/dialogs/progress_dialog.dart';
import 'package:alkhudhrah_app/dialogs/message_dialog.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/network/api/api_response_type.dart';
import 'package:alkhudhrah_app/network/models/auth/forget_password_response_model.dart';
import 'package:alkhudhrah_app/network/helper/network_helper.dart';
import 'package:alkhudhrah_app/ui/enter_code_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:alkhudhrah_app/network/repository/login_repository.dart';
import 'package:alkhudhrah_app/ui/enter_code_page.dart';
import 'package:easy_localization/easy_localization.dart';

void forgetPasswordProcess(
    BuildContext context, String userEmail, bool isForgetPassBtnEnabled) async{
  if (userEmail != '') {
    isForgetPassBtnEnabled = false;

    print(userEmail);
    //----------show progress----------------

    showLoaderDialog(context);
    //----------start api ----------------
    Map<String, dynamic> headerMap = await getAuthHeaderMap();

    AuthRepository registerRepository = AuthRepository(headerMap);
    registerRepository.forgetPassword(userEmail).then((result) async {
      //-------- fail response ---------

      if (result == null || result.apiStatus.code != ApiResponseType.OK.code) {
        Navigator.pop(context);
        isForgetPassBtnEnabled = true;
        showErrorMessageDialog(context, result.message);
        return;
      }

      //-------- success response ---------

      ForgetPasswordResponseModel model = result.result;
      if (model.code == '') {
        Navigator.pop(context);
        isForgetPassBtnEnabled = true;

        showErrorMessageDialog(context, LocaleKeys.wrong_email.tr());
        return;
      }
      Navigator.pop(context);
      Navigator.pop(context);

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        isForgetPassBtnEnabled = true;
        return EnterCodePage(
          userEmail: userEmail,
          code: model.code!,
        );
      }));
    });
  }
}
