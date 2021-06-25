import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/me/coupon/coupon_bloc.dart';
import '../../r.dart';
import '../../s.dart';

class CouponPage extends StatefulWidget {
  CouponPage({Key? key}) : super(key: key);

  @override
  _CouponPageState createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {
  late CouponBloc _couponBloc;

  @override
  void initState() {
    super.initState();
    _couponBloc = BlocProvider.of<CouponBloc>(context);
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
              title: Text(S.of(context).me_coupon,
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
        listener: (context, state) {},
        child: BlocBuilder<CouponBloc, CouponState>(builder: (context, state) {
          return empty
              ? Align(
                  alignment: Alignment(0.0, -0.7),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(image: R.image.img_empty()),
                      Text(
                        S.of(context).coupon_empty,
                        style: TextStyle(color: R.color.hint_color_light_bg()),
                      )
                    ],
                  ))
              : ListView.separated(
                  itemCount: 12, //for test
                  padding: const EdgeInsets.fromLTRB(28, 10, 28, 10),
                  itemBuilder: (BuildContext context, int index) {
                    return _buildItem(index);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      height: 10,
                      color: Colors.transparent,
                    );
                  },
                );
        }));
  }

  Widget _buildItem(int index) {
    return BlocListener<CouponBloc, CouponState>(
        listener: (context, state) {},
        child: BlocBuilder<CouponBloc, CouponState>(builder: (context, state) {
          var used = index % 2 == 1 ? true : false; //for test
          var textColor =
              used ? R.color.hint_color_light_bg() : R.color.text_blue_color();

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
                          Text('¥30',
                              style: TextStyle(color: textColor, fontSize: 40)),
                          Text('30 天 VIP 可用',
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
                              Text('2021/10/10-2022/10/10',
                                  style: TextStyle(
                                      color: R.color.hint_color_light_bg(),
                                      fontSize: 12)),
                              Text('90 天 VIP 优惠券',
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
                                          Navigator.pop(context);
                                        }
                                      }))
                            ],
                          ))),
                ],
              ));
        }));
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
        child: Text(S.of(context).btn_using,
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
            child: Text(S.of(context).btn_used,
                style: TextStyle(
                    color: R.color.hint_color_light_bg(), fontSize: 14)),
          ));
    }
  }
}
