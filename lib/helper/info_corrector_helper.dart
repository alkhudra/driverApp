import 'package:alkhudhrah_app/constants/cont.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

bool isValidEmail(String email) {
  if (email.contains('@'))
    return true;
  else
    return false;
}

String isValidPhone(String phone) {
  if (phone.length != 10) {
    return LocaleKeys.phone_length.tr();
  } else if (!phone.startsWith('05')) {
    return LocaleKeys.please_begin_number.tr();
  } else
    return validPhone;
}