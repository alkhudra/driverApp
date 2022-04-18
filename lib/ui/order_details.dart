import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/custom_widgets/green_btn.dart';
import 'package:alkhudhrah_app/helper/cart_helper.dart';
import 'package:alkhudhrah_app/helper/route_helper.dart';
import 'package:alkhudhrah_app/network/models/driver_user.dart';
import 'package:alkhudhrah_app/network/models/orders/branch_model.dart';
import 'package:alkhudhrah_app/router/route_constants.dart';
import 'package:alkhudhrah_app/ui/order_delivered.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:alkhudhrah_app/constants/cont.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/designs/appbar_design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:alkhudhrah_app/helper/contact_helper.dart';
import 'package:alkhudhrah_app/helper/image_helper.dart';
import 'package:alkhudhrah_app/helper/order_helper.dart';
import 'package:alkhudhrah_app/network/models/orders/order_header.dart';
import 'package:alkhudhrah_app/network/models/orders/order_items.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


class OrderDetails extends StatefulWidget {
  final OrderHeader orderModel;
  final String language;
  const OrderDetails(
      {Key? key, required this.orderModel, required this.language})
      : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  static String productId = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double scHeight = size.height;

    OrderHeader model = widget.orderModel;
    DriverUser driverUser = DriverUser();
    if (widget.orderModel.driverUser != null)
      driverUser = widget.orderModel.driverUser!;
    BranchModel? branch = model.branchModel;
    String? branchNo = branch!.phoneNumber;
    return Scaffold(
      appBar: appBarDesign(context, LocaleKeys.order_details.tr()),
      body: model.orderStatus == onDelivery
          ? SlidingUpPanel(
              body: pageContent(model),
              minHeight: scHeight * 0.07,
              maxHeight: 160,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              panel: Container(
                height: MediaQuery.of(context).size.height * 0.14,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                          child: Text(
                            LocaleKeys.contact_client.tr(),
                            style: TextStyle(
                                color:
                                    kLogoBrown.withOpacity(0.8),
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //client name
                                Container(
                                  child: Text(
                                    model.companyName != null
                                        ? model.companyName!
                                        : '',
                                        overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        color: kDarkBlue,
                                        fontSize: 17.5,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                //client number
                                Container(
                                  child: Text(
                                    branchNo != null
                                        ? branchNo
                                        : '',
                                    style: TextStyle(
                                        color: kDarkGray
                                            .withOpacity(0.8),
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        //Call client button
                        Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                color: kLogoGreen),
                            child: TextButton(
                              child: Icon(
                                FontAwesomeIcons.phone,
                                color: kWhite,
                                size: 24,
                              ),
                              onPressed: () {
                                directToPhoneCall(driverUser.phoneNumber != null
                                    ? driverUser.phoneNumber!
                                    : '');
                              },
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            )
          : pageContent(model),
    );
  }
//-------------list tile----------------

  Widget orderItem(OrderItems item, scHeight) {
    num? productPrice = item.orderedProductPrice;
    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: scHeight * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 75,
                  height: 75,
                  child: ImageHelper.productImage(item.product!.image),
                ),
                //category, name and price
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        widget.language == "ar"
                            ? item.product!.arName!
                            : item.product!.name!,
                        style: TextStyle(
                            color: kDarkBlue,
                            fontWeight: FontWeight.w400),
                      ),
                    ),

                    // price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            getTextWithCurrency(productPrice!),
                            style: TextStyle(
                                color: kLogoGreen,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          child: Text(
                            '   × ' + item.userProductQuantity.toString(),
                            style: TextStyle(
                                color: kLogoGreen,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          width: scHeight * 0.08,
                        ),
                        Container(
                          child: Text(
                            getTextWithCurrency(item.totalProductPrice!),
                            style: TextStyle(
                                color: kLogoGreen,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

//---------------------------------

  pageContent(OrderHeader model) {
    num? priceAfterDiscount = model.totalDiscount;
    num? subtotal = model.totalOrderPrice;
    num? vat = model.totalOrderVAT15;
    num? total = model.totalNetOrderPrice;
    num? discount = model.discountPercentage;
    bool? hasDiscount = model.hasDiscount;

    //------ date
    String orderDate = '';
    if (model.orderStatus == underProcess) {
      orderDate = model.orderInitializedDate!;
    } else if (model.orderStatus == onDelivery) {
      orderDate = model.onDeliveryStatusDate!;
    } else {
      orderDate = model.deliveredStatusDate!;
    }
    //----- payment
    Color paymentColor = kLogoGreen;
    String paymentText = '';
    IconData paymentIcon = FontAwesomeIcons.moneyBillWave;

    if (model.paymentType == visa) {
      print(model.paymentType);
      paymentText = LocaleKeys.credit_card.tr();
      paymentIcon = FontAwesomeIcons.solidCreditCard;
    } else if (model.paymentType == cash) {
      print(model.paymentType);
      paymentText = LocaleKeys.cash.tr();
      paymentIcon = FontAwesomeIcons.moneyBillWave;
    } else if (model.paymentType == applePay) {
      print(model.paymentType);
      paymentText = LocaleKeys.apple_pay.tr();
      paymentIcon = FontAwesomeIcons.applePay;
    } else if (model.paymentType == stcPay) {
      print(model.paymentType);
      paymentText = LocaleKeys.stc_pay.tr();
      //todo:edit stc pay icon
      paymentIcon = FontAwesomeIcons.gratipay;
    } else {
      print(model.paymentType);
      paymentText = LocaleKeys.postpaid.tr();
      paymentIcon = FontAwesomeIcons.receipt;
    }

    //--------
    int listItemsNumber = model.orderItems!.length;

    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;
    BranchModel? branch = model.branchModel;

    String? branchName = branch!.branchName;
    String? branchAddress = branch.address;
    String? branchNo = branch.phoneNumber;
    num? branchLong = branch.longitude;
    num? branchLat = branch.latitude;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          //branch info: phone no, address, map btn(lat, long)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 3),
                child: Row(
                  children: [
                    titleTextDesign(LocaleKeys.order_branch_info.tr()),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              //branch name
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Almarai',
                      color: kLogoGreen,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: LocaleKeys.branch_name.tr() + ': ',
                          style: TextStyle(color: kDarkBlue)),
                      TextSpan(
                          text: branchName,
                          style: TextStyle(
                            color: kLogoGreen,
                            fontFamily: 'Almarai',
                          )),
                    ]),
                ),
              ),
              SizedBox(height: 15,),
              //branch address
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Almarai',
                      color: kLogoGreen,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: LocaleKeys.branch_address.tr() + ': ',
                          style: TextStyle(color: kDarkBlue)),
                      TextSpan(
                          text: branchAddress,
                          style: TextStyle(
                            color: kLogoGreen,
                            fontFamily: 'Almarai',
                          )),
                    ]),
                ),
              ),
              SizedBox(height: 15,),
              //branch phone number
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Almarai',
                      color: kLogoGreen,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: LocaleKeys.branch_phone.tr() + ': ',
                          style: TextStyle(color: kDarkBlue)),
                      TextSpan(
                          text: branchNo,
                          style: TextStyle(
                            color: kLogoGreen,
                            fontFamily: 'Almarai',
                          )),
                    ]),
                ),
              ),
              // SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // margin: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(LocaleKeys.map_location.tr() + ' :', 
                      style: TextStyle(
                        fontSize: 16
                      ),),
                    ),
                    Container(
                      width: scWidth * 0.13,
                      height: scHeight * 0.06,
                      decoration: BoxDecoration(
                        color: kLogoGreen,
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: TextButton(
                        child: Icon(FontAwesomeIcons.mapMarkedAlt, color: kWhite,),
                        // Text('Location', style: TextStyle(
                        //   color: kWhite
                        // ),),
                        onPressed: () {
                          openMap(branchLat!, branchLong!);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          //deleted tracking tile
          Row(
            children: [
              titleTextDesign(LocaleKeys.products_in_order.tr()),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          //order summary
          Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5),
                  width: scWidth * 0.84,
                  height: scHeight * 0.11,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(55),
                      bottomRight: Radius.circular(55),
                    ),
                    border: Border.all(
                      color: kLogoGreen,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        child: Container(
                          width: 5,
                          height: scHeight * 0.12,
                          color: kLogoGreen,
                        ),
                      ),
                      Positioned(
                        left: 0,
                        child: Container(
                          width: scWidth * 0.2,
                          height: scHeight * 0.17,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                    AssetImage('assets/images/ic_fruit_green.png'))),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                //Order no
                                child: Text(
                                  '#' + model.invoiceNumber.toString(),
                                  style: TextStyle(
                                    color: kLogoGreen,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                //Order Date
                                child: Text(
                                  orderDate,
                                  style: TextStyle(
                                    color: kLogoGreen,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            //replace text by notification
                            margin: EdgeInsets.symmetric(
                                horizontal: scWidth * 0.12),
                            child: Text(
                              '($listItemsNumber) ' + LocaleKeys.items.tr(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: kDarkBlue),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          //ordered products title
          // Row(
          //   children: [
          //     titleTextDesign(LocaleKeys.products_in_order.tr()),
          //   ],
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          //list of ordered products
          LimitedBox(
            maxHeight: scHeight * 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return orderItem(model.orderItems![index], scHeight);
                    },
                    itemCount: listItemsNumber,
                    shrinkWrap: true,
                    // dragStartBehavior: DragStartBehavior.down,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                ),
              ],
            ),
          ),
          //payment method
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(
                //   height: 5,
                // ),
                Row(
                  children: [
                    titleTextDesign(LocaleKeys.payment_method.tr()),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                //TODO: show payment method?
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(

                      child: payButtonDesign(
                          context, paymentColor, paymentText, paymentIcon),
                      padding: EdgeInsets.symmetric(horizontal: 30),
                    ),
                    // if (model.paymentType == credit)
                      // greenBtn(
                      //     LocaleKeys.pay_now.tr(),
                      //     EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      //     () {

                      //       //todo: show payment page

                      //     })
                  ],
                ),

                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          //order details
          Container(
            //  height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    titleTextDesign(LocaleKeys.order_details.tr()),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    cartDetailsItem(LocaleKeys.subtotal.tr(),
                        getTextWithCurrency(subtotal!)),
                    cartDetailsItem(
                        LocaleKeys.vat.tr(), getTextWithCurrency(vat!)),
                    if (hasDiscount!)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          cartDetailsItem(LocaleKeys.discount_percentage.tr(),
                              getTextWithPercentage(discount!)),
                          cartDetailsItem(LocaleKeys.discount.tr(),
                              getTextWithCurrency(priceAfterDiscount!)),
                        ],
                      )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //total
                      cartTotalDesign(total!),
                      //Receipt download button
                      InkWell(
                        child: Container(
                            width: 50,
                            height: 50,
                            child: Image.asset('assets/images/ic_file_pdf.png')),
                        onTap: () {
                          print(widget.orderModel.invoicePDFPath!);
                          print(widget.orderModel.hasOrderCreatedFromDashboard!);
                          OrderHelper.displayInvoice(
                              widget.orderModel.invoicePDFPath!,
                              widget.orderModel.hasOrderCreatedFromDashboard!);
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  child: greenBtn(LocaleKeys.delivery_completed.tr(), EdgeInsets.symmetric(horizontal: 30, vertical: 15), () {
                    print(model.orderCheckCode);
                    moveToNewStackWithArgs(context, MaterialPageRoute(builder: (context) {
                      return OrderDelivered(model: model,);
                    }));
                  }),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 160,
          ),
        ],
      ),
    );
  }

  titleTextDesign(text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        text,
        style: TextStyle(
            color: kLogoBrown,
            fontWeight: FontWeight.w800,
            fontSize: 19),
      ),
    );
  }
}


















































// import 'dart:ui';

// import 'package:alkhudhrah_app/constants/colors.dart';
// import 'package:alkhudhrah_app/designs/bottom_nav_bar.dart';
// import 'package:alkhudhrah_app/designs/drawer_design.dart';
// import 'package:alkhudhrah_app/designs/order_details_design.dart';
// import 'package:alkhudhrah_app/designs/textfield_design.dart';
// import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
// import 'package:alkhudhrah_app/ui/home.dart';
// import 'package:alkhudhrah_app/ui/my_orders.dart';
// import 'package:alkhudhrah_app/ui/notifications.dart';
// import 'package:alkhudhrah_app/ui/wallet.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';

// import 'contact_us.dart';
// import 'edit_profile.dart';
// import 'language_setting.dart';

// class OrderDetails extends StatefulWidget {
//   const OrderDetails({ Key? key }) : super(key: key);

//   @override
//   _OrderDetailsState createState() => _OrderDetailsState();
// }

// class _OrderDetailsState extends State<OrderDetails> {

//   double subTotal = 0.0;
//   double vat = 0.0;
//   double total = 0.0;


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             centerTitle: true,
//             // collapsedHeight: 200,
//             title: Text(LocaleKeys.order_details.tr(), style: TextStyle(
//               fontWeight: FontWeight.w700,
//               fontSize: 22
//             ),),
//             flexibleSpace: Stack(
//               children: [
//                 Positioned.fill(
//                   left: 180,
//                   child: Image.asset('assets/images/grapevector.png'),
//                 ),
//               ],
//             ),
//             expandedHeight: 160,
//             elevation: 0.0,
//             backgroundColor: kLogoGreen,
//             iconTheme: IconThemeData(color: kWhite),
//             leading: IconButton(
//               icon: Icon(Icons.arrow_back_ios), 
//               color: kWhite,
//               onPressed: () => Navigator.pop(context),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Container(
//               // margin: EdgeInsets.only(top: 100),
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               color: kWhite,
//               child: Column(
//                 children: [
//                   Stack(
//                     children: [
//                       //Add order detail container
//                       Container(
//                         margin: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
//                         alignment: Alignment.center,
//                         width: 400,
//                         height: 100,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30),
//                           gradient: LinearGradient(
//                             colors: [
//                               kLogoGreen,
//                               kLightGreen.withOpacity(0.7),
//                             ]
//                           ),
//                         ),
//                         child: Container(
//                           alignment: Alignment.bottomLeft,
//                           padding: EdgeInsets.only(left: 8, bottom: 8),
//                           child: Image.asset('assets/images/green_grape.png'),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
//                         alignment: Alignment.center,
//                         width: 300,
//                         height: 100,
//                         decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(30),
//                         ),
//                         child: Column(
//                           // mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                                   alignment: Alignment.center,
//                                   child: Text('Order Num', 
//                                   style: TextStyle(
//                                     color: kWhite,
//                                     fontWeight: FontWeight.w700,
//                                     fontSize: 20,
//                                   ),),
//                                 ),
//                                 SizedBox(width: 70,),
//                                   Container(
//                                     child: Text('17/11/2021', 
//                                     style: TextStyle(
//                                       color: kWhite,
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 15,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 10,),
//                             Container(
//                               padding: EdgeInsets.symmetric(horizontal: 15),
//                               child: Text('2 items', 
//                                 style: TextStyle(
//                                   color: kWhite,
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 19,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20,),
//                   orderDetailsDesign(context, LocaleKeys.fruits.tr().toUpperCase(), 'Banana', 21, 3),
//                   orderDetailsDesign(context, LocaleKeys.vegetables.tr().toUpperCase(), 'Broccoli', 15, 1),
//                   //space after orders
//                   SizedBox(height: MediaQuery.of(context).size.height*0.07,),
//                   Container(
//                     margin: EdgeInsets.symmetric(horizontal: 50),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           child: RichText(
//                             text: TextSpan(
//                               style: TextStyle(
//                                 fontSize: 17,
//                                 fontWeight: FontWeight.w600,
//                                 color: kLogoGreen,
//                               ),
//                               children: <TextSpan> [
//                                 TextSpan(text: LocaleKeys.subtotal.tr(),
//                                 style: TextStyle(
//                                   color: kBlack,
//                                 )),
//                                 TextSpan(text: ': 23.8 SAR',
//                                 style: TextStyle(
//                                   color: kLogoGreen,
//                                 )),
//                                 ]
//                               ),
//                             ),
//                           ),
//                         SizedBox(height: 10,),
//                         Container(
//                           child: RichText(
//                             text: TextSpan(
//                               style: TextStyle(
//                                 fontSize: 17,
//                                 fontWeight: FontWeight.w600,
//                                 color: kLogoGreen,
//                               ),
//                               children: <TextSpan> [
//                                 TextSpan(text: LocaleKeys.vat.tr(),
//                                 style: TextStyle(
//                                   color: kBlack,
//                                 )),
//                                 TextSpan(text: ': 4.05 SAR',
//                                 style: TextStyle(
//                                   color: kLogoGreen,
//                                 )),
//                                 ]
//                               ),
//                             ),
//                           ),
//                         SizedBox(height: 10,),
//                         Divider(
//                           thickness: 1,
//                           color: kGray,
//                         ),
//                         Container(
//                           child: RichText(
//                             text: TextSpan(
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                               children: <TextSpan> [
//                                 TextSpan(text: LocaleKeys.total.tr(),
//                                 style: TextStyle(
//                                   color: kLogoGreen,
//                                 )),
//                                 TextSpan(text: ': 27.85 SAR',
//                                 style: TextStyle(
//                                   color: kLogoGreen,
//                                 )),
//                                 ]
//                               ),
//                             ),
//                           ),
//                         SizedBox(height: 10,),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       endDrawer: drawerDesign(context),
//     );
//   }
// }