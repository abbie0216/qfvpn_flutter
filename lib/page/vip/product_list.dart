import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/vip/product_list_bloc.dart';
import 'package:qfvpn/model/api/bean/product/product_list_result.dart';
import 'package:sprintf/sprintf.dart';

import '../../r.dart';
import '../../s.dart';

class ProductList extends StatefulWidget {
  final void Function(Items product) setSelectedProduct;

  ProductList(this.setSelectedProduct);

  @override
  State<StatefulWidget> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late ProductListBloc _productListBloc;
  int _selectedId = 0;

  @override
  void initState() {
    super.initState();
    _productListBloc = BlocProvider.of<ProductListBloc>(context);
    _productListBloc.add(ProductListFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductListBloc, ProductListState>(
      listener: (context, state) {
        if (state is LoadedState) {
          if (state.result.items?.isNotEmpty == true) {
            widget.setSelectedProduct(state.result.items!.first);
          }
        }
      },
      child: BlocBuilder<ProductListBloc, ProductListState>(
        builder: (context, state) {
          if (state is LoadedState) {
            return NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overScroll) {
                overScroll.disallowGlow();
                return false;
              },
              child: Expanded(
                  child: Container(
                margin:
                    EdgeInsets.only(top: 20, bottom: 20, left: 28, right: 28),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      var product = state.result.items?.elementAt(index);
                      if (product != null) {
                        return Stack(
                          children: [
                            _buildMainItem(index, product),
                            _buildTag(product)
                          ],
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
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildMainItem(int index, Items product) {
    return Padding(
      padding: EdgeInsets.only(top: 9),
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
              splashFactory: NoSplash.splashFactory,
              backgroundColor: _selectedId == index
                  ? R.color.vip_product_selected_bg()
                  : R.color.vip_product_unselected_bg(),
              side: BorderSide(
                  color: _selectedId == index
                      ? R.color.vip_product_selected_border()
                      : R.color.vip_product_unselected_border()),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              )),
          onPressed: () {
            setState(() {
              _selectedId = index;
            });
            widget.setSelectedProduct(product);
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
}
