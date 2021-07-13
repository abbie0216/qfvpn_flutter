import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:intl/intl.dart';
import 'package:qfvpn/bloc/me/me_bloc.dart';
import 'package:qfvpn/model/api/bean/product/product_list_resp.dart';
import 'package:qfvpn/page/feedback/feedback_list_page.dart';
import 'package:qfvpn/page/login/login_page.dart';
import 'package:qfvpn/page/me/points_page.dart';
import 'package:qfvpn/page/setting/binding_page.dart';
import 'package:qfvpn/page/setting/setting_page.dart';
import 'package:qfvpn/widget/selector_widget_button.dart';
import 'package:sprintf/sprintf.dart';

import '../../r.dart';
import '../../s.dart';
import 'about_page.dart';
import 'coupon_page.dart';
import 'news_page.dart';

class MePage extends StatefulWidget {
  final Function(int index) goToMainPage;

  MePage(this.goToMainPage);

  @override
  State<StatefulWidget> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  late MeBloc _meBloc;

  @override
  void initState() {
    super.initState();
    _meBloc = BlocProvider.of<MeBloc>(context);
    _meBloc.add(AppVersionEvent());
    _meBloc.add(GetUserInfoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MeBloc, MeState>(
      listener: (context, state) {},
      child: BlocBuilder<MeBloc, MeState>(builder: (context, state) {
        return Scaffold(
          backgroundColor: R.color.background_color(),
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(S.of(context).me_page_title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            leading: null,
            elevation: 0,
            backgroundColor: R.color.me_title_block_bg_color(),
            centerTitle: true,
            actions: <Widget>[
              SelectorWidgetButton(
                  widgetN: Image(image: R.image.btn_setting_n()),
                  widgetP: Image(image: R.image.btn_setting_p()),
                  onPressed: () {
                    Navigator.of(context).pushNamed((SettingPage).toString());
                  })
            ],
          ),
          body: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              _buildAccountInfo(),
              _buildMailCouponButtons(),
              _buildItemsRegion()
            ],
          ),
        );
      }),
    );
  }

  Widget _buildAccountInfo() {
    var userID = '-';
    var vip_endAt = '${S.of(context).me_vip_time_label} -';
    var isVipExpired = false;
    return BlocBuilder<MeBloc, MeState>(builder: (context, state) {
      if (state is UserInfoUpdatedState) {
        userID = state.userInfo.userNo;
        if (state.userInfo.isVip) {
          if (state.userInfo.isVipExpired) {
            isVipExpired = true;
            vip_endAt = S.of(context).me_vip_time_expired;
          } else {
            vip_endAt =
                '${S.of(context).me_vip_time_label} ${DateFormat('yyyy-MM-dd').format(DateTime.parse(state.userInfo.vipEndAt))}';
          }
        }
      }

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
                      vip_endAt,
                      style: TextStyle(
                          color: isVipExpired
                              ? R.color.vip_expired_time_invalid_text()
                              : R.color.vip_expired_time_valid_text()),
                    ),
                  ),
                  Row(children: [
                    Text(
                      sprintf(S.of(context).vip_id, [userID]),
                      textAlign: TextAlign.left,
                      style: TextStyle(color: R.color.vip_id_text()),
                    ),
                    GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: userID))
                              .then((_) {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(SnackBar(
                                  content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(S.of(context).msg_copied),
                                ],
                              )));
                          });
                        },
                        child: Image(image: R.image.btn_copy_n()))
                  ])
                ],
              ),
            ))
          ],
        ),
      );
    });
  }

  Widget _buildMailCouponButtons() {
    var isBindEmail = false;
    return BlocBuilder<MeBloc, MeState>(builder: (context, state) {
      if (state is UserInfoUpdatedState) {
        isBindEmail = state.userInfo.isBindEmail;
      }
      return Positioned(
          top: 120 - 24,
          child: Row(
            children: [
              TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size(130, 44),
                    backgroundColor: R.color.btn_blue_color(),
                    elevation: 5.0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(22)),
                    ),
                  ),
                  onPressed: () {
                    if (!isBindEmail) {
                      Navigator.of(context).pushNamed((BindingPage).toString());
                    }
                  },
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                            image: isBindEmail
                                ? R.image.icon_linked()
                                : R.image.icon_link()),
                        Text(S.of(context).me_bind_mail,
                            style:
                                TextStyle(color: Colors.white, fontSize: 14)),
                        Image(image: R.image.btn_next_white_n())
                      ])),
              SizedBox(width: 20),
              TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size(130, 44),
                  backgroundColor: R.color.btn_blue_color(),
                  elevation: 5.0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(22)),
                  ),
                ),
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CouponPage()),
                  ).then((value) {
                    if (value is Coupon) {
                      Fimber.d('select coupon ${value.title}');
                      widget.goToMainPage(1);
                    }
                  });
                },
                child: Text(S.of(context).me_coupon,
                    style: TextStyle(color: Colors.white, fontSize: 14)),
              )
            ],
          ));
    });
  }

  Widget _buildItemsRegion() {
    var appVersion = '';
    return BlocListener<MeBloc, MeState>(
        listener: (context, state) {},
        child: BlocBuilder<MeBloc, MeState>(builder: (context, state) {
          if (state is AppVersionState) {
            appVersion = state.appVersion;
            Fimber.d('appVersion: $appVersion');
          }
          return Align(
              alignment: FractionalOffset(0.0, 0.6),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                _buildVipItem(),
                SizedBox(height: 14),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 48,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed((NewsPage).toString());
                            },
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Image(
                                      image: R.image.icon_notice(),
                                    )),
                                Expanded(
                                    flex: 10,
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: S.of(context).me_item_news,
                                              style: TextStyle(
                                                  color: R.color
                                                      .text_gray_color())),
                                          WidgetSpan(
                                              alignment:
                                                  PlaceholderAlignment.middle,
                                              child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5),
                                                  child: Icon(Icons.circle,
                                                      size: 5,
                                                      color: Colors.red)))
                                        ],
                                      ),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Image(
                                      image: R.image.btn_next_n(),
                                    ))
                              ],
                            )),
                      ),
                      Divider(
                        color: R.color.background_color(),
                        thickness: 1.0,
                        height: 1,
                      ),
                      SizedBox(
                        height: 48,
                        child: GestureDetector(
                            onTap: () {
                              // Navigator.of(context)
                              //     .pushNamed((NewsPage).toString());
                            },
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Image(
                                      image: R.image.icon_help(),
                                    )),
                                Expanded(
                                    flex: 10,
                                    child: Text(S.of(context).me_item_help,
                                        style: TextStyle(
                                            color: R.color.text_gray_color()))),
                                Expanded(
                                    flex: 1,
                                    child: Image(
                                      image: R.image.btn_next_n(),
                                    ))
                              ],
                            )),
                      ),
                      Divider(
                        color: R.color.background_color(),
                        thickness: 1.0,
                        height: 1,
                      ),
                      SizedBox(
                        height: 48,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed((FeedbackListPage).toString());
                            },
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Image(
                                      image: R.image.icon_opinion(),
                                    )),
                                Expanded(
                                    flex: 8,
                                    child: Text(S.of(context).me_item_feedback,
                                        style: TextStyle(
                                            color: R.color.text_gray_color()))),
                                Expanded(
                                    flex: 2,
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                            height: 20,
                                            width: 36,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(22)),
                                            ),
                                            child: Center(
                                                child: Text(S.of(context).news,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12)))))),
                                Expanded(
                                    flex: 1,
                                    child: Image(
                                      image: R.image.btn_next_n(),
                                    ))
                              ],
                            )),
                      ),
                      Divider(
                        color: R.color.background_color(),
                        thickness: 1.0,
                        height: 1,
                      ),
                      SizedBox(
                        height: 48,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, (AboutPage).toString());
                            },
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Image(
                                      image: R.image.icon_about(),
                                    )),
                                Expanded(
                                    flex: 8,
                                    child: Text(S.of(context).me_item_about,
                                        style: TextStyle(
                                            color: R.color.text_gray_color()))),
                                Expanded(
                                    flex: 2,
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(appVersion,
                                            style: TextStyle(
                                                color:
                                                    R.color.text_blue_color(),
                                                fontSize: 12)))),
                                Expanded(
                                    flex: 1,
                                    child: Image(
                                      image: R.image.btn_next_n(),
                                    ))
                              ],
                            )),
                      ),
                    ],
                  ),
                )
              ]));
        }));
  }

  Widget _buildVipItem() {
    return BlocListener<MeBloc, MeState>(
        listener: (context, state) {},
        child: BlocBuilder<MeBloc, MeState>(builder: (context, state) {
          return Stack(
              fit: StackFit.loose,
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: SizedBox(
                      height: 48,
                      child: Row(
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Expanded(flex: 2, child: SizedBox()),
                          Expanded(
                              flex: 4,
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Text(S.of(context).me_get_vip,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: R.color.text_blue_color(),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)))),
                          Expanded(
                              flex: 1,
                              child: Center(
                                  child: OutlinedButton(
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(22)),
                                          ),
                                          side: BorderSide(
                                              color: R.color.btn_blue_color())),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed((PointsPage).toString());
                                      },
                                      child: Text(S.of(context).go,
                                          style: TextStyle(
                                              color: R.color.text_blue_color(),
                                              fontSize: 14))))),
                        ],
                      ),
                    )),
                Positioned.fill(
                    left: 50,
                    bottom: -5,
                    child: IgnorePointer(
                      ignoring: true,
                      //ignore pointer, otherwise go button will have no touch event
                      child: Image(
                        width: 100,
                        height: 77,
                        image: R.image.img_gift(),
                        alignment: Alignment.bottomLeft,
                      ),
                    )),
              ]);
        }));
  }
}
