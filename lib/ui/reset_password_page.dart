import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/custom_widgets/brandname.dart';
import 'package:alkhudhrah_app/designs/app_bar_text.dart';
import 'package:alkhudhrah_app/designs/appbar_design.dart';
import 'package:alkhudhrah_app/designs/buttons_design.dart';
import 'package:alkhudhrah_app/designs/card_design.dart';
import 'package:alkhudhrah_app/designs/textfield_design.dart';
import 'package:alkhudhrah_app/dialogs/alert_dialog.dart';
import 'package:alkhudhrah_app/dialogs/progress_dialog.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/network/api/api_response_type.dart';
import 'package:alkhudhrah_app/network/helper/network_helper.dart';
import 'package:alkhudhrah_app/network/models/message_response_model.dart';
import 'package:alkhudhrah_app/network/repository/login_repository.dart';
import 'package:alkhudhrah_app/router/route_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

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
    Size? size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    return Scaffold(
      appBar: appBarDesign(context, LocaleKeys.reset_PW_title.tr()),
      resizeToAvoidBottomInset: false,
      backgroundColor: kCard,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 120, left: 30, right: 30),
            width: MediaQuery.of(context).size.width / 0.3,
            height: MediaQuery.of(context).size.height / 2.1,
            decoration: CardDesign.largeCardDesign(),
          ),
          // SizedBox(
          //   height: 50,
          // ),
          brandNameMiddle(),
          Container(
            margin: EdgeInsets.only(
              top: scHeight * 0.13,
              right: scWidth * 0.1,
              left: scWidth * 0.1),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: scHeight * 0.19,
                ),
                TextFieldDesign.textFieldStyle(
                  context: context,
                  verMarg: 5,
                  horMarg: 0,
                  controller: passController,
                  kbType: TextInputType.visiblePassword,
                  obscTxt: false,
                  lbTxt: LocaleKeys.password_textfield.tr(),
                ),
                SizedBox(
                  height: 3,
                ),
                TextFieldDesign.textFieldStyle(
                  context: context,
                  verMarg: 5,
                  horMarg: 0,
                  controller: confirmPassController,
                  kbType: TextInputType.visiblePassword,
                  obscTxt: false,
                  lbTxt: LocaleKeys.confirm_password.tr(),
                ),

                SizedBox(
                  // height: 50,
                ),


                Container(
                  alignment: Alignment.bottomCenter,
                  height: ButtonsDesign.buttonsHeight,
                  margin: EdgeInsets.only(
                    left: 50, right: 50, top: scHeight / 9.5),
                  child: MaterialButton(
                    onPressed: () {

                      if(isBtnEnabled)
                        startReset();

                    },
                    shape: StadiumBorder(),
                    child: ButtonsDesign.buttonsText(LocaleKeys.reset_PW_btn.tr(),
                        kWhite, 15),
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
      () async {

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


    //----------show progress----------------

    showLoaderDialog(context);
    //----------start api ----------------
    Map<String, dynamic> headerMap = await getAuthHeaderMap();

    AuthRepository loginRepository = AuthRepository(headerMap);
    String email = widget.dataMap.values.first;
    String token = widget.dataMap.values.last;

    loginRepository.resetPassword(email, passController.text,confirmPassController.text,token) .then((result) async {
      //-------- fail response ---------

      if (result == null || result.apiStatus.code != ApiResponseType.OK.code) {
        Navigator.pop(context);
        showErrorDialog(result.message);
        return;
      }

      //-------- success response ---------
      Navigator.pop(context);

      MessageResponseModel model = MessageResponseModel.fromJson( result.result);


      if(model != null)
        showSuccessDialog(context, model.message!);


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
            showMessageDialog(context, LocaleKeys.pass_changed_done.tr(),message ,loginRoute));

  }

}