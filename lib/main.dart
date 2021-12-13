import 'package:alkhudhrah_app/custom_widgets/widget.dart';
import 'package:alkhudhrah_app/ui/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyHomepage());
}

class MyHomepage extends StatefulWidget {
  const MyHomepage({ Key? key }) : super(key: key);

  @override
  _MyHomepageState createState() => _MyHomepageState();

  static _MyHomepageState  of(BuildContext context) => context.findAncestorStateOfType<_MyHomepageState>()!;
}

class _MyHomepageState extends State<MyHomepage> {

  Locale? _locale;

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      home: Homepage(),
      debugShowCheckedModeBanner: false,
      title: 'Localizations Sample App',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), // English, no country code
        Locale('ar', ''), // Spanish, no country code
      ],
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
                    backgroundColor: Color.fromRGBO(116, 73, 34, 1),
                  ),
                  onPressed: () => MyHomepage.of(context).setLocale(Locale.fromSubtags(languageCode: 'ar')), 
                  child: Text("عربي", style: TextStyle(
                    color: Colors.white,
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
                    backgroundColor: Color.fromRGBO(103, 156, 65, 1),
                  ),
                  onPressed: () {
                    MyHomepage.of(context).setLocale(Locale.fromSubtags(languageCode: 'en'));
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Login()));
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