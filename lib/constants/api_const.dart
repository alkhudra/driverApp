abstract class ApiConst {
  static const String basic_url =
      'http://alkhudrahproject-001-site3.ctempurl.com/api';

  static const String login_url = '/AccountDriver/login';
  //requires String id
  static const String get_user_info_url = '/AccountDriver/getRegisteredUser/';
  static const String reset_profile_url = '/AccountDriver/resetPassword';
  static const String forget_password_url = '/AccountDriver/forgetPassword';
  // static const String send_code_url = '/account/sendCode';
  static const String check_password_token = '/AccountDriver/checkPasswordToken';
}