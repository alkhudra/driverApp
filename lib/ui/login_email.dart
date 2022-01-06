import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/custom_widgets/brandname.dart';
import 'package:alkhudhrah_app/designs/buttons_design.dart';
import 'package:alkhudhrah_app/designs/card_design.dart';
import 'package:alkhudhrah_app/designs/textfield_design.dart';
import 'package:alkhudhrah_app/dialogs/alert_dialog.dart';
import 'package:alkhudhrah_app/dialogs/progress_dialog.dart';
import 'package:alkhudhrah_app/helper/info_corrector_helper.dart';
import 'package:alkhudhrah_app/helper/shared_pref_helper.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/main.dart';
import 'package:alkhudhrah_app/network/api/api_response_type.dart';
import 'package:alkhudhrah_app/network/models/login_response_model.dart';
import 'package:alkhudhrah_app/network/models/register_response_model.dart';
import 'package:alkhudhrah_app/network/models/user_model.dart';
import 'package:alkhudhrah_app/network/repository/login_repository.dart';
import 'package:alkhudhrah_app/router/route_constants.dart';
import 'package:alkhudhrah_app/ui/forgotpassword.dart';
import 'package:alkhudhrah_app/ui/home.dart';
import 'package:alkhudhrah_app/ui/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginEmail extends StatefulWidget {
  const LoginEmail({ Key? key }) : super(key: key);

  @override
  _LoginEmailState createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isBtnEnabled = true;
  bool isChecked = false;
  bool isForgetPassBtnEnabled = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _isBtnDisabled = true;
  }

  @override
  Widget build(BuildContext context) {

      Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return kLogoBrown;
      }
      return kLogoGreen;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 120, left: 30, right: 30),
            width: MediaQuery.of(context).size.width/0.3,
            height: MediaQuery.of(context).size.height/2,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.2, 6.0),
                  blurRadius: 6.0,
                  spreadRadius: -2.0
                ),
              ],
              borderRadius: BorderRadius.circular(50),
              color: kCard,
            ),
          ),
          SizedBox(height: 50,),
          Container(
            margin: EdgeInsets.only(top: 50),
            alignment: Alignment.topCenter,
            child: brandName(115.0, 115.0, 20.0),
          ),
          SizedBox(height: 50,),
          Positioned(
            top: 260,
            left: 60,
            child: Container(
              alignment: Alignment.center,
              // margin: EdgeInsets.symmetric(horizontal: 60, vertical: 100),
              width: MediaQuery.of(context).size.width/1.4,
              height: MediaQuery.of(context).size.height/15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                border: Border.all(color: kLogoGreen,
                width: 1.5),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: [
                      ],
                      //Formatting number to begin with 05 
                      validator: (value) {
                        if(value != null) {

                        }
                      },
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined, color: kBlack.withOpacity(0.67),),
                        contentPadding: EdgeInsets.only(left: 20, right: 20),
                        labelText: LocaleKeys.email_textfield.tr(),
                        labelStyle: TextStyle(fontWeight: FontWeight.w500),
                        focusColor: kLogoGreen,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          Positioned(
            top: 340,
            left: 60,
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width/1.4,
              height: MediaQuery.of(context).size.height/15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                border: Border.all(color: kLogoGreen,
                width: 1.5),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: [
                      ],
                      //Formatting number to begin with 05 
                      validator: (value) {
                      },
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold),
                        obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline, color: kBlack.withOpacity(0.67),),
                        contentPadding: EdgeInsets.only(left: 20, right: 20),
                        labelText: LocaleKeys.password_textfield.tr(),
                        labelStyle: TextStyle(fontWeight: FontWeight.w500,),
                        focusColor: kLogoGreen,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          Positioned(
            top: 490,
            left: 150,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ForgotPassword(),
                  )
                );
              },
              child: Container(
                child: Text(LocaleKeys.forgot_PW_Btn.tr(), style: TextStyle(
                  color: kLogoGreen,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 50),
                alignment: Alignment.centerLeft,
                child: Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                      print(value);
                    });
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 50),
                alignment: Alignment.centerLeft,
                child: Text(LocaleKeys.remember_me.tr(),
                style: TextStyle(
                  color: kBlack.withOpacity(0.7),
                  fontSize: 16
                ),),
              ),
            ],
          ),
          SizedBox(height: 20,),
          //SIGN IN button
          Container(
            margin: EdgeInsets.fromLTRB(80, 540, 80, 310),
            width: MediaQuery.of(context).size.width/1.6,
            height: MediaQuery.of(context).size.height/12,
            child: TextButton(
              onPressed: () {
                // if (isBtnEnabled) logIn();
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Homescreen()));
                // if(_isBtnDisabled) {
                //   return null;
                // } else {
                //   setState(() {
                //     _isBtnDisabled = true;
                //   });
                //   Navigator.push(context, MaterialPageRoute(
                //   builder: (context) => Homescreen()));
                // }
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
                fixedSize: Size(250.0, 70.0),
                backgroundColor: kLogoGreen,
              ),
                //disable button after first click, to avoid 
                // sending two requests to DB
              child: Text(LocaleKeys.SIGN_IN.tr(), style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),),
            ),
          ),
        ],
      ),
    );
  }

    void showErrorDialog(String txt) {
    isBtnEnabled = true;
    showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            showMessageDialog(context, LocaleKeys.error.tr(), txt, noPage));
  }

  void logIn() {
    if (emailController.value.text == '') {
      showErrorDialog(LocaleKeys.email_required.tr());
      return;
    }

    if (isValidEmail(emailController.value.text) == false) {
      showErrorDialog(LocaleKeys.invalid_email.tr());
      return;
    }

    if (passwordController.value.text == '') {
      showErrorDialog(LocaleKeys.pass_required.tr());
      return;
    }

    isBtnEnabled = false;

    //login api call



    print('continue log in ');

     //----------show progress----------------
    showLoaderDialog(context);

    //----------start api ----------------
    LoginRepository loginRepository = LoginRepository();
    loginRepository
        .loginUser(
            emailController.text,
            passwordController.text)
        .then((result) async {

      //-------- fail response ---------
      if (result == null || result.apiStatus.code != ApiResponseType.OK.code) {
        Navigator.pop(context);
        showErrorDialog(result.message);
        return;
      }

      //-------- success response ---------
    LoginResponseModel model = result.result;
    print(model.user.toString());
    if(model.user != null) {
      print(model.user!.id);

      

      PreferencesHelper.setUserID(model.user!.id!);
      PreferencesHelper.getUserID.then((value) => print(value));

      PreferencesHelper.setUserToken(model.token);
      PreferencesHelper.getUserToken.then((value) => print(value));


      // PreferencesHelper.setUser(model.user!);
      // PreferencesHelper.getUser.then((value) => print(value.toString()));

    }


    Navigator.pop(context);

    directToHomePage();
  



      // RegisterResponseModel model = result.result;
      // print(model.userId);

      // showDialog(
      //         builder: (BuildContext context) =>
      //             showPinDialog(context, emailController.text, true),
      //         context: context)
      //     .then((value) {});
    });
  }

    void directToHomePage() {

    Navigator.push(context,
        MaterialPageRoute(builder: (context) {
          return Homescreen();
        }));
  }
}

  ////---------------------------

  Widget showEnterEmailDialog(BuildContext context) {
    String errorMessage = "enter your mail to send code ";

    bool visible = false;
    final TextEditingController controller = TextEditingController();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: Container(
        height: CardDesign.cardsHeight,
        width: CardDesign.cardsWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              LocaleKeys.reset_PW_title.tr(),
              style: TextStyle(
                fontSize: 20,
                color: kDarkBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {

                  if (!isValidEmail(controller.text)){
                   return LocaleKeys.invalid_email.tr();

                  }
                },
                controller: controller,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                    color: kBlack,
                    fontWeight: FontWeight.bold),
                decoration: textFieldDecorationWithIcon(
                    LocaleKeys.email_textfield.tr(), Icons.email),
              ),
            ),

            SizedBox(
              height: 35,
            ),
            //     ))
          ],
        ),
      ),
    );
  }
  

  
////---------------------------






// textButton(
//               btnName: 'SIGN IN', 
//               btnFunc:  Navigator.push(context, MaterialPageRoute(
//                   builder: (context) => Homescreen()))
//             ), //textButton