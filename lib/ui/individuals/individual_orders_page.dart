import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:alkhudhrah_app/constants/api_const.dart';
import 'package:alkhudhrah_app/constants/cont.dart';
import 'package:alkhudhrah_app/designs/appbar_design.dart';
import 'package:alkhudhrah_app/designs/drawer_design.dart';
import 'package:alkhudhrah_app/designs/no_item_design.dart';
import 'package:alkhudhrah_app/ui/companies/order_tile_design.dart';
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
import 'package:alkhudhrah_app/ui/companies/company_order_history.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../network/models/orders/OrderHeaderIndividual.dart';
import '../../network/models/orders/get_order_individaul_response.dart';

class IndividualOrdersPage extends StatefulWidget {
  const IndividualOrdersPage({Key? key}) : super(key: key);

  @override
  State<IndividualOrdersPage> createState() => _IndividualOrdersPageState();
}

class _IndividualOrdersPageState extends State<IndividualOrdersPage> {
  TextEditingController srController = TextEditingController();

  final PagingController<int, OrderHeaderIndividual> _pagingController =
      PagingController(firstPageKey: 1);
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      getListData(pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<GetOrdersIndividualResponseModel>(
        future: getListData(_pagingController.firstPageKey),
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

  pageDesign(BuildContext context, GetOrdersIndividualResponseModel model) {
    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;
    _pagingController.value.itemList!
        .removeWhere((element) => element.orderStatus == delivered);

    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: _pagingController.value.itemList!.isNotEmpty
                ? PagedListView<int, OrderHeaderIndividual>(
                    pagingController: _pagingController,
                    shrinkWrap: true,
                    //   physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 12),

                    builderDelegate: PagedChildBuilderDelegate<OrderHeaderIndividual>(
                        itemBuilder: (context, item, index) =>
                            orderTileDesign(context, individual,item, scWidth, scHeight)),
                  )
                //   controller: _controller,

                : noItemDesign(
                    LocaleKeys.no_current_orders.tr(), 'images/not_found.png'),
          ),

          //  SizedBox(height: 32,),
        ],
      ),
    );
  }
//---------------------

  //--------------------------
  Future<GetOrdersIndividualResponseModel> getListData(pageNumber) async {
    Map<String, dynamic> headerMap = await getHeaderMap();

    OrderRepository orderRepository = OrderRepository(headerMap);

    ApiResponse apiResponse =
        await orderRepository.getIndividualOrders(pageNumber, Consts.pageSize);

    print(apiResponse.result.toString());
    if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
      GetOrdersIndividualResponseModel? responseModel =
      GetOrdersIndividualResponseModel.fromJson(apiResponse.result);

      print('Order List from DB: ' + responseModel.orderList.toString());

      //show only current and under processing orders

      try {
        final isLastPage = responseModel.orderList.length < Consts.pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(responseModel.orderList);
        } else {
          final nextPageKey = pageNumber + responseModel.orderList.length;
          _pagingController.appendPage(responseModel.orderList, nextPageKey);
        }
      } catch (error) {
        _pagingController.error = error;
      }

      //-----------------------------------
      return responseModel;
    } else {
      throw ExceptionHelper(apiResponse.message);
    }
  }
}
