import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

Widget noItemDesign(String txt, String imageUrl) {
  return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Lottie.asset(
              'assets/images/tree_anim.json',
              width: 230,
              height: 230,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 15,),
          SizedBox(height: 5,),
          errorText(txt),
        ],
      ));
}

Widget errorText(String txt){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(txt, style: TextStyle(
      color: kLogoGreen,
      fontSize: 15,
    ),),
  );

}
