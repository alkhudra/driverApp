import 'package:alkhudhrah_app/constants/cont.dart';
import 'package:alkhudhrah_app/designs/appbar_design.dart';
import 'package:alkhudhrah_app/designs/no_item_design.dart';
import 'package:alkhudhrah_app/designs/order_tile_design.dart';
import 'package:alkhudhrah_app/helper/custom_btn.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/network/API/api_response.dart';
import 'package:alkhudhrah_app/network/API/api_response_type.dart';
import 'package:alkhudhrah_app/network/helper/exception_helper.dart';
import 'package:alkhudhrah_app/network/helper/network_helper.dart';
import 'package:alkhudhrah_app/network/models/orders/get_orders_response_model.dart';
import 'package:alkhudhrah_app/network/models/orders/order_header.dart';
import 'package:alkhudhrah_app/network/repository/order_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({ Key? key }) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {

  int pageNumber = 1;
  int pageSize = listItemsCount;
  bool isThereMoreItems = false;
  List<OrderHeader> orderList = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDesign(context, LocaleKeys.order_history.tr()),
      body: FutureBuilder<GetOrdersResponseModel>(
        future: getListData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return pageDesign(context, snapshot.data!);
          } else
            return errorCase(snapshot);
        },
      ),
    );
  }

  //---------------------

  pageDesign(BuildContext context, GetOrdersResponseModel model) {
    List<OrderHeader> finishedOrder = [];
    for (OrderHeader orderItems in model.orderList) {
      if (orderItems.orderStatus == 'delivered') {
        print(orderItems.orderStatus);
        finishedOrder.add(orderItems);
      }
    }
    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    return Container(
      child: Column(
        children: [
          SizedBox(height: 10,),
          Expanded(
            child: orderList.length > 0
                ? ListView.builder(
              itemBuilder: ((context, index) {
                return orderTileDesign(
                    context, finishedOrder[index], scWidth, scHeight);
              }),
              itemCount: finishedOrder.length,
            )
                : noItemDesign(
                LocaleKeys.no_finished_orders.tr(), 'images/not_found.png'),
          ),

          if (isThereMoreItems == true)
            loadMoreBtn(context, loadMoreInfo, 0, 0),
         SizedBox(height: 32,),
        ],
      ),
    );
 /*   return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            height: 40,
            width: 320,
            decoration: BoxDecoration(
              // color: CustomColors().primaryWhiteColor,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: CustomColors().primaryGreenColor),
            ),
            child: TabBar(
              controller: _tabController,
              // give the indicator a decoration (color and border radius)
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: CustomColors().primaryGreenColor,
              ),
              labelColor: CustomColors().primaryWhiteColor,
              labelStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Almarai',
                  fontSize: 16),
              unselectedLabelColor: CustomColors().darkBlueColor,
              tabs: [
                // first tab [you can add an icon using the icon property]
                Tab(
                  text: LocaleKeys.current_orders.tr(),
                ),

                // second tab [you can add an icon using the icon property]
                Tab(
                  text: LocaleKeys.complete_orders.tr(),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // first tab bar view widget
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: currentOrder.length > 0
                    ? ListView.builder(
                        itemBuilder: ((context, index) {
                          return orderTileDesign(
                              context, currentOrder[index], scWidth, scHeight);
                        }),
                        itemCount: currentOrder.length,
                      )
                    : noItemDesign(
                        LocaleKeys.no_current_orders.tr(), 'images/not_found.png'),
              ),

              // second tab bar view widget
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: finishedOrder.length > 0
                    ? ListView.builder(
                        itemBuilder: ((context, index) {
                          return orderTileDesign(
                              context, finishedOrder[index], scWidth, scHeight);
                        }),
                        itemCount: finishedOrder.length,
                      )
                    : noItemDesign(
                        LocaleKeys.no_finished_orders.tr(), 'images/not_found.png'),
              ),
            ],
          ),
        ),
      ],
    );*/
    
  }
//---------------------

  loadMoreInfo() async {
    setState(() {
      pageNumber++;
    });

  }
  //--------------------------
  Future<GetOrdersResponseModel> getListData() async {
    Map<String, dynamic> headerMap = await getHeaderMap();

    OrderRepository orderRepository = OrderRepository(headerMap);

    ApiResponse apiResponse =
        await orderRepository.getOrders(pageNumber, pageSize, '');

    if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
      GetOrdersResponseModel? responseModel =
          GetOrdersResponseModel.fromJson(apiResponse.result);

    //  orderList = responseModel.orderList;
      if (pageNumber == 1) orderList = responseModel.orderList;
      else  orderList.addAll(responseModel.orderList);

      if (responseModel.orderList.length > 0) {
        if (responseModel.orderList.length < listItemsCount) {
          isThereMoreItems = false;
        }else {
          isThereMoreItems = true;
        }

      }else{
        isThereMoreItems = false;
        pageNumber = 1;
      }
      //-----------------------------------
      return responseModel;
    } else {
      throw ExceptionHelper(apiResponse.message);
    }
  }
}