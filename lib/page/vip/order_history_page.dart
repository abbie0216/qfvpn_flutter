import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:qfvpn/bloc/vip/order_history_bloc.dart';
import 'package:qfvpn/model/api/bean/order/orders_list_resp.dart';
import 'package:qfvpn/widget/selector_widget_button.dart';

import '../../constants.dart';
import '../../r.dart';
import '../../s.dart';
import 'order_history_detail_page.dart';

class OrderHistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  late OrderHistoryBloc _orderHistoryBloc;

  var _pageKey;
  final PagingController<int, OrderItem> _pagingController =
  PagingController(firstPageKey: 1);


  @override
  void initState() {
    super.initState();
    _orderHistoryBloc = BlocProvider.of<OrderHistoryBloc>(context);
    _pagingController.addPageRequestListener((pageKey) { 
      _pageKey = pageKey;
      _orderHistoryBloc.add(FetchOrdersListEvent(_pageKey));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderHistoryBloc, OrderHistoryState>(
      listener: (context, state) {
        if (state is LoadedState) {
          var newItems = state.result.items;
          final isLastPage = newItems.length < PAGE_SIZE;
          if (isLastPage) {
            _pagingController.appendLastPage(newItems);
          } else {
            final nextPageKey = ++_pageKey;
            _pagingController.appendPage(newItems, nextPageKey);
          }
        }
      },
      child: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
        builder: (context, state) {
          return Theme(
              data: ThemeData(primaryColor: R.color.share_app_bar_bg()),
              child: Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    leading: SelectorWidgetButton(
                      widgetN: Image(image: R.image.btn_back_n()),
                      widgetP: Image(image: R.image.btn_back_p()),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    backgroundColor: R.color.background_color(),
                    centerTitle: true,
                    title: Text(S.of(context).order_history_title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  ),
                backgroundColor: R.color.order_history_bg_color(),
                body: _buildContentView(),
              ),
          );
        },
      ),
    );
  }

  Widget _buildContentView() {
    return RefreshIndicator(
      onRefresh: () => Future.sync(
              () => _pagingController.refresh()
      ),
      child: PagedListView<int, OrderItem>.separated(
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<OrderItem>(
            itemBuilder: (context, item, index) =>
                _buildItem(context, item, index),
            noItemsFoundIndicatorBuilder: (_) =>
                _buildNoItemsFoundIndicator(),
            noMoreItemsIndicatorBuilder: (_) =>
                _buildNoMoreItemsIndicator(),
          ),
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              height: 10,
              color: Colors.transparent,
            );
          }
      ),
    );
  }

  Widget _buildItem(BuildContext context, OrderItem item, int index) {
    var used = item.status; //for test
    var productName = item.productName;
    var orderNum = item.orderNo;
    var textColor = R.color.btn_white_color();
    var titleTextColor = R.color.btn_white_color();
    var paid_btn_color;
    var paidTitle;
    var status;
    var bg_color;

    if(used == 1) {
      status = S.of(context).order_history_paid_unpaid;
      paidTitle = S.of(context).order_history_paid_now;
      titleTextColor = Colors.black;
      bg_color = R.color.order_history_statue_unpaid();
      paid_btn_color = R.color.order_history_paid_now();
    } else if(used == 2) {
      status = S.of(context).order_history_paid_paid;
      paidTitle = S.of(context).order_history_repurchase;
      titleTextColor = Colors.black;
      bg_color = R.color.order_history_statue_paid();
      paid_btn_color = R.color.order_history_repurchase();
    } else if(used == 3) {
      status = S.of(context).order_history_paid_close;
      titleTextColor = R.color.order_history_text_expiry();
      bg_color = R.color.order_history_statue_close();
      paid_btn_color = R.color.btn_blue_color();
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OrderHistoryDetailPage(orderNumber: orderNum)));
      },
      child: SizedBox(
        width: 328,
        height: 125,
        child: Card(
          elevation: 0,
          margin: EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(12.0))), //设置圆角
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    productName,
                    style: TextStyle(
                        color: titleTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )),
              Divider(
                height: 5,
                indent: 4,
                endIndent: 4,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Expanded(
                      child: Text(
                        S.of(context).order_history_number+orderNum,
                        style: TextStyle(
                            color: R.color.text_color_alpha40(),
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ))),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 8,bottom: 19),
                      constraints: BoxConstraints.expand(width: 60, height: 21),
                      decoration: BoxDecoration(
                        color: bg_color,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                      ),
                      child: Align(
                        alignment: Alignment(0.2, -0.6),
                        child: Text(
                          status,
                          style: TextStyle(
                              color: textColor,
                              fontSize: 12,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                      )
                  ),
                  used != 3 ? Container(
                    margin: EdgeInsets.only(right: 20,top: 11, bottom: 14),
                    constraints: BoxConstraints.expand(width: 84, height: 30),
                    decoration: BoxDecoration(
                      color: paid_btn_color,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: TextButton(
                      style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(TextStyle(fontSize: 14)),
                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.only(left: 14, right: 14, top: 3, bottom: 5)),
                          splashFactory: NoSplash.splashFactory
                      ),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OrderHistoryDetailPage(orderNumber: orderNum)));
                      },
                      child: Text(
                        paidTitle,
                        style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ) : Container(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoItemsFoundIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 60),
        Image(image: R.image.img_empty()),
        SizedBox(height: 10),
        Text(
          S.of(context).order_history_empty,
          style: TextStyle(color: R.color.text_color_alpha30(), fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildNoMoreItemsIndicator() {
    return Padding(
      padding: EdgeInsets.only(top: 40, bottom: 20),
      child: Center(
        child: Text(
          S.of(context).feedback_list_end,
          style: TextStyle(color: R.color.text_color_alpha30(), fontSize: 12),
        ),
      ),
    );
  }
}