import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/designs/buttons_design.dart';
import 'package:alkhudhrah_app/designs/textfield_design.dart';
import 'package:alkhudhrah_app/designs/card_design.dart';
import 'package:alkhudhrah_app/dialogs/message_dialog.dart';
import 'package:alkhudhrah_app/dialogs/progress_dialog.dart';
import 'package:alkhudhrah_app/network/api/api_response_type.dart';
import 'package:alkhudhrah_app/network/repository/login_repository.dart';
import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:alkhudhrah_app/router/route_constants.dart';

class ResetPasswordPage extends StatefulWidget {
  final Map<String ,String> dataMap;
  const ResetPasswordPage({Key? key , required this.dataMap}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {

  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  bool isBtnEnabled= true;
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text(LocaleKeys.reset_PW_title.tr()),
     ),
      //todo:
      /********
       *
       * design problems:
       * height of card  , width of main column ,place of btn
       * *********/
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 120, left: 30, right: 30),
            width: MediaQuery.of(context).size.width / 0.3,
            height: MediaQuery.of(context).size.height / 1.8,
            decoration: CardDesign.largeCardDesign(),
          ),
          SizedBox(
            height: 50,
          ),

          Container(
            margin: EdgeInsets.only(top: 250, left: 60),
            width: 300,
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFieldDesign.textFieldStyle(
                  context: context,
                  verMarg: 5,
                  horMarg: 0,
                  controller: passController,
                  kbType: TextInputType.emailAddress,
                  lbTxt: LocaleKeys.password_textfield.tr(),
                ),

                TextFieldDesign.textFieldStyle(
                  context: context,
                  verMarg: 5,
                  horMarg: 0,
                  controller: confirmPassController,
                  kbType: TextInputType.visiblePassword,
                  lbTxt: LocaleKeys.confirm_password.tr(),
                ),

                SizedBox(
                  height: 50,
                ),


                Container(
                    height: ButtonsDesign.buttonsHeight,
                    margin: EdgeInsets.only(left: 50, right: 50),
                    child: MaterialButton(
                      onPressed: () {

                        if(isBtnEnabled)
                          startReset();

                      },
                      shape: StadiumBorder(),
                      child: ButtonsDesign.buttonsText(LocaleKeys.reset_PW_btn.tr(),
                          kWhite),
                      color: kLogoGreen,
                    ))
              ],
            ),
          ),
        ],
      ),
    );;
  }

  void startReset
      () {

    if (passController.value.text == '') {
      showErrorDialog(LocaleKeys.pass_required.tr());
      return;
    }

    if (confirmPassController.value.text == '') {
      showErrorDialog(LocaleKeys.confirm_pass_required.tr());
      return;
    }


    if (passController.value.text != confirmPassController.value.text) {
      showErrorDialog(LocaleKeys.not_match_pass.tr());
      return;
    }

    isBtnEnabled = false;

    //---------


    //----------show progress----------------

    showLoaderDialog(context);
    //----------start api ----------------
    LoginRepository registerRepository = LoginRepository();
    String email = widget.dataMap.values.first;
    String token = widget.dataMap.values.last;

    registerRepository.resetPassword(email, passController.text,confirmPassController.text,token) .then((result) async {
      //-------- fail response ---------

      //todo: edit after adjustments
      if (result == null || result.apiStatus.code != ApiResponseType.OK.code) {
        /* if (result.apiStatus.code == ApiResponseType.BadRequest)*/
        Navigator.pop(context);
        showErrorDialog(result.message);
        return;
      }

      //-------- success response ---------
      Navigator.pop(context);

      String model = result.result;

      if(model != null)
      showSuccessDialog(context, model);


    });
  }


  void showErrorDialog(String txt) {
    isBtnEnabled = true;
    isBtnEnabled = true;
    showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            showMessageDialog(context, LocaleKeys.error.tr(), txt,noPage));
  }

  showSuccessDialog(BuildContext context,String message) {

    //todo:make user can not go back
    showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            showMessageDialog(context, LocaleKeys.process_success.tr(),message ,loginRoute));

  }

}