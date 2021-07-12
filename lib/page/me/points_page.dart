import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/me/points/points_bloc.dart';
import 'package:qfvpn/model/api/bean/points/PointsInfoResp.dart';
import 'package:qfvpn/page/me/points_detail_page.dart';
import 'package:qfvpn/page/setting/binding_page.dart';
import 'package:qfvpn/page/share/share_page.dart';
import 'package:sprintf/sprintf.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../r.dart';
import '../../s.dart';

class PointsPage extends StatefulWidget {
  PointsPage({Key? key}) : super(key: key);

  @override
  _PointsPageState createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPage> {
  late PointsBloc _pointsBloc;

  @override
  void initState() {
    super.initState();
    _pointsBloc = BlocProvider.of<PointsBloc>(context);
    _pointsBloc.add(FetchInfoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PointsBloc, PointsState>(
      listener: (context, state) {},
      child: BlocBuilder<PointsBloc, PointsState>(builder: (context, state) {
        return Scaffold(
          backgroundColor: R.color.background_color(),
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(S.of(context).points_title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            leading: IconButton(
              icon:
                  Icon(Icons.arrow_back_ios, color: R.color.text_blue_color()),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              TextButton(
                  onPressed: () {},
                  child: Text(
                    S.of(context).points_rule,
                    style: TextStyle(color: Colors.black),
                  ))
            ],
            elevation: 0,
            backgroundColor: R.color.background_color(),
            centerTitle: true,
          ),
          body: _buildContentView(),
        );
      }),
    );
  }

  Widget _buildContentView() {
    return BlocListener<PointsBloc, PointsState>(
        listener: (context, state) {},
        child: BlocBuilder<PointsBloc, PointsState>(builder: (context, state) {
          return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  _buildCheckInRegion(),
                  _buildTasksRegion(),
                  Divider(height: 10, color: Colors.transparent),
                  _buildPointsExchangeRegion(),
                  Divider(height: 50, color: Colors.transparent)
                ],
              ));
        }));
  }

  Widget _buildCheckInRegion() {
    return BlocBuilder<PointsBloc, PointsState>(builder: (context, state) {
      Signin? checkInData;
      var points = 0;
      if (state is PointsInfoState) {
        checkInData = state.data.tasks.signin;
        points = state.data.usablePoint;
      }

      return Padding(
          padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
          child: Column(children: [
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Column(children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: '${checkInData == null ? '' : checkInData.periodContinueDays}',
                            style: TextStyle(
                                fontSize: 40,
                                color:
                                    R.color.text_blue_color().withAlpha(204))),
                        TextSpan(
                            text: S.of(context).day,
                            style: TextStyle(
                                fontSize: 12,
                                color: R.color.text_gray_color())),
                      ])),
                      Text(S.of(context).checked_in_continuously,
                          style: TextStyle(
                              fontSize: 12, color: R.color.text_gray_color()))
                    ])),
                Container(
                  width: 1,
                  color: R.color.divider_color(),
                  height: 50,
                ),
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, (PointsDetailPage).toString());
                        },
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(children: [
                                Text(points.toString(),
                                    style: TextStyle(
                                        fontSize: 40,
                                        color: R.color
                                            .text_blue_color()
                                            .withAlpha(204))),
                                Text(S.of(context).points,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: R.color.text_gray_color()))
                              ]),
                              Image(image: R.image.btn_next_n())
                            ])))
              ],
            ),
            Divider(height: 30, color: Colors.transparent),
            _buildTimeLine(),
            Divider(height: 30, color: Colors.transparent),
            _checkInButton(enable: checkInData == null? false : !checkInData.isTodaySignin , onPress: () {
              _pointsBloc.add(CheckInEvent());
            })
          ]));
    });
  }

  Widget _buildTimeLine() {
    return BlocBuilder<PointsBloc, PointsState>(builder: (context, state) {
      Signin? checkInData;
      if (state is PointsInfoState) {
        checkInData = state.data.tasks.signin;
      }
      return checkInData == null
          ? Container()
          : Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  List<Widget>.generate(checkInData.byDays.length, (int index) {
                var checked = checkInData!.byDays[index].isSignIn;
                var nextChecked = index < checkInData.byDays.length - 1
                    ? checkInData.byDays[index + 1].isSignIn
                    : false;
                // var checked = index <= 3;
                // var nextChecked = index < 3;
                if (index == 0) {
                  return Container(
                    constraints: BoxConstraints(
                        maxHeight: 60, minWidth: 40, maxWidth: 50),
                    child: TimelineTile(
                        isFirst: true,
                        axis: TimelineAxis.horizontal,
                        alignment: TimelineAlign.center,
                        startChild: Text(
                          checkInData.byDays[index].dayShort,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: R.color.text_gray_color(), fontSize: 12),
                        ),
                        indicatorStyle: IndicatorStyle(
                          width: 24,
                          height: 24,
                          // padding: EdgeInsets.only(top: 16, bottom: 8),
                          drawGap: true,
                          indicator: checked
                              ? Image(image: R.image.btn_radio_p())
                              : Container(
                                  decoration: BoxDecoration(
                                    color: checked
                                        ? R.color.timeline_checked_color()
                                        : R.color.timeline_base_color(),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '+${checkInData.byDays[index].point}',
                                      style: TextStyle(
                                        color: R.color.text_gray_color(),
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                        afterLineStyle: LineStyle(
                            color: nextChecked
                                ? R.color.timeline_checked_color()
                                : R.color.timeline_base_color(),
                            thickness: 2)),
                  );
                } else if (index == checkInData.byDays.length - 1) {
                  return Container(
                    constraints: BoxConstraints(
                        maxHeight: 60, minWidth: 40, maxWidth: 50),
                    child: TimelineTile(
                        isLast: true,
                        axis: TimelineAxis.horizontal,
                        alignment: TimelineAlign.center,
                        startChild: Text(
                          checkInData.byDays[index].dayShort,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: R.color.text_gray_color(), fontSize: 12),
                        ),
                        indicatorStyle: IndicatorStyle(
                          width: 24,
                          height: 24,
                          // padding: EdgeInsets.only(top: 16, bottom: 8),
                          drawGap: true,
                          indicator: checked
                              ? Image(image: R.image.btn_radio_p())
                              : Container(
                                  decoration: BoxDecoration(
                                    color: checked
                                        ? R.color.timeline_checked_color()
                                        : R.color.timeline_base_color(),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '+${checkInData.byDays[index].point}',
                                      style: TextStyle(
                                        color: R.color.text_gray_color(),
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                        // afterLineStyle: LineStyle(
                        //     color: R.color.timeline_base_color(),
                        //     thickness: 2),
                        beforeLineStyle: LineStyle(
                            color: checked
                                ? R.color.timeline_checked_color()
                                : R.color.timeline_base_color(),
                            thickness: 2)),
                  );
                } else {
                  return Container(
                    constraints: BoxConstraints(
                        maxHeight: 60, minWidth: 40, maxWidth: 50),
                    child: TimelineTile(
                        axis: TimelineAxis.horizontal,
                        alignment: TimelineAlign.center,
                        startChild: Text(
                          checkInData.byDays[index].dayShort,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: R.color.text_gray_color(), fontSize: 12),
                        ),
                        indicatorStyle: IndicatorStyle(
                          width: 24,
                          height: 24,
                          // padding: EdgeInsets.only(top: 16, bottom: 8),
                          drawGap: true,
                          indicator: checked
                              ? Image(image: R.image.btn_radio_p())
                              : Container(
                                  // margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: checked
                                        ? R.color.timeline_checked_color()
                                        : R.color.timeline_base_color(),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '+${checkInData.byDays[index].point}',
                                      style: TextStyle(
                                        color: R.color.text_gray_color(),
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                        afterLineStyle: LineStyle(
                            color: nextChecked
                                ? R.color.timeline_checked_color()
                                : R.color.timeline_base_color(),
                            thickness: 2),
                        beforeLineStyle: LineStyle(
                            color: checked
                                ? R.color.timeline_checked_color()
                                : R.color.timeline_base_color(),
                            thickness: 2)),
                  );
                }
              }),
            );
    });
  }

  Widget _buildTasksRegion() {
    return BlocBuilder<PointsBloc, PointsState>(builder: (context, state) {
      BindEmail? emailTasks;
      if (state is PointsInfoState) {
        emailTasks = state.data.tasks.bindEmail;
      }
      return Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              Text(S.of(context).points_task_title,
                  style: TextStyle(
                      color: R.color.text_gray_color(),
                      fontWeight: FontWeight.bold)),
              Divider(height: 10, color: Colors.transparent),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                              width: 40,
                              height: 40,
                              image: R.image.ico_mail_1(),
                              fit: BoxFit.fill),
                          Divider(height: 10, color: Colors.transparent),
                          Text(
                            sprintf(S.of(context).points_task_mail_msg,
                                [emailTasks == null ? 0 : emailTasks.point]),
                            style: TextStyle(
                                fontSize: 10, color: R.color.text_gray_color()),
                          ),
                          Divider(height: 10, color: Colors.transparent),
                          _bindingButton(
                              enable:
                                  emailTasks == null ? true : !emailTasks.isBind,
                              onPress: () {
                                Navigator.pushNamed(
                                    context, (BindingPage).toString());
                              })
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                              width: 40,
                              height: 40,
                              image: R.image.ico_handshake_1(),
                              fit: BoxFit.fill),
                          Divider(height: 10, color: Colors.transparent),
                          Text(
                            S.of(context).points_task_invite_msg,
                            style: TextStyle(
                                fontSize: 10, color: R.color.text_gray_color()),
                          ),
                          Divider(height: 10, color: Colors.transparent),
                          TextButton(
                            style: TextButton.styleFrom(
                              minimumSize: Size(130, 36),
                              backgroundColor: R.color.btn_blue_color(),
                              elevation: 2.0,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(22)),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, (SharePage).toString());
                            },
                            child: Text(S.of(context).to_invite,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14)),
                          )
                        ],
                      ))
                ],
              )
            ],
          ));
    });
  }

  Widget _buildPointsExchangeRegion() {
    return BlocListener<PointsBloc, PointsState>(
        listener: (context, state) {},
        child: BlocBuilder<PointsBloc, PointsState>(builder: (context, state) {
          return Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  Text(S.of(context).points_exchange_title,
                      style: TextStyle(
                          color: R.color.text_gray_color(),
                          fontWeight: FontWeight.bold)),
                  Divider(height: 10, color: Colors.transparent),
                  ListView.separated(
                    itemCount: 4,
                    //for test
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                    itemBuilder: (BuildContext context, int index) {
                      return _buildItem(index);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        height: 32,
                        thickness: 1.0,
                        color: R.color.background_color(),
                      );
                    },
                  )
                ],
              ));
        }));
  }

  Widget _buildItem(index) {
    return GestureDetector(
        onTap: () {},
        child: Row(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('VIP 1 天'),
            Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton(
                  style: TextButton.styleFrom(
                      minimumSize: Size(120, 36),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                      ),
                      side: BorderSide(color: R.color.btn_blue_color())),
                  onPressed: () {},
                  child: Text('10 积分兑换',
                      style: TextStyle(
                          color: R.color.text_blue_color(), fontSize: 14)),
                ))
          ],
        ));
  }

  Widget _checkInButton({enable, onPress}) {
    if (enable) {
      return TextButton(
        style: TextButton.styleFrom(
          minimumSize: Size(155, 44),
          backgroundColor: R.color.btn_blue_color(),
          elevation: 2.0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(22)),
          ),
        ),
        onPressed: onPress,
        child: Text(S.of(context).check_in,
            style: TextStyle(color: Colors.white, fontSize: 14)),
      );
    } else {
      return IgnorePointer(
          ignoring: true,
          child: OutlinedButton(
            style: TextButton.styleFrom(
                minimumSize: Size(155, 44),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                ),
                side: BorderSide(color: R.color.hint_color_light_bg())),
            onPressed: onPress,
            child: Text(S.of(context).check_in_already,
                style: TextStyle(
                    color: R.color.hint_color_light_bg(), fontSize: 14)),
          ));
    }
  }

  Widget _bindingButton({enable, onPress}) {
    if (enable) {
      return TextButton(
        style: TextButton.styleFrom(
          minimumSize: Size(130, 36),
          backgroundColor: R.color.btn_blue_color(),
          elevation: 2.0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(22)),
          ),
        ),
        onPressed: onPress,
        child: Text(S.of(context).setting_item_hint_binding,
            style: TextStyle(color: Colors.white, fontSize: 14)),
      );
    } else {
      return IgnorePointer(
          ignoring: true,
          child: OutlinedButton(
            style: TextButton.styleFrom(
                minimumSize: Size(130, 36),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                ),
                side: BorderSide(color: R.color.hint_color_light_bg())),
            onPressed: onPress,
            child: Text(S.of(context).setting_item_hint_bound,
                style: TextStyle(
                    color: R.color.hint_color_light_bg(), fontSize: 14)),
          ));
    }
  }
}
