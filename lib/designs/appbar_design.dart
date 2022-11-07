import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

AppBar appBarDesign(context, title) {
  return AppBar(
    leading: GestureDetector(
      child: Icon(Icons.arrow_back_ios),
      onTap: () {
        Navigator.pop(context);
      },
    ),
    actions: [
      Icon(Icons.menu, color: Colors.transparent, size: 38,)
    ],
    backgroundColor: kLogoGreen,
    centerTitle: true,
    title: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 7.5,
              left: MediaQuery.of(context).size.width / 2.8),
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/grapevector.png'),
            ),
          ),
        ),
        Container(
          // margin: EdgeInsets.only(top: scHeight/7.5),
          child: Center(
            child: Text(
              title,
              style: TextStyle(),
            ),
          ),
        ),
      ],
    ),
  );
}


//---- actions when click back 
AppBar appBarWithActions(context, title, Function() action) {
  return AppBar(
    leading: GestureDetector(
      child: Icon(FontAwesomeIcons.history, size: 23,),
      onTap: action,
    ),


    backgroundColor: kLogoGreen,
    centerTitle: true,
    title: appBarTitle(context,title)
  );
}




//appbar for BNB pages

AppBar bnbAppBar(context, title) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: kLogoGreen,
    centerTitle: true,
    title: appBarTitle(context, title),
  );
}
//---

AppBar appBarDesignWithTabs(context, title,tabsList) {
  return AppBar(
    leading: GestureDetector(
      child: Icon(Icons.arrow_back_ios),
      onTap: () {
        Navigator.pop(context);
      },
    ),

    bottom: TabBar(
      tabs: tabsList,

    ),
    backgroundColor: kLogoGreen,
    centerTitle: true,
    title: appBarTitle(context, title),
  );
  

}

//--------------
appBarTitle(context,title) {

  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 7.5,
            left: MediaQuery.of(context).size.width / 2.8),
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/grapevector.png'),
          ),
        ),
      ),
      Container(
        // margin: EdgeInsets.only(top: scHeight/7.5),
        child: Center(
          child: Text(
            title,
            style: TextStyle(),
          ),
        ),
      ),
    ],
  );
}

