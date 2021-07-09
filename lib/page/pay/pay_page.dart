import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/pay/pay_bloc.dart';
import 'package:qfvpn/model/api/bean/product/product_list_resp.dart';
import 'package:qfvpn/page/pay/pay_result_page.dart';
import 'package:qfvpn/utility/pop_result.dart';
import 'package:qfvpn/widget/selector_widget_button.dart';
import 'package:sprintf/sprintf.dart';

import '../../r.dart';
import '../../s.dart';

class PayPage extends StatefulWidget {
  final Items? product;
  final Coupons? coupon;

  PayPage(this.product, this.coupon);

  @override
  State<StatefulWidget> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  static const PAY_WAY_NONE = -1;
  static const PAY_WAY_WX = 0;
  static const PAY_WAY_ALI = 1;
  int _selectedPayWay = PAY_WAY_NONE;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PayBloc, PayState>(
        listener: (context, state) {},
        child: BlocBuilder<PayBloc, PayState>(
          builder: (context, state) {
            return Theme(
              data: ThemeData(primaryColor: R.color.pay_app_bar_bg()),
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  title: Text(
                    S.of(context).pay_title,
                    style: TextStyle(
                        fontSize: 16,
                        color: R.color.pay_title_text(),
                        fontWeight: FontWeight.bold),
                  ),
                  centerTitle: true,
                  leading: SelectorWidgetButton(
                    widgetN: Image(image: R.image.btn_back_n()),
                    widgetP: Image(image: R.image.btn_back_p()),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                body: SafeArea(
                  child: Container(
                    color: R.color.pay_bg(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildPayInfo(),
                        _buildPayHint(),
                        Spacer(),
                        Divider(
                          color: R.color.pay_divider_2_bg(),
                          thickness: 1,
                          height: 1,
                        ),
                        _buildPayButton()
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }

  Widget _buildPayInfo() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 20),
      padding: EdgeInsets.only(top: 10, bottom: 34),
      decoration: BoxDecoration(
        color: R.color.pay_info_bg(),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: Row(
              children: [
                Text(
                  widget.product?.itemName ?? '',
                  style: TextStyle(
                      fontSize: 14, color: R.color.pay_info_item_title_text()),
                ),
                Spacer(),
                Expanded(
                    flex: 100,
                    child: Text(
                      '¥${widget.product?.price ?? '0'}',
                      style: TextStyle(
                          fontSize: 14,
                          color: R.color.pay_info_item_value_text()),
                      textAlign: TextAlign.right,
                    ))
              ],
            ),
          ),
          Divider(
            indent: 4,
            endIndent: 4,
            thickness: 1,
            color: R.color.pay_divider_1_bg(),
            height: 1,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Row(
              children: [
                Text(
                  S.of(context).pay_info_coupon_title,
                  style: TextStyle(
                      fontSize: 14, color: R.color.pay_info_item_title_text()),
                ),
                Spacer(),
                Expanded(
                    flex: 100,
                    child: Text(
                      _getCouponText(),
                      style: TextStyle(
                          fontSize: 14,
                          color: R.color.pay_info_item_value_text()),
                      textAlign: TextAlign.right,
                    ))
              ],
            ),
          ),
          Divider(
            indent: 4,
            endIndent: 4,
            thickness: 1,
            color: R.color.pay_divider_1_bg(),
            height: 1,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Row(
              children: [
                Text(
                  S.of(context).pay_info_amount_title,
                  style: TextStyle(
                      fontSize: 14, color: R.color.pay_info_item_title_text()),
                ),
                Spacer(),
                Expanded(
                    flex: 100,
                    child: Text(
                      _getTotalAmountText(),
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: R.color.pay_total_amount_value_text()),
                      textAlign: TextAlign.right,
                    ))
              ],
            ),
          ),
          Divider(
            indent: 4,
            endIndent: 4,
            thickness: 1,
            color: R.color.pay_divider_1_bg(),
            height: 1,
          ),
          Padding(
            padding: EdgeInsets.only(top: 25, bottom: 20),
            child: Text(
              S.of(context).pay_way_title,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: R.color.pay_way_title_text()),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _selectedPayWay = PAY_WAY_WX;
                    });
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
      ),
    );
  }

  Widget _buildPayHint() {
    return Padding(
      padding: EdgeInsets.only(left: 40, right: 40),
      child: Text(
        S.of(context).pay_hint,
        style: TextStyle(
          fontSize: 12,
          color: R.color.pay_hint_text(),
        ),
      ),
    );
  }

  Widget _buildPayButton() {
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
            _getTotalAmountText(),
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: R.color.pay_total_amount_value_text()),
          ),
        )),
        TextButton(
            onPressed: () {
              if (_selectedPayWay != PAY_WAY_NONE) {
                //success
                // Navigator.of(context)
                //     .push(MaterialPageRoute(
                //         builder: (context) => PayResultPage(isSuccess: true)))
                //     .then((results) {
                //   if (results is PopResult) {
                //     Navigator.of(context).pop(results);
                //   }
                // });
                //failed
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (context) => PayResultPage(isSuccess: false)))
                    .then((results) {
                  if (results is PopResult) {
                    Navigator.of(context).pop(results);
                  }
                });
              }
            },
            style: TextButton.styleFrom(
                splashFactory: _selectedPayWay == PAY_WAY_NONE
                    ? NoSplash.splashFactory
                    : InkRipple.splashFactory,
                shape: RoundedRectangleBorder(),
                padding:
                    EdgeInsets.only(left: 44, right: 44, top: 16, bottom: 16),
                backgroundColor: _selectedPayWay == PAY_WAY_NONE
                    ? R.color.pay_btn_disable_bg()
                    : R.color.pay_btn_bg()),
            child: Text(
              S.of(context).pay_btn,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: _selectedPayWay == PAY_WAY_NONE
                      ? R.color.pay_btn_disable_text()
                      : R.color.pay_btn_text()),
            ))
      ],
    );
  }

  String _getCouponText() {
    if (widget.product?.coupons?.isEmpty == true) {
      return S.of(context).pay_info_coupon_not_available;
    } else {
      return '-¥${widget.coupon?.reduceAmount??'0'}';
    }
  }

  String _getTotalAmountText() {
    var productPrice = double.parse(widget.product?.price??'0');
    var reduceAmount = double.parse(widget.coupon?.reduceAmount??'0');
    var totalAmount = productPrice - reduceAmount;
    return sprintf('¥%.2f',[totalAmount]);
  }
}
