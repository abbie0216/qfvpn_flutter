import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:qfvpn/bloc/me/coupon/coupon_bloc.dart';
import 'package:qfvpn/model/api/bean/user/UserCouponListResp.dart';
import 'package:qfvpn/model/api/bean/product/product_list_resp.dart';
import '../../constants.dart';
import '../../r.dart';
import '../../s.dart';

class CouponPage extends StatefulWidget {
  CouponPage({Key? key}) : super(key: key);

  @override
  _CouponPageState createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {
  late CouponBloc _couponBloc;

  var _pageKey;
  final PagingController<int, Coupons> _pagingController =
  PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _couponBloc = BlocProvider.of<CouponBloc>(context);
    _pagingController.addPageRequestListener((pageKey) {
      _pageKey = pageKey;
      _couponBloc.add(FetchListEvent(pageKey));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CouponBloc, CouponState>(
      listener: (context, state) {},
      child: BlocBuilder<CouponBloc, CouponState>(builder: (context, state) {
        return Scaffold(
            backgroundColor: R.color.background_color(),
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(S
                  .of(context)
                  .me_coupon,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios,
                    color: R.color.text_blue_color()),
                onPressed: () => Navigator.of(context).pop(),
              ),
              elevation: 0,
              backgroundColor: R.color.background_color(),
              centerTitle: true,
            ),
            body: _buildContentView());
      }),
    );
  }

  Widget _buildContentView() {
    var empty = false;
    return BlocListener<CouponBloc, CouponState>(
        listener: (context, state) {
          if (state is ListLoadedState) {
            Fimber.d('ListLoadedState');
            var newItems = state.data.coupons;
            if (newItems != null) {
              final isLastPage = newItems.length < PAGE_SIZE;
              if (isLastPage) {
                Fimber.d('ListLoadedState isLastPage');
                _pagingController.appendLastPage(newItems);
              } else {
                final nextPageKey = ++_pageKey;
                Fimber.d('ListLoadedState $nextPageKey');
                _pagingController.appendPage(newItems, nextPageKey);
              }
            } else {
              Fimber.d('ListLoadedState null');
            }
          }
        },
        child: BlocBuilder<CouponBloc, CouponState>(builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () =>
                Future.sync(
                      () => _pagingController.refresh(),
                ),
            child: PagedListView<int, Coupons>.separated(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Coupons>(
                itemBuilder: (context, item, index) =>
                    _buildItem(item, index),
                noItemsFoundIndicatorBuilder: (_) =>
                    _buildNoItemsFoundIndicator(),
              ),
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 10,
                  color: Colors.transparent,
                );
              },
            ),
          );
        }));
  }

  Widget _buildItem(Coupons item, int index) {
    return BlocBuilder<CouponBloc, CouponState>(builder: (context, state) {
      Fimber.d('build item index: $index');
      var used = item.status != 0;
      var textColor = used ? R.color.hint_color_light_bg() : R.color
          .text_blue_color();

      return Container(
          height: 120,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: used
                  ? R.image.img_coupon_used()
                  : R.image.img_coupon_use(),
              fit: BoxFit.fill,
            ),
          ),
          child: Row(
              children: [
              Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('¥${item.reduceAmount}',
                      style: TextStyle(color: textColor, fontSize: 40)),
                  Text('${item.thresholdText}',
                      style: TextStyle(
                          color: R.color.hint_color_light_bg(),
                          fontSize: 12))
                ],
              )),
          Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                Text('${DateFormat('yyyy/MM/dd').format(DateTime.parse(item.validStartAt?? ''))} - ${DateFormat('yyyy/MM/dd').format(DateTime.parse(item.validEndAt?? ''))}',
                    style: TextStyle(
                        color: R.color.hint_color_light_bg(),
                        fontSize: 12)),
                Text(item.title ?? '',
                    style: TextStyle(
                        color: textColor, fontSize: 16)),
                Spacer(),
                Align(
                    alignment: Alignment.centerRight,
                    child: useButton(
                        enable: !used,
                        onPress: () {
                          if (!used) {
                            // go to use
                            Navigator.pop(context, item);
                          }
                        }))
                ],
              ))),]
      ,
      )
      );
    });
  }

  Widget useButton({enable, onPress}) {
    if (enable) {
      return TextButton(
        style: TextButton.styleFrom(
          minimumSize: Size(84, 30),
          backgroundColor: R.color.btn_blue_color(),
          elevation: 2.0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(22)),
          ),
        ),
        onPressed: onPress,
        child: Text(S
            .of(context)
            .btn_using,
            style: TextStyle(color: Colors.white, fontSize: 14)),
      );
    } else {
      return IgnorePointer(
          ignoring: true,
          child: OutlinedButton(
            style: TextButton.styleFrom(
                minimumSize: Size(84, 30),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                ),
                side: BorderSide(color: R.color.hint_color_light_bg())),
            onPressed: onPress,
            child: Text(S
                .of(context)
                .btn_used,
                style: TextStyle(
                    color: R.color.hint_color_light_bg(), fontSize: 14)),
          ));
    }
  }

  Widget _buildNoItemsFoundIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 60),
        Image(image: R.image.img_empty()),
        SizedBox(height: 10),
        Text(
          S.of(context).coupon_empty,
          style: TextStyle(color: R.color.hint_color_light_bg()),
        ),
      ],
    );
  }

  Widget _buildNoMoreItemsIndicator() {
    return Padding(
      padding: EdgeInsets.only(top: 40, bottom: 20),
      child: Center(
        child: Text(
          S
              .of(context)
              .feedback_list_end,
          style: TextStyle(color: R.color.text_color_alpha30(), fontSize: 12),
        ),
      ),
    );
  }
}
