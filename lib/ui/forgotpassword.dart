import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/ui/password_reset.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({ Key? key }) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 150, left: 50),
                alignment: Alignment.topCenter,
                child: Text(LocaleKeys.forgot_password, style: TextStyle(
                  color: kDarkBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),)
              ),
              //TODO: X shape for cancel action
              
              // Container(
              //   // margin: EdgeInsets.only(top: 1),
              //   alignment: Alignment.topCenter,
              //   width: MediaQuery.of(context).size.width/10,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     color: kDarkBlue,
              //   ),
              // ),
            ],
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
              child: Expanded(
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  //TODO: remove helpers to helper class
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
            ),
          ),
          SizedBox(height: 20,),
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
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ResetPassword()));
              }, 
              child: Text(LocaleKeys.send_code_btn.tr(), style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),),
            ),
          ),
        ]
      ),
    );
  }
}