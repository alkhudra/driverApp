import 'package:alkhudhrah_app/constants/cont.dart';
import 'package:alkhudhrah_app/designs/appbar_design.dart';
import 'package:alkhudhrah_app/designs/no_item_design.dart';
import 'package:alkhudhrah_app/ui/companies/order_tile_design.dart';
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
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CompanyOrderHistory extends StatefulWidget {
  const CompanyOrderHistory({Key? key}) : super(key: key);

  @override
  State<CompanyOrderHistory> createState() => _CompanyOrderHistoryState();
}

class _CompanyOrderHistoryState extends State<CompanyOrderHistory> {
  TextEditingController srController = TextEditingController();

  final PagingController<int, OrderHeader> _pagingController =
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
      body: FutureBuilder<GetOrdersResponseModel>(
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

  pageDesign(BuildContext context, GetOrdersResponseModel model) {
    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;
    _pagingController.value.itemList!
        .removeWhere((element) => element.orderStatus != delivered);

    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: _pagingController.value.itemList!.isNotEmpty
                ? PagedListView<int, OrderHeader>(
                    pagingController: _pagingController,
                    shrinkWrap: true,
                    //   physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 12),

                    builderDelegate: PagedChildBuilderDelegate<OrderHeader>(
                        itemBuilder: (context, item, index) =>
                            orderTileDesign(context,company, item, scWidth, scHeight)),
                  )
                //   controller: _controller,

                : noItemDesign(
                    LocaleKeys.no_finished_orders.tr(), 'images/not_found.png'),
          ),

          //  SizedBox(height: 32,),
        ],
      ),
    );
  }
//---------------------

  //--------------------------
  Future<GetOrdersResponseModel> getListData(pageNumber) async {
    Map<String, dynamic> headerMap = await getHeaderMap();

    OrderRepository orderRepository = OrderRepository(headerMap);

    ApiResponse apiResponse =
        await orderRepository.getOrders(pageNumber, Consts.pageSize);

    if (apiResponse.apiStatus.code == ApiResponseType.OK.code) {
      GetOrdersResponseModel? responseModel =
          GetOrdersResponseModel.fromJson(apiResponse.result);

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
