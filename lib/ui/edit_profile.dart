import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/designs/drawer_design.dart';
import 'package:alkhudhrah_app/designs/textfield_design.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'contact_us.dart';
import 'language.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({ Key? key }) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

final TextEditingController ownNameController = TextEditingController();
final TextEditingController compNameController = TextEditingController();
final TextEditingController drvNameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: true,
              // collapsedHeight: 200,
              title: Text(LocaleKeys.edit_profile_title.tr(), style: TextStyle(
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
                color: kWhite,
                child: Column(
                  children: [
                    TextFieldDesign.textFieldStyle(
                      context: context,
                      verMarg: 30,
                      horMarg: 20,
                      kbType: TextInputType.name,
                      lbTxt: LocaleKeys.drv_name.tr(),
                    ),
                    TextFieldDesign.textFieldStyle(
                      context: context,
                      verMarg: 0,
                      horMarg: 20,
                      kbType: TextInputType.name,
                      lbTxt: LocaleKeys.owner_name.tr(),
                    ),
                    TextFieldDesign.textFieldStyle(
                      context: context,
                      verMarg: 30,
                      horMarg: 20,
                      kbType: TextInputType.name,
                      lbTxt: LocaleKeys.comp_name.tr(),
                    ),
                    TextFieldDesign.textFieldStyle(
                      context: context,
                      verMarg: 0,
                      horMarg: 20,
                      kbType: TextInputType.name,
                      lbTxt: LocaleKeys.change_email.tr(),
                    ),
                    TextFieldDesign.textFieldStyle(
                      context: context,
                      verMarg: 30,
                      horMarg: 20,
                      kbType: TextInputType.name,
                      lbTxt: LocaleKeys.change_phone.tr(),
                    ),
                    SizedBox(height: 50,),
                    Container(
                      // margin: EdgeInsets.fromLTRB(80, 470, 80, 310),
                      width: MediaQuery.of(context).size.width/1.15,
                      height: MediaQuery.of(context).size.height/15,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60),
                          ),
                          fixedSize: Size(250.0, 70.0),
                          backgroundColor: kLogoGreen,
                        ),
                        onPressed:() {
                          //disable button after first click, to avoid 
                          // sending two requests to DB
                        },
                        child: Text(LocaleKeys.save_changes.tr(), style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),),
                      ),
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