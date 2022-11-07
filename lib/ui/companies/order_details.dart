import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/custom_widgets/green_btn.dart';
import 'package:alkhudhrah_app/helper/cart_helper.dart';
import 'package:alkhudhrah_app/network/models/driver_user.dart';
import 'package:alkhudhrah_app/network/models/orders/branch_model.dart';
import 'package:alkhudhrah_app/ui/companies/order_delivered.dart';
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
                            fontWeight: FontWeight.w600),
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
    } else if (model.paymentType == credit) {
      print(model.paymentType);
      paymentText = LocaleKeys.postpaid.tr();
      paymentIcon = FontAwesomeIcons.receipt;
    } else {
      paymentText = LocaleKeys.transfer.tr();
      paymentIcon = FontAwesomeIcons.peopleArrows;
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
              branchInfoText(LocaleKeys.branch_name.tr(), branchName),
              SizedBox(height: 15,),
              branchInfoText(LocaleKeys.branch_address.tr(), branchAddress),
              SizedBox(height: 15,),
              branchInfoText(LocaleKeys.branch_phone.tr(), branchNo),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // margin: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(LocaleKeys.map_location.tr() + ' :', 
                      style: TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Almarai',
                        color: kDarkBlue
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
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    titleTextDesign(LocaleKeys.payment_method.tr()),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(

                      child: payButtonDesign(
                          context, paymentColor, paymentText, paymentIcon),
                      padding: EdgeInsets.symmetric(horizontal: 30),
                    ),
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
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
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
                  child: model.orderStatus == onDelivery ? greenBtn(LocaleKeys.delivery_completed.tr(), EdgeInsets.symmetric(horizontal: 30, vertical: 15), () {
                    print(model.orderCheckCode);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDelivered(model: model,)));
                  }) : SizedBox(height: 30,),
                ),
              ],
            ),
          ),
          model.orderStatus == onDelivery?
          SizedBox(
            height: 160,
          ): SizedBox(height: 10,),
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

  branchInfoText(title, info) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: Text(title, 
              style: TextStyle(
                fontSize: 15.4,
                fontWeight: FontWeight.w600,
                fontFamily: 'Almarai',
                color: kDarkBlue
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 45),
            child: Text(info, 
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Almarai',
                color: kLogoGreen
              ),
            ),
          ),
        ],
      ),
    );
  }
}