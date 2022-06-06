abstract class ApiConst {
  static const String basic_url = 'https://driver.alkhadraunited.com/api';
      // 'http://alkhudrahproject-001-site3.ctempurl.com/api';
  static const String dashboard_url = 'https://dashboard.alkhadraunited.com/';
  // 'http://alkhadraunited.com';
  static const String pdf_url =
    'https://driver.alkhadraunited.com';

  static const String login_url = '/AccountDriver/login';
  static const String logout_url =  ' /AccountDriver/logout';
  //requires String id
  static const String get_user_info_url = '/AccountDriver/getRegisteredUser/';
  static const String reset_password_url = '/AccountDriver/resetPassword';
  static const String forget_password_url = '/AccountDriver/forgetPassword';
  //check if account or accountdriver for check pw token
  static const String check_password_token_url = '/AccountDriver/checkPasswordToken';
  static const String get_contact_url = "/HomeD/getContactUs";
  // static const String send_code_url = '/account/sendCode';
 // static const String check_password_token = '/AccountDriver/checkPasswordToken';
  //--------------- orders ----------------
  static const String get_orders = "/Orders/getOrders";
  static const String order_delivered = "/Orders/orderDelivered";
  static const String get_order_by_id = "/Order/getOrderById/{id}";

 //--------------- Notifications ----------------
static const String send_notification = "/NotificationD/send";
static const String get_user_notification = "/NotificationD/getUserNotifications";
}