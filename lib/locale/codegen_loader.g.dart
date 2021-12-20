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
  "Please begin number with 5": "Please begin number with 5",
  "Alkhadra United" : "Alkhadra United"
};
static const Map<String,dynamic> ar = {
  "SIGN IN": "تسجيل الدخول",
  "Please begin number with 5": "الرجاء بدء رقم الجوال بـ 5",
  "Alkhadra United" : "الخضراء المتحدة"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "ar": ar};
}
