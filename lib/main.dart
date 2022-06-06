import 'package:alkhudhrah_app/designs/order_tile_design.dart';
import 'package:alkhudhrah_app/locale/codegen_loader.g.dart';
import 'package:alkhudhrah_app/network/API/api_response.dart';
import 'package:alkhudhrah_app/network/API/api_response_type.dart';
import 'package:alkhudhrah_app/network/helper/network_helper.dart';
import 'package:alkhudhrah_app/network/models/orders/order_header.dart';
import 'package:alkhudhrah_app/network/repository/order_repository.dart';
import 'package:alkhudhrah_app/ui/language_setting.dart';
import 'package:alkhudhrah_app/ui/order_details.dart';
import 'package:alkhudhrah_app/ui/wallet.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:alkhudhrah_app/ui/login_email.dart';
import 'package:alkhudhrah_app/ui/dashboard_page.dart';
import 'package:alkhudhrah_app/ui/language_page.dart';
import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/router/route_constants.dart';
import 'helper/shared_pref_helper.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");
late String routeToGo = '/';
String? payload;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', //id
  'High Importance Notifications', //title
  description: 'This channel is used for important notifications',
  importance: Importance.high,
  playSound: true
);

FirebaseMessaging messaging = messaging;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg msg just showed up : ${message.messageId}');
  //change second to OrderDetails(orderID)
  routeToGo = '/second';
  print(message.notification!.body);
}

Future<void> selectNotification(String? payload) async {
  if (payload != null) {
    debugPrint('notification payload: $payload');
    navigatorKey.currentState?.pushNamed('/second');
  }
}

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  bool isUserLoggedIn = await PreferencesHelper.getIsUserLoggedIn == null ? false:await PreferencesHelper.getIsUserLoggedIn ;
  bool isUserFirstLogin = await PreferencesHelper.getIsUserFirstLogIn == null ? true:await PreferencesHelper.getIsUserFirstLogIn ;

  
 
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/locale',
        fallbackLocale: Locale('en'),
        assetLoader: CodegenLoader(),
        child: MyApp(isUserFisrtLogin: isUserFirstLogin,isUserLoggedIn:isUserLoggedIn)),
  );


  await flutterLocalNotificationsPlugin
  .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  ?.createNotificationChannel(channel);

  await messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true
  );

  final NotificationAppLaunchDetails? notificationAppLaunchDetails =
    await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    print('payload=');
    payload= notificationAppLaunchDetails!.payload;
  if(payload != null){
    routeToGo = '/second';
    navigatorKey.currentState?.pushNamed('/second');
  }

}

// Future init() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//   await flutterLocalNotificationsPlugin
//   .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//   ?.createNotificationChannel(channel);

//   await messaging.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true
//   );
// }

class MyApp extends StatefulWidget {
  final bool isUserLoggedIn ,isUserFisrtLogin;
  
  const MyApp({
    Key? key,
required this.isUserFisrtLogin,required this.isUserLoggedIn}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  static int counter = 0;

  late String token;

    getToken() async {
    token = (await FirebaseMessaging.instance.getToken())!;
    print(token);
  }

  @override
  void initState() {
    super.initState();
    // firebaseTrigger(context);

    // FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage message) {
    //   if (message != null) {
    //     Navigator.pushNamed(context, '/message'); //map[orderId] route
    //   }
    // });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if(notification  != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode, 
          notification.title, 
          notification.body, 
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              color: kLogoGreen,
              playSound: true,
              //TODO: Add custom icon
              icon: '@mipmap/ic_launcher'
            ),
            // iOS: IOSNotificationDetails()
          ),
          // payload: 
        );
      }

      print('Title is ' + notification!.title.toString());
      print('Data is ' + message.data.toString());
      print('Body is ' + notification.body.toString());

      if(message.data != null) {
        Map<String, dynamic> map = message.data;
        if (map.containsKey('orderId') && map['orderId'] != '0') {
          print(map.containsKey('orderId'));
          print(map['orderId'] != 0);
          print(map['orderId']);


        print('Navigation reached here!');
          // navigatorKey.currentState!.push(MaterialPageRoute(builder: ((context) => WalletScreen())));
          // directToOrderDetails(context, orderId: message.data['orderId']);

        String language = await PreferencesHelper.getSelectedLanguage;

        Map<String, dynamic> headerMap = await getHeaderMap();

        OrderRepository orderRepository = OrderRepository(headerMap);

        ApiResponse apiResponse = await orderRepository.getOrderById(int.parse(map['orderId']));

        if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
          OrderHeader? responseModel = OrderHeader.fromJson(apiResponse.result);

          navigatorKey.currentState!.push(MaterialPageRoute(builder: ((context) => 
          OrderDetails(
                    orderModel: responseModel,
                    language: language,
                  ))));
        }

      }
    }

      print('navigation successful');
    });
    getToken();




    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('A new onMessageOpenedApp event was published');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print(message.notification!.body != null);
      // if (message.notification!.body != null) {
      //   navigatorKey.currentState?.pushNamed('/second');
      // }

      if(notification != null && android != null) {
        showDialog(context: context,
          builder: (_) {
            return AlertDialog(
              title: Text('Notification.title'),
              content:  SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notification.body!)
                  ],
                ),
              ),
            );
          });
          // Navigator.push(context, MaterialPageRoute(
            // builder: (context) => OrderDea));
      }

      print('Title is ' + notification!.title.toString());
      print('Data is ' + message.data.toString());
      // print('Body is ' + notification.body.toString());

      if(message.data != null) {
        Map<String, dynamic> map = message.data;
        if (map.containsKey('orderId') && map['orderId'] != '0') {
          print(map.containsKey('orderId'));
          print(map['orderId'] != 0);
          print(map['orderId']);

          // navigatorKey.currentState!.push(MaterialPageRoute(builder: ((context) => WalletScreen())));
          // directToOrderDetails(context, orderId: message.data['orderId']);

        String language = await PreferencesHelper.getSelectedLanguage;

        Map<String, dynamic> headerMap = await getHeaderMap();

        OrderRepository orderRepository = OrderRepository(headerMap);

        ApiResponse apiResponse = await orderRepository.getOrderById(int.parse(map['orderId']));

        if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
          OrderHeader? responseModel = OrderHeader.fromJson(apiResponse.result);

          navigatorKey.currentState!.push(MaterialPageRoute(builder: ((context) => 
          OrderDetails(
                    orderModel: responseModel,
                    language: language,
                  ))));

          // print('Navigation reached here!');
        }

        }
      }
    });
  }

  void showNotification() async{
    setState(() {
      counter++;
    });

    String? token = await messaging.getToken();
    print('Notification token: ' + token!);

    flutterLocalNotificationsPlugin.show(
      0, 
      'Testing $counter', 
      'How you doin?', 
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id, 
          channel.name,
          channelDescription: channel.description,
          importance: Importance.high,
          color: kLogoGreen,
          playSound: true,
          //TODO: Add custom icon
          icon: '@mipmap/ic_launcher'
        ),
        // iOS: IOSNotificationDetails()
      ));


        await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
          alert: true, // Required to display a heads up notification
          badge: true,
          sound: true,
        );


        NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );

        print('User granted permission: ${settings.authorizationStatus}');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      color: kLogoGreen,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      routes: routMap,
      // initialRoute: (routeToGo != null) ? routeToGo : '/',
      // onGenerateRoute: (RouteSettings settings) {
      //     switch (settings.name) {
      //       case '/':
      //         return MaterialPageRoute(
      //           builder: (_) => const DashboardPage(),
      //         );
      //         break;
      //       case '/second':
      //       Navigator.push(context, MaterialPageRoute(builder: (context) => WalletScreen()));
      //       // directToOrderDetails(context);
      //         // return MaterialPageRoute(
      //         //   builder: (_) => const OrderDetails(),
      //         // );
      //         break;
      //       default:
      //         return _errorRoute();
      //     }
      // },
      theme: ThemeData(
        fontFamily: 'Almarai',
        accentColor: kLogoGreen,
        primarySwatch: Colors.green,
      ),
      home: getRout(),
      // home: tempHome(),
    );
  }



  Widget getRout() {



    if (widget.isUserFisrtLogin == false && widget.isUserLoggedIn == true)
      return DashboardPage();
    if (widget.isUserFisrtLogin == false && widget.isUserLoggedIn == false)
      return LoginEmail();
    else
      return LanguagePage();
  }


  
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
        builder: (_){
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Align(
                        child:  Container(
                          width: 150,
                          height: 150,
                          child: Icon(
                            Icons.delete_forever,
                            size: 48,
                          ),
                        ),
                        alignment: Alignment.center,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 150,
                          height: 150,
                          child: CircularProgressIndicator(
                              strokeWidth: 4,
                              value: 1.0
                            // valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.withOpacity(0.5)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text('Page Not Found'),
                  SizedBox(height: 10,),
                  Text('Press back button on your phone', style: TextStyle(color: Color(0xff39399d), fontSize: 28),),
                  SizedBox(height: 20,),
                  /*ElevatedButton(
                    onPressed: () {
                      Navigator.pop();
                      return;
                    },
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.orange),
                    ),
                    child: const Text('Back to home'),
                  ),*/
                ],
              ),
            ),
          );
        }
    );
  }
}


// void navigatorKeyToOrderDetails(navigatorKey, {model, orderId}) async {
//   String language = await PreferencesHelper.getSelectedLanguage;

//   //todo: test
//   if (model == null) {
//     Map<String, dynamic> headerMap = await getHeaderMap();

//     OrderRepository orderRepository = OrderRepository(headerMap);

//     ApiResponse apiResponse = await orderRepository.getOrderById(orderId);

//     if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
//       OrderHeader? responseModel = OrderHeader.fromJson(apiResponse.result);
//       navigatorKey.currentState!.push(MaterialPageRoute(builder: ((context) => 
//       OrderDetails(
//                 orderModel: responseModel,
//                 language: language,
//               ))));

//     }
//   } else
//       navigatorKey.currentState!.push(
//       MaterialPageRoute(
//           builder: (context) => OrderDetails(
//                 orderModel: model,
//                 language: language,
//               )));
// }