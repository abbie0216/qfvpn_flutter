import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/vip/vip_bloc.dart';
import 'package:qfvpn/model/api/bean/product/product_list_result.dart';
import 'package:qfvpn/page/home/home_page.dart';
import 'package:qfvpn/page/pay/pay_page.dart';
import 'package:qfvpn/page/vip/order_history_page.dart';
import 'package:qfvpn/page/vip/product_selector.dart';
import 'package:qfvpn/s.dart';
import 'package:qfvpn/utility/pop_result.dart';
import 'package:qfvpn/widget/selector_widget_button.dart';
import 'package:sprintf/sprintf.dart';

import '../../r.dart';

class VipPage extends StatefulWidget {
  final Function(int index) goToMainPage;

  VipPage(this.goToMainPage);

  @override
  State<StatefulWidget> createState() => _VipPageState();
}

class _VipPageState extends State<VipPage> {
  Items? _product;
  Coupons? _coupons;

  @override
  Widget build(BuildContext context) {
    return BlocListener<VipBloc, VipState>(
        listener: (context, state) {},
        child: BlocBuilder<VipBloc, VipState>(
          builder: (context, state) {
            return Theme(
              data: ThemeData(primaryColor: R.color.vip_app_bar_bg()),
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  title: Text(
                    S.of(context).vip_title,
                    style: TextStyle(
                        fontSize: 16,
                        color: R.color.vip_title_text(),
                        fontWeight: FontWeight.bold),
                  ),
                  centerTitle: true,
                  actions: [
                    SelectorWidgetButton(
                      widgetN: Image(image: R.image.btn_history_n()),
                      widgetP: Image(image: R.image.btn_history_p()),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed((OrderHistoryPage).toString());
                      },
                    )
                  ],
                ),
                body: SafeArea(
                  child: Container(
                    color: R.color.vip_bottom_bg(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildMemberInfo(),
                        ProductSelector(_setSelectedProduct),
                        _buildPayBtn(),
                        _buildVipBenefits()
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }

  Widget _buildMemberInfo() {
    return Container(
      height: 120,
      padding: EdgeInsets.only(bottom: 40, left: 40),
      decoration: BoxDecoration(
          color: R.color.vip_top_bg(),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: R.color.background_color()),
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 60,
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(left: 19),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    sprintf(
                        S.of(context).vip_expired_time_valid, ['2021-02-02']),
                    style:
                        TextStyle(color: R.color.vip_expired_time_valid_text()),
                  ),
                ),
                Text(
                  sprintf(S.of(context).vip_id, ['95279527']),
                  textAlign: TextAlign.left,
                  style: TextStyle(color: R.color.vip_id_text()),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget _buildPayBtn() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 28, right: 28, top: 10, bottom: 20),
      child: ElevatedButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  EdgeInsets.only(top: 14, bottom: 14)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)))),
              backgroundColor:
                  MaterialStateProperty.all(R.color.vip_pay_btn_bg())),
          onPressed: () {
            Navigator.of(context)
                .pushNamed((PayPage).toString())
                .then((results) {
              if (results is PopResult) {
                if(results.toPage == (HomePage).toString()) {
                  widget.goToMainPage(0);
                }
              }
            });
          },
          child: Text(
            S.of(context).vip_pay_btn,
            style: TextStyle(
                fontSize: 14,
                color: R.color.vip_pay_btn_text(),
                fontWeight: FontWeight.w500),
          )),
    );
  }

  Widget _buildVipBenefits() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 28, right: 28, bottom: 10),
          child: Text(
            S.of(context).vip_benefits_title,
            style: TextStyle(
                color: R.color.vip_subtitle_text(),
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: Column(
                children: [
                  Image(image: R.image.img_rocket()),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8, top: 5),
                    child: Text(
                      S.of(context).vip_benefits_1,
                      style: TextStyle(
                          fontSize: 10,
                          color: R.color.vip_benefits_item_text()),
                    ),
                  )
                ],
              )),
              Expanded(
                  child: Column(
                children: [
                  Image(image: R.image.img_speed()),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8, top: 5),
                    child: Text(
                      S.of(context).vip_benefits_2,
                      style: TextStyle(
                          fontSize: 10,
                          color: R.color.vip_benefits_item_text()),
                    ),
                  )
                ],
              )),
              Expanded(
                  child: Column(
                children: [
                  Image(image: R.image.img_special()),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8, top: 5),
                    child: Text(
                      S.of(context).vip_benefits_3,
                      style: TextStyle(
                          fontSize: 10,
                          color: R.color.vip_benefits_item_text()),
                    ),
                  )
                ],
              )),
              Expanded(
                  child: Column(
                children: [
                  Image(image: R.image.img_safety()),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8, top: 5),
                    child: Text(
                      S.of(context).vip_benefits_4,
                      style: TextStyle(
                          fontSize: 10,
                          color: R.color.vip_benefits_item_text()),
                    ),
                  )
                ],
              )),
              Expanded(
                  child: Column(
                children: [
                  Image(image: R.image.img_vip()),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8, top: 5),
                    child: Text(
                      S.of(context).vip_benefits_5,
                      style: TextStyle(
                          fontSize: 10,
                          color: R.color.vip_benefits_item_text()),
                    ),
                  )
                ],
              )),
            ],
          ),
        )
      ],
    );
  }

  void _setSelectedProduct(Items product, Coupons? coupons){
    _product = product;
    _coupons = coupons;
  }

}
