// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "SIGN IN": "SIGN IN",
  "Please begin number with 5": "Number must start with 5",
  "Please enter your phone number" : "Please enter a phone number",
  "Alkhadra United" : "Alkhadra United",
  "Ok" : "Ok",
  "Enter code" : "Enter code",
  "auth_note" : "Thank you for choosing AlKhadra United Company. Please wait until the data is validated and the verification code will be sent to you on your email.",
  "Verify" : "Verify",
  "enter_code_note" : "Enter the code sent to ",
  "resend_code" : "Resend code",
  "resend_code_note" : "Didn't receive a code?",
  "Please enter 9 digit number" : "Please enter 9 digit number"
};
static const Map<String,dynamic> ar = {
  "SIGN IN": "تسجيل الدخول",
  "Please begin number with 5": "الرجاء بدء رقم الجوال بـ 5",
  "Please enter your phone number" : "الرجاء إدخال رقم الجوال",
  "Please enter 9 digit number" : "الرجاء إدخال رقم مكون من ٩ خانات",
  "Alkhadra United" : "الخضراء المتحدة",
  "Ok" : "متابعة",
  "Enter code" : "الرجاء إدخال الرمز",
  "auth_note" : "Thank you for choosing AlKhadra United Company. Please wait until the data is validated and the verification code will be sent to you on your email.",
  "Verify" : "تحقق",
  "enter_code_note" : "أدخل الرمز المرسل إلى ",
  "resend_code" : "إعادة إرسال رمز التحقق",
  "resend_code_note" : "لم يصلك رمز التحقق؟"
  
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "ar": ar};
}
