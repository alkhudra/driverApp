import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

Widget pinCode(BuildContext context){
  final TextEditingController controller = TextEditingController();
  StreamController<ErrorAnimationType> errorController =
  StreamController<ErrorAnimationType>();


  return PinCodeTextField(
    appContext: context,
    pastedTextStyle: TextStyle(
      color: kLogoGreen,
      fontWeight: FontWeight.bold,
    ),
    length: 4,
    // obscureText: true,
    blinkWhenObscuring: true,
    animationType: AnimationType.fade,

    errorAnimationController: errorController,
    pinTheme: PinTheme(
      errorBorderColor: kLike,
      inactiveFillColor: kWhite,
      selectedFillColor: kLogoGreen,
      shape: PinCodeFieldShape.box,
      inactiveColor: kLogoGreen,
      borderRadius: BorderRadius.circular(5),
      fieldHeight: 50,
      fieldWidth: 40,
      activeFillColor: kWhite,
    ),
    cursorColor: kLogoGreen,
    animationDuration: Duration(milliseconds: 300),
    enableActiveFill: true,
    controller: controller,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    keyboardType: TextInputType.number,
    boxShadows: [
      BoxShadow(
        offset: Offset(0, 1),
        color: kBlack,
        blurRadius: 5,
      )
    ],
    beforeTextPaste: (text) {
      print("Allowing to paste $text");
      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
      //but you can show anything you want here, like your pop up saying wrong paste format or etc
      return false;
    },
    onChanged: (String value) {},
    onCompleted: (v) {




    },
  );
}

Widget pinCodeExisting(BuildContext context, String? checkedCode){
  final TextEditingController controller = TextEditingController();
  StreamController<ErrorAnimationType> errorController =
  StreamController<ErrorAnimationType>();


  return PinCodeTextField(
    // enabled: false,
    appContext: context,
    pastedTextStyle: TextStyle(
      color: kLogoGreen,
      fontWeight: FontWeight.bold,
    ),
    length: 4,
    hintCharacter: checkedCode,
    blinkWhenObscuring: true,
    animationType: AnimationType.fade,
    hapticFeedbackTypes: HapticFeedbackTypes.medium,
    errorAnimationController: errorController,
    pinTheme: PinTheme(
      errorBorderColor: Colors.red[900],
      inactiveFillColor: Colors.transparent,
      selectedFillColor: kLogoGreen.withOpacity(0.2),
      shape: PinCodeFieldShape.underline,
      inactiveColor: kLogoGreen,
      selectedColor: kDarkBlue,
      // borderRadius: BorderRadius.circular(5),
      fieldHeight: 50,
      fieldWidth: 40,
      activeFillColor: Colors.transparent
    ),
    cursorColor: kLogoGreen,
    animationDuration: Duration(milliseconds: 300),
    enableActiveFill: true,
    controller: controller,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    keyboardType: TextInputType.number,
    // boxShadows: [
    //   BoxShadow(
    //     offset: Offset(0, 1),
    //     color: kBlack,
    //     blurRadius: 5,
    //   )
    // ],
    beforeTextPaste: (text) {
      print("Allowing to paste $text");
      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
      //but you can show anything you want here, like your pop up saying wrong paste format or etc
      return false;
    },
    onChanged: (String value) {},
    onCompleted: (v) {




    },
  );
}