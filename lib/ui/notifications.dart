import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/designs/appbar_design.dart';
import 'package:alkhudhrah_app/designs/drawer_design.dart';
import 'package:alkhudhrah_app/designs/order_tile_design.dart';
import 'package:alkhudhrah_app/helper/shared_pref_helper.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/network/API/api_response.dart';
import 'package:alkhudhrah_app/network/API/api_response_type.dart';
import 'package:alkhudhrah_app/network/helper/exception_helper.dart';
import 'package:alkhudhrah_app/network/helper/network_helper.dart';
import 'package:alkhudhrah_app/network/models/driver_user.dart';
import 'package:alkhudhrah_app/network/models/notification/get_notification_response_model.dart';
import 'package:alkhudhrah_app/network/models/notification/notification_model.dart';
import 'package:alkhudhrah_app/network/repository/notification_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({ Key? key }) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {

static String name = '', email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<GetNotificationResponseModel>(
        future: getListData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return pageDesign(context, snapshot.data!);
          } else
            return errorCase(snapshot);
        },
      ),
      appBar: bnbAppBar(context, LocaleKeys.notifications_tab.tr()),
      //TODO: replace with drawer(name & email)
      endDrawer: drawerDesign(context),
    );
  }
  Widget notifCard(NotificationModel model) {
    return ListTile(
      title: Center(
        child: GestureDetector(
          onTap: (){
            //TODO: Driver has no getOrderById method
            // if(model.orderId != null && model.orderId != '0' ){
            //   directToOrderDetails(context, orderId:  model.orderId);

            // }
          },
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 5),
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  border: Border.all(
                    color: kLogoGreen,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      child: Container(
                        width: 5,
                        height: MediaQuery.of(context).size.height * 0.1,
                        color: kLogoGreen,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.14,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/ic_fruit_green.png'))),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.12),
                          //replace by order no
                          child: Text(
                            model.title!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: kLogoGreen,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.12),
                          //replace by actual date
                          child: Text(
                            model.sentDateTime!.toString(),
                            style: TextStyle(
                              color: kLogoGreen,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          //replace text by notification
                          margin: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width * 0.12),
                          child: Text(
                           model.body!.toString(),
                           overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14, 
                                color: kDarkBlue),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setValues();
  }

    void setValues() async {
    DriverUser user = await PreferencesHelper.getUser;
    name = user.driverName!;
    email = user.email!;
  }



  Future<GetNotificationResponseModel> getListData() async{

    Map<String, dynamic> headerMap = await getHeaderMap();

    NotifRepository notifRepository = NotifRepository(headerMap);

    ApiResponse apiResponse =
        await notifRepository.getUserNotification();

    if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
      GetNotificationResponseModel? responseModel =
      GetNotificationResponseModel.fromJson(apiResponse.result);

      //-----------------------------------
      return responseModel;
    } else {
      GetNotificationResponseModel.fromJson(apiResponse.result);
      throw ExceptionHelper(apiResponse.message);
    }
  }


    Widget pageDesign(
      BuildContext context, GetNotificationResponseModel getOrdersResponseModel) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return notifCard(getOrdersResponseModel.notificationList[index]);
      },
      itemCount: getOrdersResponseModel.notificationList.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(bottom: 25),
    );
  }
}