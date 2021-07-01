import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/vip/order_history_bloc.dart';
import 'package:qfvpn/widget/selector_widget_button.dart';

import '../../r.dart';
import '../../s.dart';

class OrderHistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderHistoryBloc, OrderHistoryState>(
      listener: (context, state) {},
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
    var isEmpty = false;
    return BlocListener<OrderHistoryBloc, OrderHistoryState>(
      listener: (context, state) {},
      child: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
        builder: (context, state) {
          return isEmpty ? Align(
            alignment: Alignment(0.0, -0.7),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(image: R.image.img_empty()),
                Text(
                  S.of(context).order_history_empty,
                  style: TextStyle(color: R.color.hint_color_light_bg()),
                )
              ],
            )) : ListView.separated(
              itemBuilder: (
                BuildContext context, int index) {
                return _buildItem(index);
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 10,
                  color: Colors.transparent,
                );
              },
              itemCount: 12);
        },
      ),
    );
  }

  Widget _buildItem(int index) {
    return BlocListener<OrderHistoryBloc, OrderHistoryState>(
        listener: (context, state) {},
        child: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(builder: (context, state) {
          var used = Random().nextInt(3); //for test
          var productName = "30天VIP";
          var orderNum = "订单号｜201603230733541980852590";
          var textColor = R.color.btn_white_color();
          var titleTextColor = R.color.btn_white_color();
          var paid_btn_color;
          var paidTitle;
          var status;
          var bg_color;

          if(used == 0) {
            status = "已关闭";
            titleTextColor = R.color.order_history_text_expiry();
            bg_color = R.color.order_history_statue_close();
            paid_btn_color = R.color.btn_blue_color();
          } else if(used == 1) {
            status = "已支付";
            paidTitle = "重新购买";
            titleTextColor = Colors.black;
            bg_color = R.color.order_history_statue_paid();
            paid_btn_color = R.color.order_history_repurchase();
          } else if(used == 2) {
            status = "待支付";
            paidTitle = "立即支付";
            titleTextColor = Colors.black;
            bg_color = R.color.order_history_statue_unpaid();
            paid_btn_color = R.color.order_history_paid_now();
          }

          return SizedBox(
            width: 328,
            height: 135,
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
                    padding: EdgeInsets.only(left: 20, top: 15),
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
                          orderNum,
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
                        margin: EdgeInsets.only(top: 17,bottom: 19),
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
                      used != 0 ? Container(
                        margin: EdgeInsets.only(right: 20,top: 13),
                        constraints: BoxConstraints.expand(width: 84, height: 30),
                        decoration: BoxDecoration(
                          color: paid_btn_color,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            style: ButtonStyle(
                              textStyle: MaterialStateProperty.all(TextStyle(fontSize: 14)),
                              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.only(left: 14, right: 14, top: 3, bottom: 5)),
                              splashFactory: NoSplash.splashFactory
                            ),
                            onPressed: (){
                              debugPrint("tttttt");
                            },
                            child: Text(
                              paidTitle,
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.normal),
                                textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ) : Container(),
                    ],
                  ),
                ],
              ),
            ),
          );
        }));
  }
}