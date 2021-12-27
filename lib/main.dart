import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/custom_widgets/brandname.dart';
import 'package:alkhudhrah_app/ui/login.dart';
import 'package:alkhudhrah_app/ui/login_email.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './locale/codegen_loader.g.dart';

Future<void> main() async {
  // runApp(MyHomepage());
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
    child: MyHomepage(),
    supportedLocales: [
      Locale('en'),
      Locale('ar'),
    ],
    path: 'assets/locale',
    fallbackLocale: Locale('en'),
    assetLoader: CodegenLoader(),
  ));
}

class MyHomepage extends StatefulWidget {
  const MyHomepage({ Key? key }) : super(key: key);

  @override
  _MyHomepageState createState() => _MyHomepageState();

  static _MyHomepageState  of(BuildContext context) => context.findAncestorStateOfType<_MyHomepageState>()!;
}

class _MyHomepageState extends State<MyHomepage> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}

class Homepage extends StatelessWidget {
  const Homepage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[100],
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //image and text
              Container(
                alignment: Alignment.center,
                child: brandName(250.0, 250.0, 30.0),
              ),
              SizedBox(height: 60,),
              //Arabic button
              Container(
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    fixedSize: Size(310.0, 50.0),
                    backgroundColor: kLogoBrown,
                  ),
                  onPressed: () {
                    context.setLocale(Locale('ar'));
                    Navigator.push(context, MaterialPageRoute(
                    builder: (context) => LoginEmail()));
                  },
                  child: Text("عربي", style: TextStyle(
                    color: kWhite,
                    fontSize: 25,
                  ),),
                ),
              ),
              SizedBox(height: 20,),
              //English button
              Container(
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    fixedSize: Size(310.0, 50.0),
                    backgroundColor: kLogoGreen,
                  ),
                  onPressed: () {
                    context.setLocale(Locale('en'));
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => LoginEmail()));
                  }, 
                  child: Text("English", style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),),
                ),
              ),
            ],
          ),
        ),
      );
  }
}