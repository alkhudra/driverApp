import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/custom_widgets/brandname.dart';
import 'package:alkhudhrah_app/dialogs/alert_dialog.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/main.dart';
import 'package:alkhudhrah_app/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';

class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController phoneController = TextEditingController();
  String phoneNo = " ";
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
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 120, left: 30, right: 30),
            width: MediaQuery.of(context).size.width/0.3,
            height: MediaQuery.of(context).size.height/2.4,
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
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 60, vertical: 300),
            width: MediaQuery.of(context).size.width/1.4,
            height: MediaQuery.of(context).size.height/15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              border: Border.all(color: kLogoGreen,
              width: 1.5),
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.all(15.0),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/ksa_flag.jpg'),
                    ),
                  ),
                ),
                // SizedBox(width: 8,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text("+966", style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),),
                ),
                Expanded(
                  child: TextFormField(
                    controller: phoneController,
                    maxLength: 9,
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    //TODO: remove helpers to helper class

                    //Formatting for number only input
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    //Formatting number to begin with 05 
                    validator: (value) {
                      if(value!.isEmpty) {
                        _isBtnDisabled = true;
                        return LocaleKeys.please_enter.tr();
                      } else{
                        if(value.length!=9) { 
                          _isBtnDisabled = true;
                          return LocaleKeys.phone_length.tr();
                        } else {
                          if(value.startsWith("5")){
                            _isBtnDisabled = false;
                            phoneNo = "0" + value;
                          } else {
                          _isBtnDisabled = true;
                          return LocaleKeys.please_begin_number.tr();
                          }
                        }
                      }
                    },
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20),
                      focusColor: kLogoGreen,
                      border: InputBorder.none,
                      counterText: "",
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          //SIGN IN button
          Container(
            margin: EdgeInsets.fromLTRB(80, 470, 80, 310),
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
                if(_isBtnDisabled) {

                } else {
                  print(phoneNo);
                  showDialog(
                    context: context, 
                    builder: (BuildContext context ) =>
                      showPinDialog(context, phoneNo));
                }

                // Navigator.push(context, MaterialPageRoute(
                //   builder: (context) => Homescreen()));
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