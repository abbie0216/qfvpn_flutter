import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:qfvpn/bloc/vip/order_history_detail_bloc.dart';
import 'package:qfvpn/widget/selector_widget_button.dart';
import 'package:sprintf/sprintf.dart';

import '../../r.dart';
import '../../s.dart';
import '../../utility/convert.dart';

enum PainState { UNPAID, PAID, CLOSED }

class OrderHistoryDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrderHistoryDetailPageState();
}

class _OrderHistoryDetailPageState extends State<OrderHistoryDetailPage>{
  final PainState _painState = PainState.UNPAID;
  static const PAY_WAY_NONE = -1;
  static const PAY_WAY_WX = 0;
  static const PAY_WAY_ALI = 1;
  int _selectedPayWay = PAY_WAY_NONE;

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderHistoryDetailBloc, OrderHistoryDetailState>(
      listener: (context, state) {},
      child: BlocBuilder<OrderHistoryDetailBloc, OrderHistoryDetailState>(
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
                title: Text(S.of(context).order_history_detail_title,
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
      )
    );
  }

  Widget _buildContentView() {
    return BlocListener<OrderHistoryDetailBloc, OrderHistoryDetailState>(
        listener: (context, state) {},
        child: BlocBuilder<OrderHistoryDetailBloc, OrderHistoryDetailState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _stateContentView(),
                _orderContentView("360天VIP", "201603230733541980852590"),
                _orderDetailContentView(),
                Spacer(),
                _buttonContentView(),
              ],
            );
          },
        )
    );
  }

  Widget _stateContentView() {
    var image;
    var bg;
    var title;
    var expiryDate;
    switch(_painState) {
      case PainState.CLOSED:
        image = R.image.ico_close();
        bg = R.color.order_history_text_expiry();
        title = S.of(context).order_history_detail_close_status;
        expiryDate = "";
        break;
      case PainState.PAID:
        image = R.image.ico_success();
        bg = R.color.order_history_statue_paid();
        title = S.of(context).order_history_detail_paid_status;
        expiryDate = "";
        break;
      case PainState.UNPAID:
        image = R.image.ico_deferment();
        bg = R.color.order_history_statue_unpaid();
        title = S.of(context).order_history_detail_unpaid_status;
        expiryDate = sprintf(S.of(context).order_history_detail_expiry_date, [dateTimeDisplay('2021-07-01T09:07:40.617Z')]);
        break;
    }
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 13),
      child: Stack(
        children: [
          Positioned(
            left: 12, top: 12, bottom: 12,
              child: Image(image: image,)),
          Positioned(
            left: 45, top: 11,
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal
              ),
          )),
          Positioned(
            right: 12, top: 11,
            child: Text(
              expiryDate,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal
              ),
          )),
        ],
      ),
    );
  }

  Widget _orderContentView(String productName, String orderNum) {
    return Container(
      width: double.infinity,
      height: 84,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 13),
      child: Stack(
        children: [
          Positioned(
              left: 20, top: 12,
              child: Text(
                productName,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )),
          Positioned(
              left: 2, top: 45, right: 2,
              child: Divider(
                height: 0,
                indent: 4,
                endIndent: 4,
              )),
          Positioned(
              left: 20, top: 53,
              child: Text(
                S.of(context).order_history_detail_number+orderNum,
                style: TextStyle(
                    color: R.color.text_color_alpha40(),
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              )),
          Positioned(
              top: 40, right: 0,
              child: SelectorWidgetButton(
                onPressed: () {
                  debugPrint(hashCode.toString());
                },
                widgetN: Image(image: R.image.btn_copy_n(),),
                widgetP: Image(image: R.image.btn_copy_p(),),
              )
          ),
        ],
      ),
    );
  }

  Widget _orderDetailContentView() {
    switch(_painState) {
      case PainState.CLOSED:
        return Container(
          width: double.infinity,
          height: 216,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          margin: EdgeInsets.only(left: 16, right: 16),
          child: _closeContentView(),
        );
      case PainState.PAID:
        return Container(
          width: double.infinity,
          height: 252,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          margin: EdgeInsets.only(left: 16, right: 16),
          child: _paidContentView(),
        );
      case PainState.UNPAID:
        return Container(
          width: double.infinity,
          height: 317,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          margin: EdgeInsets.only(left: 16, right: 16),
          child: _unpaidContentView(),
        );
    }
  }

  Widget _closeContentView() {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Text(
                "下单时间",
                style: TextStyle(
                    color: R.color.text_color_alpha30(),
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Text(
                "2021-03-20 20:01",
                style: TextStyle(
                    color: R.color.text_color_alpha50(),
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Text(
                "支付方式",
                style: TextStyle(
                    color: R.color.text_color_alpha30(),
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Text(
                "未选择",
                style: TextStyle(
                    color: R.color.text_color_alpha50(),
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Text(
                "原价",
                style: TextStyle(
                    color: R.color.text_color_alpha30(),
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Text(
                "¥288",
                style: TextStyle(
                    color: R.color.text_color_alpha50(),
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Text(
                "优惠信息",
                style: TextStyle(
                    color: R.color.text_color_alpha30(),
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Text(
                "- ¥35",
                style: TextStyle(
                    color: R.color.text_color_alpha50(),
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Divider(
            height: 0,
            indent: 4,
            endIndent: 4,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 190, top: 15),
          child: Text.rich(
            TextSpan(
                children: [
                  TextSpan(
                    text: "实付金额：",
                    style: TextStyle(
                        color: R.color.text_color_alpha50(),
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                  TextSpan(
                    text: "¥253",
                    style: TextStyle(
                        color: R.color.text_blue_color(),
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                ]
            ),
          ),
        ),
      ],
    );
  }

  Widget _paidContentView() {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Text(
                "下单时间",
                style: TextStyle(
                    color: R.color.text_color_alpha30(),
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Text(
                "2021-03-20 20:01",
                style: TextStyle(
                    color: R.color.text_color_alpha50(),
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Text(
                "支付时间",
                style: TextStyle(
                    color: R.color.text_color_alpha30(),
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Text(
                "2021-03-20 20:01",
                style: TextStyle(
                    color: R.color.text_color_alpha50(),
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Text(
                "支付方式",
                style: TextStyle(
                    color: R.color.text_color_alpha30(),
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Text(
                "支付宝",
                style: TextStyle(
                    color: R.color.text_color_alpha50(),
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Text(
                "原价",
                style: TextStyle(
                    color: R.color.text_color_alpha30(),
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Text(
                "¥288",
                style: TextStyle(
                    color: R.color.text_color_alpha50(),
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Text(
                "优惠信息",
                style: TextStyle(
                    color: R.color.text_color_alpha30(),
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Text(
                "- ¥35",
                style: TextStyle(
                    color: R.color.text_color_alpha50(),
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Divider(
            height: 0,
            indent: 4,
            endIndent: 4,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 190, top: 15),
          child: Text.rich(
            TextSpan(
                children: [
                  TextSpan(
                    text: "实付金额：",
                    style: TextStyle(
                        color: R.color.text_color_alpha50(),
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                  TextSpan(
                    text: "¥253",
                    style: TextStyle(
                        color: R.color.text_blue_color(),
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                ]
            ),
          ),
        ),
      ],
    );
  }

  Widget _unpaidContentView() {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Text(
                "下单时间",
                style: TextStyle(
                    color: R.color.text_color_alpha30(),
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Text(
                "2021-03-20 20:01",
                style: TextStyle(
                    color: R.color.text_color_alpha50(),
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Text(
                "原价",
                style: TextStyle(
                    color: R.color.text_color_alpha30(),
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Text(
                "¥288",
                style: TextStyle(
                    color: R.color.text_color_alpha50(),
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Text(
                "优惠信息",
                style: TextStyle(
                    color: R.color.text_color_alpha30(),
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Text(
                "- ¥35",
                style: TextStyle(
                    color: R.color.text_color_alpha50(),
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Divider(
            height: 0,
            indent: 4,
            endIndent: 4,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 190, top: 15),
          child: Text.rich(
            TextSpan(
                children: [
                  TextSpan(
                    text: "实付金额：",
                    style: TextStyle(
                        color: R.color.text_color_alpha50(),
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                  TextSpan(
                    text: "¥253",
                    style: TextStyle(
                        color: R.color.text_blue_color(),
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                ]
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 25, bottom: 20),
          child: Text(
            S.of(context).pay_way_title,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: R.color.pay_way_title_text()),
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
                onPressed: () {
                },
                style: OutlinedButton.styleFrom(
                  fixedSize: Size(130, 44),
                  splashFactory: NoSplash.splashFactory,
                  backgroundColor: _selectedPayWay == PAY_WAY_WX
                      ? R.color.pay_way_btn_selected_bg()
                      : R.color.pay_way_btn_unselected_bg(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(22))),
                  side: BorderSide(
                      color: R.color.pay_way_btn_border(), width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Image(
                          image: _selectedPayWay == PAY_WAY_WX
                              ? R.image.ico_wechatpay_selected()
                              : R.image.ico_wechatpay()),
                    ),
                    Text(
                      S.of(context).pay_way_wx,
                      style: TextStyle(
                          fontSize: 14,
                          color: _selectedPayWay == PAY_WAY_WX
                              ? R.color.pay_way_btn_selected_text()
                              : R.color.pay_way_btn_unselected_text()),
                    )
                  ],
                )),
            Container(
              width: 20,
            ),
            OutlinedButton(
                onPressed: () {
                  setState(() {
                    _selectedPayWay = PAY_WAY_ALI;
                  });
                },
                style: OutlinedButton.styleFrom(
                  fixedSize: Size(130, 44),
                  splashFactory: NoSplash.splashFactory,
                  backgroundColor: _selectedPayWay == PAY_WAY_ALI
                      ? R.color.pay_way_btn_selected_bg()
                      : R.color.pay_way_btn_unselected_bg(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(22))),
                  side: BorderSide(
                      color: R.color.pay_way_btn_border(), width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Image(
                          image: _selectedPayWay == PAY_WAY_ALI
                              ? R.image.ico_ailpay_seleted()
                              : R.image.ico_ailpay()),
                    ),
                    Text(
                      S.of(context).pay_way_ali,
                      style: TextStyle(
                          fontSize: 14,
                          color: _selectedPayWay == PAY_WAY_ALI
                              ? R.color.pay_way_btn_selected_text()
                              : R.color.pay_way_btn_unselected_text()),
                    )
                  ],
                ))
          ],
        )
      ],
    );
  }

  Widget _buttonContentView() {
    switch(_painState) {
      case PainState.CLOSED:
        return Container();
      case PainState.PAID:
        return _paidButtonView();
      case PainState.UNPAID:
        return _unpaidButtonView();
    }
  }

  Widget _paidButtonView() {
    return Container(
      margin: EdgeInsets.only(left: 28, right: 28, bottom: 39),
      child: Column(
        children: [
          OutlinedButton(
              onPressed: () {
                // setState(() {
                //   _selectedPayWay = PAY_WAY_WX;
                // });
              },
              style: OutlinedButton.styleFrom(
                fixedSize: Size(double.infinity, 44),
                splashFactory: NoSplash.splashFactory,
                backgroundColor: true
                    ? R.color.pay_way_btn_selected_bg()
                    : R.color.pay_way_btn_unselected_bg(),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(22))),
                side: BorderSide(
                    color: R.color.pay_way_btn_border(), width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).order_history_detail_repurchase,
                    style: TextStyle(
                        fontSize: 14,
                        color: true
                            ? R.color.pay_way_btn_selected_text()
                            : R.color.pay_way_btn_unselected_text()),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget _unpaidButtonView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 13, left: 20, right: 5),
          child: Text(
            S.of(context).pay_total_amount,
            style: TextStyle(
                fontSize: 12, color: R.color.pay_total_amount_title_text()),
          ),
        ),
        Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 13),
              child: Text(
                '¥9.00',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: R.color.pay_total_amount_value_text()),
              ),
            )),
        TextButton(
            onPressed: () {
              // if (_selectedPayWay != PAY_WAY_NONE) {
              //   //success
              //   // Navigator.of(context).pushReplacement(MaterialPageRoute(
              //   //     builder: (context) => PayResultPage(isSuccess: true)));
              //   //failed
              //   Navigator.of(context).push(MaterialPageRoute(
              //       builder: (context) => PayResultPage(isSuccess: false)));
              // }
            },
            style: TextButton.styleFrom(
                splashFactory: true
                    ? NoSplash.splashFactory
                    : InkRipple.splashFactory,
                shape: RoundedRectangleBorder(),
                padding:
                EdgeInsets.only(left: 44, right: 44, top: 16, bottom: 16),
                backgroundColor: true
                    ? R.color.pay_btn_disable_bg()
                    : R.color.pay_btn_bg()),
            child: Text(
              S.of(context).pay_btn,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: true
                      ? R.color.pay_btn_disable_text()
                      : R.color.pay_btn_text()),
            ))
      ],
    );
  }
}