
import 'dart:async';

import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/designs/app_bar_text.dart';
import 'package:alkhudhrah_app/designs/buttons_design.dart';
import 'package:alkhudhrah_app/designs/textfield_design.dart';
import 'package:alkhudhrah_app/dialogs/alert_dialog.dart';
import 'package:alkhudhrah_app/dialogs/progress_dialog.dart';
import 'package:alkhudhrah_app/helper/shared_pref_helper.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/network/api/api_response_type.dart';
import 'package:alkhudhrah_app/network/models/auth/forget_password_response_model.dart';
import 'package:alkhudhrah_app/network/repository/login_repository.dart';
import 'package:alkhudhrah_app/router/route_constants.dart';
import 'package:alkhudhrah_app/ui/reset_password_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
class EnterCodePage extends StatefulWidget {
  final String userEmail;
  final String code;

  const EnterCodePage({Key? key, required this.userEmail, required this.code})
      : super(key: key);

  @override
  _EnterCodePageState createState() => _EnterCodePageState();
}

class _EnterCodePageState extends State<EnterCodePage> {
  int numberOfSecToWait = 120;
  final TextEditingController controller = TextEditingController();
  late StreamController<int> _events;

  bool isBtnEnabled = true;
  bool isResendEnabled = true;

  static String correctCode = '';
  String language = 'ar';
  @override
  void initState() {
    super.initState();
    _events = new StreamController<int>();
    PreferencesHelper.getSelectedLanguage.then((value) => language = value);

    numberOfSecToWait = 120;
    _events.add(numberOfSecToWait);
    correctCode = widget.code;
    startTimer(numberOfSecToWait, _events);
  }

  @override
  Widget build(BuildContext context) {
    String email = widget.userEmail;
    return Scaffold(
      appBar:  appBarText(LocaleKeys.enter_code.tr(), true),
      body:StreamBuilder<int>(
        stream: _events.stream,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          return Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    LocaleKeys.enter_code_note.tr() + '\n' + email,
                    style: TextStyle(

                      fontSize: 15,
                      color: kLogoGreen,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: TextFieldDesign.textFieldStyle(
                    context: context,
                    verMarg: 5,
                    horMarg: 0,
                    controller: controller,
                    kbType: TextInputType.text,
                    obscTxt: false,
                    lbTxt: LocaleKeys.enter_code.tr(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: ButtonsDesign.buttonsHeight,
                    margin: EdgeInsets.only(left: 50, right: 50, bottom: 20),
                    child: MaterialButton(
                      onPressed: () {
                        if (isBtnEnabled) sendCodeToDB(email);
                      },
                      shape: StadiumBorder(),
                      child: ButtonsDesign.buttonsText(
                          LocaleKeys.continue_btn.tr(),
                          kWhite, 15),
                      color: kLogoGreen,
                    )),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 30,
                  padding: EdgeInsets.only(right: 10, left: 10),
                  child: Text(
                    LocaleKeys.resend_code_note.tr() + '\n',
                    style: TextStyle(
                        color: kLogoGreen,
                        fontSize: 15.0),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 30,
                  padding: EdgeInsets.only(right: 10, left: 10),
                  child: GestureDetector(
                    onTap: () {
                      //you can tap if only finish timer
                      if (snapshot.data.toString() == '0') {
                        setState(() {
                          isBtnEnabled = true;
                          controller.text = '';
                          _events.add(numberOfSecToWait);
                          startTimer(numberOfSecToWait, _events);
                          resendCode(email);
                          print(snapshot.data.toString());
                        });
                      }
                    },
                    child: Text(
                      (snapshot.data.toString() != '0')
                          ? snapshot.data.toString()
                          : LocaleKeys.resend_code.tr(),
                      style: TextStyle(
                          color: kLogoGreen,
                          fontSize: 15.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void startTimer(int _counter, StreamController<int> _events) {
    Timer.periodic(Duration(seconds: 1), (timer) {
      //setState(() {
      (_counter > 0) ? _counter-- : timer.cancel();
      //});
      print(_counter);
      _events.add(_counter);
    });
  }

  //-------------------

  void sendCodeToDB(String userEmail) {
    if (controller.text == '') {
      showErrorDialog(LocaleKeys.enter_code_note.tr());
      return;
    }
    if (controller.text != correctCode) {
      showErrorDialog(LocaleKeys.code_not_match.tr());
      return;
    }
    isBtnEnabled = false;

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      Map<String, String> dataMap = {"email": userEmail, "token": widget.code};
      return ResetPasswordPage(dataMap: dataMap);
    }));
  }

  //-------------------
  void resendCode(String userEmail) {
    isResendEnabled = false;
    showLoaderDialog(context);


    //----------start api ----------------
    LoginRepository loginRepository = LoginRepository();
    loginRepository.forgetPassword(userEmail).then((result) async {
      //-------- fail response ---------

      if (result == null || result.apiStatus.code != ApiResponseType.OK.code) {
        Navigator.pop(context);
        showErrorDialog(result.message);
        return;
      }
      ForgetPasswordResponseModel model = result.result;
      correctCode = model.code!;
      print(correctCode);
      Navigator.pop(context);
    });

  }

  //-------------------
  void showErrorDialog(String txt) {
    isBtnEnabled = true;
    isResendEnabled = true;
    showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            showMessageDialog(context, LocaleKeys.error.tr(), txt, noPage));
  }
}
