import 'package:alkhudhrah_app/constants/cont.dart';
import 'package:alkhudhrah_app/designs/appbar_design.dart';
import 'package:alkhudhrah_app/designs/drawer_design.dart';
import 'package:alkhudhrah_app/designs/no_item_design.dart';
import 'package:alkhudhrah_app/designs/order_tile_design.dart';
import 'package:alkhudhrah_app/helper/custom_btn.dart';
import 'package:alkhudhrah_app/helper/shared_pref_helper.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/network/API/api_response.dart';
import 'package:alkhudhrah_app/network/API/api_response_type.dart';
import 'package:alkhudhrah_app/network/helper/exception_helper.dart';
import 'package:alkhudhrah_app/network/helper/network_helper.dart';
import 'package:alkhudhrah_app/network/models/driver_user.dart';
import 'package:alkhudhrah_app/network/models/orders/get_orders_response_model.dart';
import 'package:alkhudhrah_app/network/models/orders/order_header.dart';
import 'package:alkhudhrah_app/network/repository/order_repository.dart';
import 'package:alkhudhrah_app/ui/order_history.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  //return loadmore button

  int pageNumber = 1;
  int pageSize = listItemsCount;
  bool isThereMoreItems = false;
  List<OrderHeader> orderList = [];
 static String name = '', email = '', image = '';
  final ScrollController _controller = ScrollController();

  void _scrollListener() {
    print('listener');
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      loadMoreInfo();
    }
  }

  //------------------------
  void setValues() async {
    DriverUser user = await PreferencesHelper.getUser;
    //  image = user.image!;

    name = user.driverName != null ? user.driverName! : "";
    email = user.email != null ? user.email! : "";
    image = user.image != null ? user.image! : "";

    print('Driver Name:' + name);
    print('Driver Email:' + email);
    print('Driver Image:' + image);
  }

  @override
  void initState() {
    super.initState();
    setValues();
    _controller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: drawerDesign(context, name, email, image),
      body: FutureBuilder<GetOrdersResponseModel>(
        future: getListData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return pageDesign(context, snapshot.data!);
          } else
            return errorCase(snapshot);
        },
      ),
      appBar: appBarWithActions(context, LocaleKeys.orders.tr(), () {
        //display order history
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OrderHistory()));
      }),
    );
  }
//---------------------

  pageDesign(BuildContext context, GetOrdersResponseModel model) {
    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    print(orderList.length);
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: orderList.length > 0
                ? ListView.builder(
                    controller: _controller,
                    itemBuilder: ((context, index) {
                      if (isThereMoreItems == true) {
                        if (index == orderList.length - 1) {
                          return Center(
                            child:
                                CircularProgressIndicator(), //value.getLoadMoreDataStatus == true ? CircularProgressIndicator():null,
                          );
                        }
                      }
                      return orderTileDesign(
                          context, orderList[index], scWidth, scHeight);
                    }),
                    itemCount: orderList.length,
                  )
                : noItemDesign(
                    LocaleKeys.no_current_orders.tr(), 'images/not_found.png'),
          ),

          if (isThereMoreItems == true)
            loadMoreBtn(context, loadMoreInfo, 0, 0),
          //  SizedBox(height: 32,),
        ],
      ),
    );
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
        await orderRepository.getOrders(pageNumber, pageSize);

    if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
      GetOrdersResponseModel? responseModel =
          GetOrdersResponseModel.fromJson(apiResponse.result);

      print('Order List from DB: ' + responseModel.orderList.toString());
      if (pageNumber == 1)
        orderList = responseModel.orderList;
      else
        orderList.addAll(responseModel.orderList);

      //show only current and under processing orders
      orderList.removeWhere((element) => element.orderStatus == delivered);

      if (responseModel.orderList.length > 0) {
        if (responseModel.orderList.length < listItemsCount) {
          isThereMoreItems = false;
          pageNumber = 1;
        } else {
          isThereMoreItems = true;
          pageNumber += 1;
        }
      } else {
        isThereMoreItems = false;

        pageNumber = 1;
      }
      print('loadmore is $isThereMoreItems');
      //-----------------------------------
      return responseModel;
    } else {
      throw ExceptionHelper(apiResponse.message);
    }
  }
}
