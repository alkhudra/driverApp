import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:alkhudhrah_app/constants/api_const.dart';
import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:widget_mask/widget_mask.dart';

class ImageHelper {
  static productImage(String? imageUrl) {
    return imageUrl != null
        ? Image.memory(
      ImageHelper.convertBase64ToImage(imageUrl),
      errorBuilder: (BuildContext context, Object exception,
          StackTrace? stackTrace) {
        return Image.asset('assets/images/green_fruit.png');
      },
    )
        : Image.asset('assets/images/green_fruit.png');
  }

//---------------------

  static categoryImage(String? imageUrl) {
    return imageUrl != null
        ? WidgetMask(
      blendMode: BlendMode.srcATop,
      childSaveLayer: true,
      mask: Image.memory(
        ImageHelper.convertBase64ToImage(imageUrl),
        fit: BoxFit.cover,
        errorBuilder: (BuildContext context, Object exception,
            StackTrace? stackTrace) {
          return Image.asset('assets/images/green_fruit.png');
        },
      ),
      child: Image.asset(
        'assets/images/product_mask.png',
        width: 350,
      ),
    )
        : Image.asset('assets/images/green_fruit.png');
  }

//-----------------------

  static driverImage(context, String? imageUrl) {
    return imageUrl != null
        ? SizedBox(
      width: 70,
      height: 70,
      child: CircleAvatar(
        backgroundImage: MemoryImage(
          ImageHelper.convertBase64ToImage(imageUrl),
          //     errorBuilder: (BuildContext context, Object exception,
          //   StackTrace? stackTrace) {
          // return  driverIcon();
          //     },
        ),
      ),
    )
        : driverIcon();
  }

  //-------------------
  //-------------------

  static driverIcon() {
    return Icon(
      Icons.person_pin_rounded,
      color: kDarkGray.withOpacity(0.3),
      size: 55,
    );
  }

  //-------------------
  //-------------------

  static convertBase64ToImage(String img64) {
    final UriData? data = Uri.parse(img64).data;
    Uint8List myImage = data!=null ? data.contentAsBytes() :Uint8List(0);
    return myImage;
  }
}