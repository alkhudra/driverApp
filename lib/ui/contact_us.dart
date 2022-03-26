import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/custom_widgets/brandname.dart';
import 'package:alkhudhrah_app/designs/appbar_design.dart';
import 'package:alkhudhrah_app/designs/drawer_design.dart';
import 'package:alkhudhrah_app/designs/textfield_design.dart';
import 'package:alkhudhrah_app/helper/contact_helper.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/network/api/api_response.dart';
import 'package:alkhudhrah_app/network/helper/exception_helper.dart';
import 'package:alkhudhrah_app/network/helper/network_helper.dart';
import 'package:alkhudhrah_app/network/models/contact_us_response_model.dart';
import 'package:alkhudhrah_app/network/repository/contact_us_repository.dart';
import 'package:alkhudhrah_app/ui/edit_profile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../network/api/api_response_type.dart';
import 'contact_us.dart';
import 'language_setting.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({ Key? key }) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  bool _customTileExpanded = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: appBarDesign(context, LocaleKeys.contact_us.tr()),
      body: FutureBuilder<ContactUsResponseModel?>(
        future: getContactUsInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return getContactUsDesign(snapshot.data);
          } else
            return errorCase(snapshot);
        },
      ),
      // endDrawer: drawerDesign(context),
    );
  }


  //---------------------

  Widget getContactUsDesign(ContactUsResponseModel? model) {
    String phone = model!.phoneNumber!;
       String twitter= model.twitter!;
    String email = model.email!;
    num lat = model.latitude!;
    num lng = model.longitude!;

    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;
    return ListView(
      children: [
        ListTile(
          minVerticalPadding: 20,
          title: brandName(100.0, 100.0, 22.0),
        ),
        SizedBox(
          height: 10,
        ),
        //phone
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
              // color: CustomColors().primaryWhiteColor,
              borderRadius: BorderRadius.circular(30)),
          child: ListTile(
            title: GestureDetector(
              onTap: () {
                print('phone');
                directToPhoneCall(phone);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // margin: EdgeInsets.only(left: 10),
                    width: scWidth * 0.17,
                    height: scHeight * 0.13,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/product_icon.png'),
                      ),
                    ),
                    child: Icon(
                      FontAwesomeIcons.phoneVolume,
                      color: kDarkBlue.withOpacity(0.8),
                      size: 35,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    // margin: EdgeInsets.only(left: 10),
                    // alignment: Alignment.center,
                    width: scWidth * 0.4,
                    child: Text(
                      phone,
                      style: TextStyle(
                          color: kDarkBlue,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        //email
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: ListTile(
            title: GestureDetector(
              onTap: () {
                print('email');
                sendMail(email);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // margin: EdgeInsets.only(left: 10),
                    width: scWidth * 0.17,
                    height: scHeight * 0.13,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/product_icon.png'),
                      ),
                    ),
                    child: Icon(
                      Icons.alternate_email_outlined,
                      color: kDarkBlue,
                      size: 35,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    // margin: EdgeInsets.only(left: 10),
                    // alignment: Alignment.center,
                    width: scWidth * 0.5,
                    child: Text(
                      email,maxLines: 1,
                      style: TextStyle(
                          color: kDarkBlue,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        //social media
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: ExpansionTile(
            initiallyExpanded: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(width: 20,),
                Container(
                  // margin: EdgeInsets.only(left: 10),
                  width: scWidth * 0.17,
                  height: scHeight * 0.13,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/product_icon.png'),
                    ),
                  ),
                  child: Icon(FontAwesomeIcons.hashtag,
                      color: kDarkBlue),
                ),
                SizedBox(
                  width: 50,
                ),
                Container(
                  // margin: EdgeInsets.only(left: 10),
                  // alignment: Alignment.center,
                  width: scWidth * 0.4,
                  child: Text(
                    LocaleKeys.social_media.tr(),
                    style: TextStyle(
                        color: kDarkBlue,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            children: [
              ListTile(
                title: GestureDetector(
                  onTap: () {
                    print('whats');
                    openWhatsApp(phone);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // margin: EdgeInsets.only(left: 10),
                        width: scWidth * 0.15,
                        height: scHeight * 0.12,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/product_icon.png'),
                          ),
                        ),
                        child: Icon(FontAwesomeIcons.whatsapp,
                            color: kDarkBlue),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        // margin: EdgeInsets.only(left: 10),
                        alignment: Alignment.center,
                        width: scWidth * 0.4,
                        child: Text(
                          LocaleKeys.whats_app.tr(),
                          style: TextStyle(
                              color: kDarkBlue,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //twitter
              ListTile(
                title: GestureDetector(
                  onTap: () {
                    print('twitter');
                    openTwitterApp(twitter);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // margin: EdgeInsets.only(left: 10),
                        width: scWidth * 0.15,
                        height: scHeight * 0.12,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/product_icon.png'),
                          ),
                        ),
                        child: Icon(FontAwesomeIcons.twitter,
                            color: kDarkBlue),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        // margin: EdgeInsets.only(left: 10),
                        alignment: Alignment.center,
                        width: scWidth * 0.4,
                        child: Text(
                          //TODO: replace text with twitter handle
                          LocaleKeys.twit.tr(),
                          style: TextStyle(
                              color: kDarkBlue,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            trailing: Container(
              padding: EdgeInsets.only(top: 20),
              height: double.infinity,
              child: Icon(
                _customTileExpanded
                    ? Icons.arrow_drop_down_circle
                    : Icons.arrow_drop_down,
              ),
            ),
            onExpansionChanged: (bool expanded) {
              setState(() => _customTileExpanded = expanded);
            },
          ),
        ),
        //location
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
              // color: CustomColors().primaryWhiteColor,
              borderRadius: BorderRadius.circular(30)),
          child: ListTile(
            title: GestureDetector(
              onTap: () {
                print('location');
                openMap(lat, lng);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // margin: EdgeInsets.only(left: 10),
                    width: scWidth * 0.17,
                    height: scHeight * 0.13,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/product_icon.png'),
                      ),
                    ),
                    child: Icon(
                      Icons.fmd_good_sharp,
                      color: kDarkBlue,
                      size: 35,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    // margin: EdgeInsets.only(left: 10),
                    // alignment: Alignment.center,
                    width: scWidth * 0.4,
                    child: Text(
                      LocaleKeys.our_location.tr(),
                      style: TextStyle(
                          color: kDarkBlue,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
  //---------------------


    Future<ContactUsResponseModel?> getContactUsInfo() async {
    Map<String, dynamic> headerMap = await getHeaderMap();

    ContactUsRepository contactUsRepository = ContactUsRepository(headerMap);

    ApiResponse apiResponse = await contactUsRepository.getContactInfo();
    if (apiResponse.apiStatus.code == ApiResponseType.OK.code)
      return ContactUsResponseModel.fromJson(apiResponse.result);
    else
      throw ExceptionHelper(apiResponse.message);
  }
}