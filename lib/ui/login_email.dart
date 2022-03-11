import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/custom_widgets/brandname.dart';
import 'package:alkhudhrah_app/custom_widgets/green_btn.dart';
import 'package:alkhudhrah_app/designs/buttons_design.dart';
import 'package:alkhudhrah_app/designs/card_design.dart';
import 'package:alkhudhrah_app/designs/textfield_design.dart';
import 'package:alkhudhrah_app/dialogs/alert_dialog.dart';
import 'package:alkhudhrah_app/dialogs/password_dialog.dart';
import 'package:alkhudhrah_app/dialogs/progress_dialog.dart';
import 'package:alkhudhrah_app/helper/info_corrector_helper.dart';
import 'package:alkhudhrah_app/helper/route_helper.dart';
import 'package:alkhudhrah_app/helper/shared_pref_helper.dart';
import 'package:alkhudhrah_app/helper/snack_message.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/main.dart';
import 'package:alkhudhrah_app/network/api/api_response_type.dart';
import 'package:alkhudhrah_app/network/helper/network_helper.dart';
import 'package:alkhudhrah_app/network/models/auth/forget_password_response_model.dart';
import 'package:alkhudhrah_app/network/models/auth/success_login_response_model.dart';
import 'package:alkhudhrah_app/network/models/user_model.dart';
import 'package:alkhudhrah_app/network/models/register_response_model.dart';
import 'package:alkhudhrah_app/network/repository/login_repository.dart';
import 'package:alkhudhrah_app/router/route_constants.dart';
import 'package:alkhudhrah_app/ui/forgotpassword.dart';
import 'package:alkhudhrah_app/ui/home.dart';
import 'package:alkhudhrah_app/ui/login.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:alkhudhrah_app/constants/colors.dart';

import 'enter_code_page.dart';

class LoginEmail extends StatefulWidget {
  const LoginEmail({ Key? key }) : super(key: key);

  @override
  _LoginEmailState createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool isBtnEnabled = true;
  bool isForgetPassBtnEnabled = true;
  static bool isHasBranches = false;

  @override
  Widget build(BuildContext context) {
    Size? size = MediaQuery
        .of(context)
        .size;
    double scWidth = size.width;
    double scHeight = size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kCard,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 120, left: 30, right: 30),
            width: MediaQuery
                .of(context)
                .size
                .width / 0.3,
            height: MediaQuery
                .of(context)
                .size
                .height / 1.8,
            decoration: CardDesign.largeCardDesign(),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          brandNameMiddle(),
          // SizedBox(
          //   height: 10,
          // ),
          Container(
            margin: EdgeInsets.only(
                top: scHeight * 0.13,
                right: scWidth * 0.1,
                left: scWidth * 0.1),
            // padding: EdgeInsets.symmetric(horizontal: scWidth/9, vertical: scHeight/5),
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFieldDesign.textFieldStyle(
                  context: context,
                  verMarg: 5,
                  horMarg: 0,
                  controller: emailController,
                  kbType: TextInputType.emailAddress,
                  obscTxt: false,
                  lbTxt: LocaleKeys.email_textfield.tr(),
                ),
                SizedBox(
                  height: 3,
                ),
                TextFieldDesign.textFieldStyle(
                    context: context,
                    verMarg: 5,
                    horMarg: 0,
                    controller: passController,
                    kbType: TextInputType.visiblePassword,
                    obscTxt: true,
                    lbTxt:  LocaleKeys.password_textfield.tr(),
                ),
                SizedBox(
                  height: scHeight / 20,
                ),
                Container(
                    height: scHeight / 30,
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: GestureDetector(
                      onTap: () {
                        if (isForgetPassBtnEnabled)
                          showDialog(
                              builder: (BuildContext context) =>
                                  showEnterEmailDialog(context, isForgetPassBtnEnabled),
                              context: context);
                      },
                      child: Text(LocaleKeys.forgot_PW_Btn.tr(),
                          style: TextStyle(
                              color: kLogoGreen)),
                    )),

                SizedBox(
                  height: scHeight * 0.05,
                ),
                greenBtn(LocaleKeys.SIGN_IN.tr(),
                    EdgeInsets.only(left: 50, right: 50, top: 30), () {
                      if (isBtnEnabled) logIn();
                    })

                ,
              ],
            ),
          ),
        ],
      ),
    );
  }

  //-------------------------
  void showErrorDialog(String txt) {
    isForgetPassBtnEnabled = true;
    isBtnEnabled = true;
    showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            showMessageDialog(context, LocaleKeys.error.tr(), txt, noPage));
  }

  ////---------------------------

  void logIn() async {
    if (emailController.value.text == '') {
      showErrorDialog(LocaleKeys.email_required.tr());
      return;
    }

    if (isValidEmail(emailController.value.text) == false) {
      showErrorDialog(LocaleKeys.invalid_email.tr());
      return;
    }

    if (passController.value.text == '') {
      showErrorDialog(LocaleKeys.pass_required.tr());
      return;
    }

    isBtnEnabled = false;

    print('continue log in ');

    //----------show progress----------------

    showLoaderDialog(context);
    //----------start api ----------------
    Map<String, dynamic> headerMap = await getAuthHeaderMap();
    
    AuthRepository loginRepository = AuthRepository(headerMap);
    loginRepository
        .loginUser(emailController.text, passController.text, true)
        .then((result) async {
      //-------- fail response ---------

      if (result.apiStatus.code != ApiResponseType.OK.code) {
        Navigator.pop(context);
        showErrorDialog(result.message);
        return;
      }

      print(result.result);
      //-------- success response ---------
      SuccessLoginResponseModel model = SuccessLoginResponseModel.fromJson(
          result.result);

      print(model.user.toString());


      User user = model.user!;


      PreferencesHelper.setUserID(user.id!);
      PreferencesHelper.getUserID.then((value) => print('user id : $value'));

      PreferencesHelper.setUserToken(model.token);
      PreferencesHelper.getUserToken.then((value) => print('token : $value'));

      PreferencesHelper.setUser(user);
      PreferencesHelper.setUserLoggedIn(true);
      PreferencesHelper.setUserFirstLogIn(false);

      Navigator.pop(context);

      directToHomePage(model.user!.driverName!);
    });
  }


////---------------------------

  void directToHomePage(String name) {

    moveToNewStack(context , dashBoardRoute);

    SchedulerBinding.instance?.addPostFrameCallback((_) {
      Flushbar(
        message:
        LocaleKeys.welcome_back.tr()+" $name",
        flushbarPosition: FlushbarPosition.BOTTOM,
        duration: Duration(seconds: 3),
        backgroundColor: kLogoGreen.withOpacity(0.8),
      )..show(context);
    });

  }

////---------------------------


}