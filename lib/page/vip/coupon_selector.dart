import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:qfvpn/model/api/bean/product/product_list_resp.dart';

import '../../r.dart';
import '../../s.dart';

class CouponSelector extends StatefulWidget {
  final List<Coupons> coupons;
  final Coupons? selectedCoupon;

  CouponSelector(this.coupons, this.selectedCoupon);

  @override
  State<StatefulWidget> createState() => _CouponSelectorState();
}

class _CouponSelectorState extends State<CouponSelector> {
  Coupons? _selectedCoupon;

  @override
  void initState() {
    super.initState();
    _selectedCoupon = widget.selectedCoupon;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
            Navigator.of(context).pop(widget.selectedCoupon);
          return false;
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
          child: Column(
            children: [_buildTitle(), _buildList(), _buildNotUseBtn()],
          ),
        ));
  }

  Widget _buildTitle() {
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

  Widget _buildList() {
    return Expanded(
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 0),
        itemBuilder: (context, index) {
          var coupon = widget.coupons.elementAt(index);
          return _buildListItem(context, coupon);
        },
        itemCount: widget.coupons.length,
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            height: 8,
          );
        },
      ),
    );
  }

  Widget _buildListItem(context, Coupons coupon) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image(
          image: _selectedCoupon?.userCouponId == coupon.userCouponId
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
                      '¥${coupon.reduceAmount}',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          color: _selectedCoupon?.userCouponId ==
                                  coupon.userCouponId
                              ? R.color.vip_coupon_selector_selected_main_text()
                              : R.color
                                  .vip_coupon_selector_unselected_main_text()),
                    ),
                    Text(
                      coupon.thresholdText ?? '',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 12,
                          color: _selectedCoupon?.userCouponId ==
                                  coupon.userCouponId
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
                      _buildValidTimeText(coupon),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 12,
                          color: _selectedCoupon?.userCouponId ==
                                  coupon.userCouponId
                              ? R.color.vip_coupon_selector_selected_sub_text()
                              : R.color
                                  .vip_coupon_selector_unselected_sub_text()),
                    ),
                    Text(
                      coupon.title ?? '',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _selectedCoupon?.userCouponId ==
                                  coupon.userCouponId
                              ? R.color.vip_coupon_selector_selected_main_text()
                              : R.color
                                  .vip_coupon_selector_unselected_main_text()),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Spacer(),
                        _selectedCoupon?.userCouponId == coupon.userCouponId
                            ? _buildAlreadyUseBtn(coupon)
                            : _buildUseBtn(coupon)
                      ],
                    )
                  ],
                ))
          ],
        )
      ],
    );
  }

  String _buildValidTimeText(Coupons coupon) {
    var dateFormat = DateFormat('yyyy/MM/dd');
    var startTime = DateFormat('yyyy-MM-ddTHH:mm:ssZ')
        .parse(coupon.validStartAt ?? '', true);
    var endTime =
        DateFormat('yyyy-MM-ddTHH:mm:ssZ').parse(coupon.validEndAt ?? '', true);
    return '${dateFormat.format(startTime)}-${dateFormat.format(endTime)}';
  }

  Widget _buildUseBtn(Coupons coupons) {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedCoupon = coupons;
          });
          Navigator.of(context).pop(coupons);
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

  Widget _buildAlreadyUseBtn(Coupons coupons) {
    return OutlinedButton(
        onPressed: () {
          setState(() {
            _selectedCoupon = coupons;
          });
          Navigator.of(context).pop(coupons);
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

  Widget _buildNotUseBtn() {
    return Container(
      width: 300,
      margin: EdgeInsets.only(top: 30, bottom: 19),
      child: OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop(null);
          },
          style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  EdgeInsets.only(top: 11, bottom: 11)),
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
