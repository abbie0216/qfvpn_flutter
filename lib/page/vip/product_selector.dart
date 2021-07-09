import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:qfvpn/bloc/vip/product_selector_bloc.dart';
import 'package:qfvpn/model/api/bean/product/product_list_resp.dart';
import 'package:qfvpn/page/vip/coupon_selector.dart';
import 'package:sprintf/sprintf.dart';

import '../../r.dart';
import '../../s.dart';

class ProductSelector extends StatefulWidget {
  final void Function(Items product, Coupons? coupons) setSelectedProduct;

  ProductSelector(this.setSelectedProduct);

  @override
  State<StatefulWidget> createState() => _ProductSelectorState();
}

class _ProductSelectorState extends State<ProductSelector> {
  late ProductSelectorBloc _productSelectorBloc;
  Items? _selectedProduct;
  Coupons? _selectedCoupon;

  @override
  void initState() {
    super.initState();
    _productSelectorBloc = BlocProvider.of<ProductSelectorBloc>(context);
    _productSelectorBloc.add(ProductListFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductSelectorBloc, ProductSelectorState>(
      listener: (context, state) {
        if (state is LoadedState) {
          if (state.result.items?.isNotEmpty == true) {
            _selectedProduct = state.result.items!.first;
            widget.setSelectedProduct(_selectedProduct!, _selectedCoupon);
          }
        }
      },
      child: BlocBuilder<ProductSelectorBloc, ProductSelectorState>(
        builder: (context, state) {
          if (state is LoadedState) {
            return Expanded(
                child: Column(
              children: [
                _buildProductList(state),
                _buildCouponInfo(),
              ],
            ));
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildProductList(state) {
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
              var product = state.result.items?.elementAt(index);
              if (product != null) {
                return Stack(
                  children: [_buildMainItem(product), _buildTag(product)],
                );
              } else {
                return Container();
              }
            },
            separatorBuilder: (context, index) {
              return Container(
                height: 6,
              );
            },
            itemCount: state.result.items?.length ?? 0),
      )),
    );
  }

  Widget _buildMainItem(Items product) {
    return Padding(
      padding: EdgeInsets.only(top: 9),
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
              splashFactory: NoSplash.splashFactory,
              backgroundColor: _selectedProduct!.productId == product.productId
                  ? R.color.vip_product_selected_bg()
                  : R.color.vip_product_unselected_bg(),
              side: BorderSide(
                  color: _selectedProduct!.productId == product.productId
                      ? R.color.vip_product_selected_border()
                      : R.color.vip_product_unselected_border()),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              )),
          onPressed: () {
            setState(() {
              if (_selectedProduct!.productId != product.productId) {
                _selectedProduct = product;
                _selectedCoupon = null;
              }
            });
            widget.setSelectedProduct(_selectedProduct!, _selectedCoupon);
          },
          child: Row(
            children: [
              Image(
                  image: _selectedProduct!.productId == product.productId
                      ? R.image.btn_radio_p()
                      : R.image.btn_radio_n()),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 5),
                child: Text(
                  sprintf(S.of(context).vip_product_title,
                      [product.itemName, product.price]),
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      fontSize: 14,
                      color: R.color.vip_product_name_main_text(),
                      fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                  child: Text(
                sprintf(S.of(context).vip_product_month_price,
                    [product.monthPrice]),
                overflow: TextOverflow.fade,
                style: TextStyle(
                    fontSize: 12,
                    color: R.color.vip_product_name_sub_text(),
                    fontWeight: FontWeight.w500),
              )),
            ],
          )),
    );
  }

  Widget _buildTag(Items product) {
    var type = 0;
    if (product.isNewCustomer != null && product.extraDays != null) {
      if (product.isNewCustomer == true && product.extraDays! > 0) {
        type = 1;
      } else if (product.isNewCustomer == true) {
        type = 2;
      } else if (product.extraDays! > 0) {
        type = 3;
      }
    }
    return IndexedStack(
      alignment: Alignment.centerRight,
      index: type,
      children: [
        /** 0: no tag **/
        Container(),
        /** 1: new in tag + extra day tag **/
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
                  color: R.color.vip_product_new_in_gift_tag_bg()),
              child: Text(
                S.of(context).vip_product_new_in_gift_tag,
                style: TextStyle(
                    fontSize: 10,
                    color: R.color.vip_product_new_in_gift_tag_text(),
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
                  color: R.color.vip_product_extra_day_gift_tag_bg()),
              child: Text(
                sprintf(S.of(context).vip_product_extra_day_gift_tag,
                    [product.extraDays]),
                style: TextStyle(
                    fontSize: 10,
                    color: R.color.vip_product_extra_day_gift_tag_text(),
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
        /** 2: new in tag **/
        Container(
          width: 70,
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 2, bottom: 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              color: R.color.vip_product_new_in_gift_tag_bg()),
          child: Text(
            S.of(context).vip_product_new_in_gift_tag,
            style: TextStyle(
                fontSize: 10,
                color: R.color.vip_product_new_in_gift_tag_text(),
                fontWeight: FontWeight.w500),
          ),
        ),
        /** 3: extra day tag **/
        Container(
          width: 70,
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 2, bottom: 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              color: R.color.vip_product_extra_day_gift_tag_bg()),
          child: Text(
            sprintf(S.of(context).vip_product_extra_day_gift_tag,
                [product.extraDays]),
            style: TextStyle(
                fontSize: 10,
                color: R.color.vip_product_extra_day_gift_tag_text(),
                fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }

  Widget _buildCouponInfo() {
    var type = _selectedCoupon == null ? 0 : 1;

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
            index: type,
            children: [
              /** 0: coupon not selected **/
              TextButton(
                  onPressed: () {
                    _showVipCouponSelector(_selectedProduct?.coupons);
                  },
                  style: TextButton.styleFrom(
                      splashFactory: NoSplash.splashFactory),
                  child: Text(
                    sprintf(S.of(context).vip_coupon_unselected_desc,
                        [_selectedProduct?.coupons?.length ?? 0]),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 12,
                        color: R.color.vip_coupon_state_text(),
                        fontWeight: FontWeight.bold),
                  )),
              /** 1: coupon selected **/
              OutlinedButton(
                  onPressed: () {
                    _showVipCouponSelector(_selectedProduct?.coupons);
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
                    sprintf(S.of(context).vip_coupon_selected_desc, [
                      _selectedCoupon?.title ?? '',
                      _selectedCoupon?.reduceAmount ?? ''
                    ]),
                    style: TextStyle(
                        fontSize: 12, color: R.color.vip_coupon_state_text()),
                  )),
            ],
          )
        ],
      ),
    );
  }

  void _showVipCouponSelector(List<Coupons>? coupons) {
    if (coupons?.isNotEmpty == true) {
      showMaterialModalBottomSheet(
          enableDrag: false,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) =>
              CouponSelector(coupons!, _selectedCoupon)).then((result) {
        if ((result as Coupons?)?.userCouponId != _selectedCoupon?.userCouponId) {
          setState(() {
            _selectedCoupon = result;
          });
          widget.setSelectedProduct(_selectedProduct!, _selectedCoupon);
        }
      });
    }
  }
}
