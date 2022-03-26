import 'package:flutter/material.dart';
import 'package:alkhudhrah_app/constants/api_const.dart';
import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:widget_mask/widget_mask.dart';

class ImageHelper {

  static productImage(String? imageUrl) {
    return imageUrl != null
        ? Image.network(
      ApiConst.dashboard_url + imageUrl,
      errorBuilder: (BuildContext context, Object exception,
          StackTrace? stackTrace) {
        return Image.asset('images/green_fruit.png');
      },
    )
        : Image.asset('images/green_fruit.png');
  }

//---------------------

  static categoryImage(String? imageUrl) {
    return imageUrl != null
        ? WidgetMask(
      blendMode: BlendMode.srcATop,
      childSaveLayer: true,
      mask: Image.network(ApiConst.dashboard_url + imageUrl, fit: BoxFit.cover,
        errorBuilder: (BuildContext context, Object exception,
            StackTrace? stackTrace) {
          return Image.asset('images/green_fruit.png');
        },
      ),
      child: Image.asset('images/product_mask.png', width: 350,),
    )
        : Image.asset('images/green_fruit.png');
  }

//-----------------------

  static driverImage(String? imageUrl) {
    return imageUrl != null
        ? Image.network(
      ApiConst.dashboard_url + imageUrl,
      errorBuilder: (BuildContext context, Object exception,
          StackTrace? stackTrace) {
        return  driverIcon();
      },
    )
        :   driverIcon();
  }

//-----------------------

 static driverIcon(){
    return   Container(
      child: Icon(
        Icons.person_pin_rounded,
        color: kDarkGray
            .withOpacity(0.3),
        size: 55,
      ),
    );
  }
  
}