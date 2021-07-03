import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../r.dart';
import '../../s.dart';

class VipCouponBottomSheet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VipCouponBottomSheetState();
}

class _VipCouponBottomSheetState extends State<VipCouponBottomSheet> {
  int _selectedId = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
      child: Column(
        children: [buildTitle(), buildList(), buildNotUseBtn()],
      ),
    );
  }

  Widget buildTitle() {
    return Padding(
      padding: EdgeInsets.only(top: 16, bottom: 10),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).vip_coupon_selector_title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: R.color.vip_coupon_selector_title_text()),
            )
          ]),
    );
  }

  Widget buildList() {
    return Expanded(
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 0),
        itemBuilder: buildListItem,
        itemCount: 5,
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            height: 8,
          );
        },
      ),
    );
  }

  Widget buildListItem(context, int index) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image(
          image: _selectedId == index
              ? R.image.img_coupon_used()
              : R.image.img_coupon_use(),
          width: 300,
          height: 120,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                width: 120,
                height: 120,
                padding: EdgeInsets.only(right: 20, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¥14',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          color: _selectedId == index
                              ? R.color.vip_coupon_selector_selected_main_text()
                              : R.color
                                  .vip_coupon_selector_unselected_main_text()),
                    ),
                    Text(
                      '30 天套餐可用',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 12,
                          color: _selectedId == index
                              ? R.color.vip_coupon_selector_selected_sub_text()
                              : R.color
                                  .vip_coupon_selector_unselected_sub_text()),
                    ),
                  ],
                )),
            Container(
                width: 180,
                height: 120,
                padding:
                    EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '2021/10/10-2022/10/10',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 12,
                          color: _selectedId == index
                              ? R.color.vip_coupon_selector_selected_sub_text()
                              : R.color
                                  .vip_coupon_selector_unselected_sub_text()),
                    ),
                    Text(
                      '30 天优惠券',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _selectedId == index
                              ? R.color.vip_coupon_selector_selected_main_text()
                              : R.color
                                  .vip_coupon_selector_unselected_main_text()),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Spacer(),
                        _selectedId == index
                            ? buildAlreadyUseBtn(index)
                            : buildUseBtn(index)
                      ],
                    )
                  ],
                ))
          ],
        )
      ],
    );
  }

  Widget buildUseBtn(int index) {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedId = index;
            Navigator.of(context).pop();
          });
        },
        style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            fixedSize: MaterialStateProperty.all(Size(84, 30)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(22)))),
            backgroundColor: MaterialStateProperty.all(
                R.color.vip_coupon_selector_use_btn_bg())),
        child: Text(
          S.of(context).vip_coupon_selector_use_btn,
          style: TextStyle(
              fontSize: 14, color: R.color.vip_coupon_selector_use_btn_text()),
        ));
  }

  Widget buildAlreadyUseBtn(int index) {
    return OutlinedButton(
        onPressed: () {
          setState(() {
            _selectedId = index;
            Navigator.of(context).pop();
          });
        },
        style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            fixedSize: MaterialStateProperty.all(Size(84, 30)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(22)))),
            side: MaterialStateProperty.all(BorderSide(
                color: R.color.vip_coupon_selector_already_use_btn_border())),
            overlayColor:
                MaterialStateProperty.all(R.color.vip_outline_btn_splash())),
        child: Text(
          S.of(context).vip_coupon_selector_already_use_btn,
          style: TextStyle(
              fontSize: 14,
              color: R.color.vip_coupon_selector_already_use_btn_text()),
        ));
  }

  Widget buildNotUseBtn() {
    return Container(
      width: 300,
      margin: EdgeInsets.only(top: 30,bottom: 19),
      child: OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.only(top: 11,bottom: 11)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(22)))),
              side: MaterialStateProperty.all(BorderSide(
                  color: R.color.vip_coupon_selector_not_use_btn_border())),
              overlayColor:
              MaterialStateProperty.all(R.color.vip_outline_btn_splash())),
          child: Text(
            S.of(context).vip_coupon_selector_not_use_btn,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: R.color.vip_coupon_selector_not_use_btn_text()),
          )),
    );
  }
}
