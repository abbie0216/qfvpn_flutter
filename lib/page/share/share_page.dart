import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qfvpn/bloc/share/share_bloc.dart';
import 'package:qfvpn/model/api/bean/invite/invite_info_resp.dart';
import 'package:qfvpn/page/sharedetail/share_detail_page.dart';
import 'package:qfvpn/r.dart';
import 'package:qfvpn/s.dart';
import 'package:qfvpn/widget/selector_widget_button.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeline_tile/timeline_tile.dart';

class SharePage extends StatefulWidget {
  SharePage({Key? key}) : super(key: key);

  @override
  _SharePageState createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  late ShareBloc _shareBloc;
  GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _shareBloc = BlocProvider.of<ShareBloc>(context);
    _shareBloc.add(ShareInfoFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShareBloc, ShareState>(
        listener: (context, state) {},
        child: BlocBuilder<ShareBloc, ShareState>(builder: (context, state) {
          return Theme(
              data: ThemeData(primaryColor: R.color.share_app_bar_bg()),
              child: Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    leading: SelectorWidgetButton(
                      widgetN: Image(image: R.image.btn_back_white_n()),
                      widgetP: Image(image: R.image.btn_back_white_p()),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    actions: [
                      state is LoadedState
                          ? TextButton(
                              style: ButtonStyle(
                                  splashFactory: NoSplash.splashFactory,
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.only(left: 16, right: 16))),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ShareDetailPage(state.result);
                                }));
                              },
                              child: Text(
                                S.of(context).share_invite_detail_btn,
                                style: TextStyle(
                                    color:
                                        R.color.share_invite_detail_btn_text()),
                              ))
                          : Container()
                    ],
                  ),
                  body: SafeArea(
                      child: state is LoadedState
                          ? Container(
                              color: R.color.share_bg_bottom(),
                              child: NotificationListener<
                                  OverscrollIndicatorNotification>(
                                onNotification: (OverscrollIndicatorNotification
                                    overScroll) {
                                  overScroll.disallowGlow();
                                  return false;
                                },
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      _buildInviteCodeTopImage(),
                                      _buildInviteCodeInfo(state.result),
                                      _buildInviteButtons(state.result),
                                      _buildInviteRule()
                                    ],
                                  ),
                                ),
                              ))
                          : Container())));
        }));
  }

  Widget _buildInviteCodeTopImage() {
    return Stack(
      children: [
        Container(
          color: R.color.share_bg_top(),
          height: 178,
        ),
        Container(
            height: 230,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                      decoration: BoxDecoration(
                          color: R.color.share_top_rec_bg(),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16)))),
                ),
              ],
            )),
        Container(
          width: double.infinity,
          child: Image(
            image: R.image.img_earnpoint(),
            height: 230,
            width: 320,
          ),
        )
      ],
    );
  }

  Widget _buildInviteCodeInfo(InviteInfoResp inviteInfo) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
            color: R.color.share_top_rec_bg(),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16))),
        child: Column(
          children: [
            /** qr code **/
            RepaintBoundary(
              key: globalKey,
              child: Container(
                margin: EdgeInsets.only(top: 16, bottom: 30),
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                    color: R.color.share_top_rec_bg(),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: R.color.share_qr_code_border())),
                child: QrImage(
                  data: inviteInfo.inviteUrl ?? '',
                ),
              ),
            ),
            /** earn point hint **/
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: R.image.ico_emoji_1()),
                Padding(
                  padding: EdgeInsets.only(left: 4, right: 4),
                  child: Text(
                    S.of(context).share_earn_point_hint,
                    style: TextStyle(
                        color: R.color.share_earn_point_hint_text(),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Image(image: R.image.ico_emoji_2())
              ],
            ),
            /** invite code **/
            Container(
                margin:
                    EdgeInsets.only(top: 20, bottom: 12, left: 12, right: 12),
                padding:
                    EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: R.color.share_invite_code_bg()),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(bottom: 2),
                            child: Text(
                              S.of(context).share_invite_code_title,
                              style: TextStyle(
                                  color: R.color.share_invite_code_title_text(),
                                  fontSize: 12),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              inviteInfo.inviteCode ?? '',
                              style: TextStyle(
                                  color: R.color.share_invite_code_text(),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )),
                      ElevatedButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(
                                  text: inviteInfo.inviteCode ?? ''))
                              .then((value) {
                            //todo fix snack bar style
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(S.of(context).share_copy_toast)));
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              return R.color.share_copy_btn_bg();
                            }),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                        child: Text(
                          S.of(context).share_copy_btn,
                          style: TextStyle(
                              color: R.color.share_copy_btn_text(),
                              fontSize: 14),
                        ),
                      )
                    ])),
          ],
        ));
  }

  Widget _buildInviteButtons(InviteInfoResp inviteInfo) {
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 16, left: 20, right: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              flex: 15,
              child: ElevatedButton(
                onPressed: () {
                  _onShare(context, inviteInfo.inviteUrl ?? '');
                },
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        EdgeInsets.only(top: 11, bottom: 11)),
                    backgroundColor: MaterialStateProperty.all(
                        R.color.share_invite_btn_bg()),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)))),
                child: Text(
                  S.of(context).share_invite_imm_btn,
                  style: TextStyle(
                      color: R.color.share_invite_btn_text(),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              )),
          Spacer(),
          Expanded(
              flex: 15,
              child: OutlinedButton(
                onPressed: () {
                  _saveQrCode();
                },
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                        R.color.share_download_btn_splash()),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.only(top: 11, bottom: 11)),
                    side: MaterialStateProperty.all(BorderSide(
                        color: R.color.share_download_btn_bg(), width: 1)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)))),
                child: Text(
                  S.of(context).share_download_qr_code_btn,
                  style: TextStyle(
                      color: R.color.share_download_btn_text(),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ))
        ],
      ),
    );
  }

  Widget _buildInviteRule() {
    return Container(
      padding: EdgeInsets.only(top: 16, left: 12, right: 12, bottom: 12),
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          gradient: LinearGradient(
            colors: [
              R.color.share_bottom_rec_bg_start(),
              R.color.share_bottom_rec_bg_end()
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          )),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: Text(
              S.of(context).share_invite_rule_title,
              style: TextStyle(
                  fontSize: 16,
                  color: R.color.share_rule_text(),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: BoxConstraints(maxHeight: 120, minWidth: 100),
                child: TimelineTile(
                    isFirst: true,
                    axis: TimelineAxis.horizontal,
                    alignment: TimelineAlign.start,
                    endChild: Text(
                      S.of(context).share_invite_rule_indicator_1_desc,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: R.color.share_rule_text(), fontSize: 14),
                    ),
                    indicatorStyle: IndicatorStyle(
                      width: 42,
                      height: 42,
                      padding: EdgeInsets.only(top: 16, bottom: 8),
                      drawGap: true,
                      indicator: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: R.color.share_rule_indicator_bg(),
                          border: Border.all(
                              color: R.color.share_rule_indicator_border(),
                              width: 2),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            S.of(context).share_invite_rule_indicator_1,
                            style: TextStyle(
                              color: R.color.share_rule_text(),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    afterLineStyle: LineStyle(
                        color: R.color.share_rule_indicator_border(),
                        thickness: 2)),
              ),
              Container(
                constraints: BoxConstraints(maxHeight: 120, minWidth: 100),
                child: TimelineTile(
                    axis: TimelineAxis.horizontal,
                    alignment: TimelineAlign.start,
                    endChild: Text(
                      S.of(context).share_invite_rule_indicator_2_desc,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: R.color.share_rule_text(), fontSize: 14),
                    ),
                    indicatorStyle: IndicatorStyle(
                      width: 42,
                      height: 42,
                      padding: EdgeInsets.only(top: 16, bottom: 8),
                      drawGap: true,
                      indicator: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: R.color.share_rule_indicator_bg(),
                          border: Border.all(
                              color: R.color.share_rule_indicator_border(),
                              width: 2),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            S.of(context).share_invite_rule_indicator_2,
                            style: TextStyle(
                              color: R.color.share_rule_text(),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    afterLineStyle: LineStyle(
                        color: R.color.share_rule_indicator_border(),
                        thickness: 2),
                    beforeLineStyle: LineStyle(
                        color: R.color.share_rule_indicator_border(),
                        thickness: 2)),
              ),
              Container(
                constraints: BoxConstraints(maxHeight: 120, minWidth: 100),
                child: TimelineTile(
                    isLast: true,
                    axis: TimelineAxis.horizontal,
                    alignment: TimelineAlign.start,
                    endChild: Text(
                      S.of(context).share_invite_rule_indicator_3_desc,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: R.color.share_rule_text(), fontSize: 14),
                    ),
                    indicatorStyle: IndicatorStyle(
                      width: 42,
                      height: 42,
                      padding: EdgeInsets.only(top: 16, bottom: 8),
                      drawGap: true,
                      indicator: Container(
                        margin: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color:
                                  R.color.share_rule_indicator_border_shadow(),
                              width: 4),
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: R.color.share_rule_indicator_border(),
                                width: 2),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Image(
                              image: R.image.ico_step_gift(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    afterLineStyle: LineStyle(
                        color: R.color.share_rule_indicator_border(),
                        thickness: 2),
                    beforeLineStyle: LineStyle(
                        color: R.color.share_rule_indicator_border(),
                        thickness: 2)),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.only(top: 16, bottom: 16, left: 20, right: 20),
            decoration: BoxDecoration(
                color: R.color.share_rule_hint_bg(),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Text(
                    S.of(context).share_invite_rule_hint_title,
                    style: TextStyle(
                        fontSize: 14,
                        color: R.color.share_rule_hint_title_text(),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  width: double.infinity,
                  child: Text(
                    S.of(context).share_invite_rule_hint_content,
                    style: TextStyle(
                        color: R.color.share_rule_hint_desc_text(),
                        fontSize: 12),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _onShare(BuildContext context, String inviteUrl) async =>
      await Share.share(inviteUrl);

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  Future<void> _saveQrCode() async {
    try {
      if (await _requestPermission(Permission.storage)) {
        var boundary = globalKey.currentContext!.findRenderObject();
        var image = await (boundary as RenderRepaintBoundary).toImage();
        var byteData = await image.toByteData(format: ImageByteFormat.png);
        var pngBytes = byteData?.buffer.asUint8List();
        if (pngBytes != null) {
          var now = DateTime.now();
          var formattedDate = DateFormat('yyyyMMdd').format(now);
          final result = await ImageGallerySaver.saveImage(pngBytes,
              name: 'invite-code($formattedDate)');
          print(result);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
