import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/login/forgot_pw_bloc.dart';
import 'package:qfvpn/bloc/me/me_bloc.dart';
import 'package:qfvpn/page/setting/binding_page.dart';
import 'package:qfvpn/page/setting/setting_page.dart';

import '../../r.dart';
import '../../s.dart';
import 'coupon_page.dart';

class MePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  late MeBloc _meBloc;

  @override
  void initState() {
    super.initState();
    _meBloc = BlocProvider.of<MeBloc>(context);
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
              IconButton(
                  icon: Image(image: R.image.btn_setting_n()),
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
    return BlocListener<MeBloc, MeState>(
        listener: (context, state) {},
        child: BlocBuilder<MeBloc, MeState>(builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.18,
            decoration: BoxDecoration(
              color: R.color.me_title_block_bg_color(),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(60)),
            ),
            child: Align(
                alignment: FractionalOffset(0.2, 0.2),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: R.color.background_color()),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        S.of(context).me_vip_time_label + '-',
                        style: TextStyle(color: R.color.text_blue_color()),
                      ),
                      SizedBox(height: 8),
                      Text(
                        S.of(context).me_id_label + '-',
                        style: TextStyle(color: Colors.black.withAlpha(51)),
                      )
                    ],
                  )
                ])),
          );
        }));
  }

  Widget _buildMailCouponButtons() {
    return BlocListener<MeBloc, MeState>(
        listener: (context, state) {},
        child: BlocBuilder<MeBloc, MeState>(builder: (context, state) {
          return Positioned(
              top: MediaQuery.of(context).size.height * 0.18 - 24,
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
                        Navigator.of(context)
                            .pushNamed((BindingPage).toString());
                      },
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image(image: R.image.icon_link()),
                            Text(S.of(context).me_bind_mail,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14)),
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
                    onPressed: () {
                      Navigator.of(context).pushNamed((CouponPage).toString());
                    },
                    child: Text(S.of(context).me_coupon,
                        style: TextStyle(color: Colors.white, fontSize: 14)),
                  )
                ],
              ));
        }));
  }

  Widget _buildItemsRegion() {
    return BlocListener<MeBloc, MeState>(
        listener: (context, state) {},
        child: BlocBuilder<MeBloc, MeState>(builder: (context, state) {
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
                            onTap: () {},
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Image(
                                      image: R.image.icon_notice(),
                                    )),
                                Expanded(
                                    flex: 10,
                                    child: Row(children: [
                                      Text(S.of(context).me_item_my_info,
                                          style: TextStyle(
                                              color:
                                                  R.color.text_gray_color())),
                                      Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 5),
                                          child: Icon(Icons.circle,
                                              color: Colors.red, size: 5))
                                    ])),
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
                            onTap: () {},
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
                            onTap: () {},
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
                            onTap: () {},
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
                                        child: Text('v1.3.0',
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
                                        // Navigator.of(context)
                                        //     .pushNamed((CouponPage).toString());
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
