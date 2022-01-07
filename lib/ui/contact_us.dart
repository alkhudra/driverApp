import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/custom_widgets/brandname.dart';
import 'package:alkhudhrah_app/designs/drawer_design.dart';
import 'package:alkhudhrah_app/designs/textfield_design.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/ui/edit_profile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'contact_us.dart';
import 'language.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({ Key? key }) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

final TextEditingController ownNameController = TextEditingController();
final TextEditingController compNameController = TextEditingController();
final TextEditingController drvNameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kLogoGreen,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: true,
              // collapsedHeight: 200,
              title: Text(LocaleKeys.contact_us.tr(), style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 22
              ),),
              flexibleSpace: Stack(
                children: [
                  Positioned.fill(
                    left: 180,
                    child: Image.asset('assets/images/grapevector.png'),
                  ),
                ],
              ),
              expandedHeight: 160,
              elevation: 0.0,
              backgroundColor: kLogoGreen,
              iconTheme: IconThemeData(color: kWhite),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios), 
                color: kWhite,
                onPressed: () => Navigator.pop(context),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                // margin: EdgeInsets.only(top: 100),
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    // Container(
                    //   margin: EdgeInsets.only(right: 250, top: 30),
                    //   child: Text(LocaleKeys.contact_us.tr(), 
                    //   style: TextStyle(color: kDarkBlue, fontSize: 23, fontWeight: FontWeight.w700),),
                    // ),
                    SizedBox(height: 30,),
                    Container(
                      child: brandName(100.0, 100.0, 22.0),
                    ),
                    SizedBox(height: 50,),
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 65),
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/product_icon.png'),
                                ),
                              ),
                              child: Icon(Icons.phone, color: kBlack, size: 48,),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              margin: EdgeInsets.only(left: 55),
                              child: Text('+966554878942', style: TextStyle(
                                color: kBlack,
                                fontWeight: FontWeight.w600
                              ),),
                            ),
                          ],
                        ),
                        SizedBox(width: 35,),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 30),
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/product_icon.png'),
                                ),
                              ),
                              child: Icon(Icons.mail_outline, color: kBlack, size: 48,),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              margin: EdgeInsets.only(left: 30),
                              child: Text('ALKhadra@gmail.com', style: TextStyle(
                                color: kBlack,
                                fontWeight: FontWeight.w600
                              ),),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 50,),
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 65),
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/product_icon.png'),
                                ),
                              ),
                              child: Icon(Icons.sms_outlined, color: kBlack, size: 48,),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              margin: EdgeInsets.only(left: 55),
                              child: Text('+966554878942', style: TextStyle(
                                color: kBlack,
                                fontWeight: FontWeight.w600
                              ),),
                            ),
                          ],
                        ),
                        SizedBox(width: 35,),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 60),
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/product_icon.png'),
                                ),
                              ),
                              child: Icon(Icons.fmd_good_sharp, color: kBlack, size: 48,),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              margin: EdgeInsets.only(left: 60),
                              child: Text('Our Location', style: TextStyle(
                                color: kBlack,
                                fontWeight: FontWeight.w600
                              ),),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        endDrawer: drawerDesign(context),
      ),
    );
  }
}