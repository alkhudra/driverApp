import 'package:alkhudhrah_app/locale/codegen_loader.g.dart';
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
}



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/locale',
        fallbackLocale: Locale('en'),
        assetLoader: CodegenLoader(),
        child: MyApp()),
  );


  await flutterLocalNotificationsPlugin
  .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  ?.createNotificationChannel(channel);

  await messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true
  );
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
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static  bool isUserFirstLogin=false;
  static  bool isUserLoggedIn=false;
  static int counter = 0;
  @override
  void initState() {
    super.initState();
    setValues();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
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
          )
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
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
      color: kLogoGreen,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      routes: routMap,
      theme: ThemeData(
        fontFamily: 'Almarai',
        accentColor: kLogoGreen,
        primarySwatch: Colors.green,
      ),
      home: getRout(),
      // home: tempHome(),
    );
  }

    //replace getRout widget with tempHome to test local notifs
  Widget tempHome() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing Notifications'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: TextButton(
              child: Text('Send local Notif'),
              onPressed: showNotification,
            ),
          ),
        ],
      ),
    );
  }

  Widget getRout() {

    print(isUserFirstLogin);

    if (isUserFirstLogin == false && isUserLoggedIn == true)
      return DashboardPage();
    if (isUserFirstLogin == false && isUserLoggedIn == false)
      return LoginEmail();
    else
      return LanguagePage();
  }

  setValues() async {
    isUserFirstLogin = await PreferencesHelper.getIsUserFirstLogIn;
    isUserLoggedIn = await PreferencesHelper.getIsUserLoggedIn;
  }
}
