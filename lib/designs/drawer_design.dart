import 'package:alkhudhrah_app/constants/api_const.dart';
import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/helper/route_helper.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/ui/contact_us.dart';
import 'package:alkhudhrah_app/ui/language_setting.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

Drawer drawerDesign(context, name, email, image) {

  return Drawer(
    child: ListView(
      padding: EdgeInsets.all(0.0),
      children: [
        Container(
          width: 100,
          height: 250,
          decoration: BoxDecoration(
            color: kLogoGreen,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.only(top: 40),
                child: CircleAvatar( 
                 backgroundImage: AssetImage('assets/images/male_avatar.png'),
                 //dummy image from internet, can be deleted 
                //  foregroundImage: NetworkImage('https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60'),
                 foregroundImage: NetworkImage(ApiConst.dashboard_url + image),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                child: Text(name, style: TextStyle(
                  color: kWhite,
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                ),),
              ),
              SizedBox(height: 10,),
              Container(
                child: Text(email, style: TextStyle(
                  color: kWhite,
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),),
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kLangBG
                ),
                child: Icon(Icons.language, color: kLang,),
              ),
              SizedBox(width: 10,),
              Text(LocaleKeys.languages.tr(), style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),),
            ],
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, 
            MaterialPageRoute(
              builder: (context) => LanguageSetting()
              ),
            );
          },
        ),
        Divider(
          thickness: 2.5,
        ),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kConBG
                ),
                child: Icon(Icons.verified_user_rounded, color: kCon,),
              ),
              SizedBox(width: 10,),
              Text(LocaleKeys.contact_us.tr(), style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),),
            ],
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, 
            MaterialPageRoute(
              builder: (context) => ContactUs()
              ),
            );
          },
        ),
        Divider(
          thickness: 2.5,
        ),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kLogOutBG
                ),
                child: Icon(Icons.logout, color: kLogOut,),
              ),
              SizedBox(width: 10,),
              Text(LocaleKeys.log_out.tr(), style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),),
            ],
          ),
          onTap: () {
            Navigator.pop(context);
            logoutUser(context);
          },
        ),
      ],
    ),
  );
}