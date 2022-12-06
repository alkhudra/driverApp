import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/designs/appbar_design.dart';

import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

import '../constants/cont.dart';
import '../helper/image_helper.dart';
import '../helper/route_helper.dart';

import 'contact_us.dart';
import 'home.dart';
import 'language_setting.dart';
import 'notifications.dart';
import 'order_history.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String name = Consts.name, email = Consts.email, image = Consts.image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: bnbAppBar(context, LocaleKeys.my_setting.tr()),
      // endDrawer: drawerDesign(context, name, email, image),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 ImageHelper.driverImage(context, image),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      name ?? ' ',
                      style: TextStyle(
                        color: kLogoGreen,
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      email ?? ' ',
                      style: TextStyle(
                        color: kLogoGreen,
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            listDivider(),

            ////////////////////////////

            listTileDesign(
                txt: LocaleKeys.order_history.tr(),
                icon: FontAwesomeIcons.history,
                iconColor: order,
                iconBG: orderBG,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OrderHistory()));
                }),
            listDivider(),
            ////////////////////////////

            listTileDesign(
                txt: LocaleKeys.contact_us.tr(),
                icon: Icons.verified_user_rounded,
                iconColor: kCon,
                iconBG: kConBG,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactUs()),
                  );
                }),

            listDivider(),
            ////////////////////////////
            listTileDesign(
                txt: LocaleKeys.languages.tr(),
                icon: FontAwesomeIcons.globeAfrica,
                iconColor: kLang,
                iconBG: kLangBG,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LanguageSetting()),
                  );
                }),

            listDivider(),
            ////////////////////////////

            listTileDesign(
                txt: LocaleKeys.log_out.tr(),
                icon: Icons.logout,
                iconColor: kLogOut,
                iconBG: kLogOutBG,
                onTap: () {
                  logoutUser(context);
                }),

            ListTile(
              title: SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Version $version',
                    style: TextStyle(
                      color: kLogoGreen,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  listTileDesign(
      {txt,
      onTap,
      icon,
      iconColor,
      iconBG,
      Widget trailing = const Icon(
        Icons.arrow_forward_ios_sharp,
        size: 20,
      )}) {
    return ListTile(
      trailing: trailing,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: iconBG),
        child: Icon(
          icon,
          size: 17,
          color: iconColor,
        ),
      ),
      title: Text(
        txt,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }

  listDivider() {
    return const Divider(
      thickness: 1,
    );
  }
}
