import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/custom_widgets/brandname.dart';
import 'package:alkhudhrah_app/dialogs/alert_dialog.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/main.dart';
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
  late bool _isBtnDisabled;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isBtnDisabled = true;
  }

  @override
  Widget build(BuildContext context) {
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
          SizedBox(height: 20,),
          //SIGN IN button
          Container(
            margin: EdgeInsets.fromLTRB(80, 540, 80, 310),
            width: MediaQuery.of(context).size.width/1.6,
            height: MediaQuery.of(context).size.height/12,
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
                fixedSize: Size(250.0, 70.0),
                backgroundColor: kLogoGreen,
              ),
              onPressed:() {
                //disable button after first click, to avoid 
                // sending two requests to DB
                // if(_isBtnDisabled) {
                //   return ;
                // } else {
                //   print(phoneNo);
                //   showDialog(
                //     context: context, 
                //     builder: (BuildContext context ) =>
                //       showPinDialog(context, phoneNo));
                // }
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Login()));

              }, 
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
}


// textButton(
//               btnName: 'SIGN IN', 
//               btnFunc:  Navigator.push(context, MaterialPageRoute(
//                   builder: (context) => Homescreen()))
//             ), //textButton