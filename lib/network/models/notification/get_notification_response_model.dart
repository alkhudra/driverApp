
import 'package:alkhudhrah_app/network/models/notification/notification_model.dart';



class GetNotificationResponseModel {
  List<NotificationModel> _notificationList = [];
  String? message;

  List<NotificationModel> get notificationList =>
      _notificationList; //BranchListResponseModel(this._branches, this.message);

  GetNotificationResponseModel.fromJson(dynamic json) {
    //  message = json['message'];

    if (json != null) {
      _notificationList = [];
      json.forEach((v) {
        _notificationList.add(NotificationModel.fromJson(v));
      });
    }
  }


  @override
  String toString() {
    return 'GetNotifsResponseModel{_NotifsList: $_notificationList}';
  }

  GetNotificationResponseModel();

}

