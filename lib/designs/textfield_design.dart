import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:flutter/material.dart';

class TextFieldDesign {


  static textFieldStyle({context, double? verMarg, double? horMarg, TextEditingController? controller, TextInputType? kbType, String? lbTxt, validat, enabled, obscTxt}) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: horMarg!, vertical: verMarg!),
      width: MediaQuery.of(context).size.width/1.15,
      height: MediaQuery.of(context).size.height/15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        border: Border.all(color: kLogoGreen,
            width: 1.5),
      ),
      child: Expanded(
        child: TextFormField(
          enabled: enabled,
          obscureText: obscTxt,
          controller: controller,
          keyboardType: kbType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validat,
          style: TextStyle(
              color: kBlack,
              fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            labelText: lbTxt,
            labelStyle: TextStyle(
                color: kBlack.withOpacity(0.7),
                fontSize: 16,
                fontWeight: FontWeight.w400
            ),

            contentPadding: EdgeInsets.only(left: 20,right: 20),

            focusColor: kBlack,
            border: InputBorder.none,
            counterText: "",
          ),
        ),
      ),
    );
  }

}

InputDecoration textFieldDecorationWithIcon(String hint, IconData icon) {
  return InputDecoration(
    contentPadding: EdgeInsets.all(20),
    focusColor: kLogoGreen,
    hintText: hint,
    hintStyle: TextStyle(color: kGray),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.0),
      borderSide:
          BorderSide(color: kLogoGreen, width: 1.0),
    ),
    prefixIcon: Icon(
      icon,
      color: kGray,
    ),
  );
}

//-----------------------------------------

InputDecoration textFieldDecoration(String hint) {
  return InputDecoration(
    contentPadding: EdgeInsets.all(20),
    focusColor: kLogoGreen,
    hintText: hint,
    hintStyle: TextStyle(color: kGray),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.0),
      borderSide:
          BorderSide(color: kLogoGreen, width: 1.0),
    ),
  );
}