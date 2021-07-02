import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:qfvpn/bloc/vip/vip_bloc.dart';
import 'package:qfvpn/page/pay/pay_page.dart';
import 'package:qfvpn/page/vip/vip_coupon_bottom_sheet.dart';
import 'package:qfvpn/s.dart';
import 'package:qfvpn/widget/selector_widget_button.dart';
import 'package:sprintf/sprintf.dart';

import '../../r.dart';

class VipPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VipPageState();
}

class _VipPageState extends State<VipPage> {
  int _selectedId = 0;

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
                        //todo history
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
                        buildMemberInfo(),
                        buildPackageList(),
                        buildCouponInfo(),
                        buildPayBtn(),
                        buildVipBenefits()
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }

  Widget buildMemberInfo() {
    return Container(
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

  Widget buildPackageList() {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overScroll) {
        overScroll.disallowGlow();
        return false;
      },
      child: Expanded(
          child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 20, left: 28, right: 28),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Stack(
                children: [buildPackageMainItem(index), buildPackageTag(1)],
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                height: 6,
              );
            },
            itemCount: 5),
      )),
    );
  }

  Widget buildPackageMainItem(int index) {
    return Padding(
      padding: EdgeInsets.only(top: 9),
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
              splashFactory: NoSplash.splashFactory,
              backgroundColor: _selectedId == index
                  ? R.color.vip_package_selected_bg()
                  : R.color.vip_package_unselected_bg(),
              side: BorderSide(
                  color: _selectedId == index
                      ? R.color.vip_package_selected_border()
                      : R.color.vip_package_unselected_border()),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              )),
          onPressed: () {
            setState(() {
              _selectedId = index;
            });
          },
          child: Row(
            children: [
              Image(
                  image: _selectedId == index
                      ? R.image.btn_radio_p()
                      : R.image.btn_radio_n()),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 5),
                child: Text(
                  '360天VIP: ¥400',
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      fontSize: 14,
                      color: R.color.vip_package_name_main_text(),
                      fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                  child: Text(
                '(¥25/月)',
                overflow: TextOverflow.fade,
                style: TextStyle(
                    fontSize: 12,
                    color: R.color.vip_package_name_sub_text(),
                    fontWeight: FontWeight.w500),
              )),
            ],
          )),
    );
  }

  Widget buildPackageTag(int type) {
    return IndexedStack(
      alignment: Alignment.centerRight,
      index: type,
      children: [
        /** no tag **/
        Container(),
        /** new in tag + extra day tag **/
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 70,
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 2, bottom: 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                  color: R.color.vip_package_new_in_gift_tag_bg()),
              child: Text(
                S.of(context).vip_package_new_in_gift_tag,
                style: TextStyle(
                    fontSize: 10,
                    color: R.color.vip_package_new_in_gift_tag_text(),
                    fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              width: 70,
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 2, bottom: 2),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(10)),
                  color: R.color.vip_package_extra_day_gift_tag_bg()),
              child: Text(
                sprintf(S.of(context).vip_package_extra_day_gift_tag, [30]),
                style: TextStyle(
                    fontSize: 10,
                    color: R.color.vip_package_extra_day_gift_tag_text(),
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
        /** new in tag **/
        Container(
          width: 70,
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 2, bottom: 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              color: R.color.vip_package_new_in_gift_tag_bg()),
          child: Text(
            S.of(context).vip_package_new_in_gift_tag,
            style: TextStyle(
                fontSize: 10,
                color: R.color.vip_package_new_in_gift_tag_text(),
                fontWeight: FontWeight.w500),
          ),
        ),
        /** extra day tag **/
        Container(
          width: 70,
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 2, bottom: 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              color: R.color.vip_package_extra_day_gift_tag_bg()),
          child: Text(
            sprintf(S.of(context).vip_package_extra_day_gift_tag, [30]),
            style: TextStyle(
                fontSize: 10,
                color: R.color.vip_package_extra_day_gift_tag_text(),
                fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }

  Widget buildCouponInfo() {
    return Padding(
      padding: EdgeInsets.only(left: 28, right: 28),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.of(context).vip_coupon_title,
            style: TextStyle(
                color: R.color.vip_subtitle_text(),
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
          IndexedStack(
            alignment: Alignment.centerRight,
            index: 0,
            children: [
              TextButton(
                  onPressed: () {
                    showVipCouponBottomSheet();
                  },
                  style: TextButton.styleFrom(
                      splashFactory: NoSplash.splashFactory),
                  child: Text(
                    sprintf(S.of(context).vip_coupon_unselected_desc, [1]),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 12,
                        color: R.color.vip_coupon_state_text(),
                        fontWeight: FontWeight.bold),
                  )),
              OutlinedButton(
                  onPressed: () {
                    showVipCouponBottomSheet();
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22))),
                      backgroundColor: MaterialStateProperty.all(
                          R.color.vip_coupon_state_bg()),
                      side: MaterialStateProperty.all(
                          BorderSide(color: R.color.vip_coupon_state_border())),
                      overlayColor: MaterialStateProperty.all(
                          R.color.vip_outline_btn_splash())),
                  child: Text(
                    sprintf(S.of(context).vip_coupon_selected_desc, [30, 24]),
                    style: TextStyle(
                        fontSize: 12, color: R.color.vip_coupon_state_text()),
                  )),
            ],
          )
        ],
      ),
    );
  }

  Widget buildPayBtn() {
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
            Navigator.of(context).pushNamed((PayPage).toString());
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

  Widget buildVipBenefits() {
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

  void showVipCouponBottomSheet() {
    showMaterialModalBottomSheet(
        enableDrag: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => VipCouponBottomSheet());
  }
}
