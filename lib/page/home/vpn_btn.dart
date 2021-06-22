import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:qfvpn/r.dart';
import 'package:qfvpn/s.dart';
import 'package:sprintf/sprintf.dart';
import 'vpn_btn_progress_anim.dart';

class VpnBtn extends StatefulWidget {
  VpnBtn({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VpnBtnState();
}

enum BtnState { INIT, CONNECTING, CONNECTED }

class _VpnBtnState extends State<VpnBtn> with TickerProviderStateMixin {
  BtnState _btnState = BtnState.INIT;
  late AnimationController _progressAnimController;
  late Animation<num> _progressAnim;
  late AnimationController _blueDotAnimController;
  late Animation<double> _blueDotAnim;
  late Animation<double> _redDotAnim;
  late Timer _testConnectingTimer;
  late Timer _connectedTimer;
  int _connectedSeconds = 0;

  @override
  void initState() {
    _progressAnimController =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..repeat();
    _progressAnim =
        Tween(begin: 0, end: 2 * pi).animate(_progressAnimController);
    _blueDotAnimController =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..repeat(reverse: true);
    _blueDotAnim = Tween(begin: 1.0, end: 0.0).animate(_blueDotAnimController);
    _redDotAnim = Tween(begin: 0.0, end: 1.0).animate(_blueDotAnimController);
    super.initState();
  }

  @override
  void dispose() {
    _progressAnimController.dispose();
    _blueDotAnimController.dispose();
    if (_testConnectingTimer.isActive) _testConnectingTimer.cancel();
    if (_connectedTimer.isActive) _connectedTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          switch (_btnState) {
            case BtnState.INIT:
              setState(() {
                _btnState = BtnState.CONNECTING;
                _testConnectingTimer = Timer(Duration(seconds: 2), () {
                  setState(() {
                    _btnState = BtnState.CONNECTED;
                    _connectedTimer =
                        Timer.periodic(Duration(seconds: 1), (timer) {
                      setState(() {
                        _connectedSeconds++;
                      });
                    });
                  });
                });
              });
              break;
            case BtnState.CONNECTING:
              setState(() {
                if (_testConnectingTimer.isActive) {
                  _testConnectingTimer.cancel();
                }
                _btnState = BtnState.INIT;
              });
              break;
            case BtnState.CONNECTED:
              setState(() {
                if (_connectedTimer.isActive) {
                  _connectedTimer.cancel();
                  _connectedSeconds = 0;
                }
                _btnState = BtnState.INIT;
              });
              break;
          }
        },
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            if (child.key == ValueKey<int>(2)) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            } else {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            }
          },
          child: buildByBtnState(),
        ),
      ),
    );
  }

  Widget buildByBtnState() {
    switch (_btnState) {
      case BtnState.INIT:
        return Container(
            key: ValueKey<int>(0),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 10),
                      blurRadius: 15,
                      spreadRadius: 1)
                ],
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [
                  R.color.home_vpn_connect_btn_bg_start(),
                  R.color.home_vpn_connect_btn_bg_end()
                ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: Stack(
              children: [
                Center(
                  child: Image(image: R.image.ico_power_big()),
                ),
                Align(
                    alignment: FractionalOffset(0.5, 0.75),
                    child: Text(
                      S.of(context).home_vpn_connect_btn_click_hint,
                      style: TextStyle(
                          color: R.color.home_vpn_connect_btn_click_text(),
                          fontSize: 16),
                    ))
              ],
            ));
      case BtnState.CONNECTING:
        return Container(
            key: ValueKey<int>(1),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 10),
                      blurRadius: 15,
                      spreadRadius: 1)
                ],
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [
                  R.color.home_vpn_connect_btn_bg_start(),
                  R.color.home_vpn_connect_btn_bg_end()
                ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      gradient: RadialGradient(colors: [
                        R.color.home_vpn_connect_btn_inner_bg_start(),
                        R.color.home_vpn_connect_btn_inner_bg_end()
                      ], radius: 1.5, center: FractionalOffset(0.2, 0.2)),
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: R.color.home_vpn_connect_btn_inner_bg_border(),
                          width: 2)),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Align(
                          alignment: FractionalOffset(0.5, 0.25),
                          child: Text(
                            S.of(context).home_vpn_connect_btn_connecting_hint,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: R.color
                                    .home_vpn_connect_btn_connecting_hint_text()),
                          )),
                      Align(
                        alignment: FractionalOffset(0.5, 0.5),
                        child: Text(
                          S
                              .of(context)
                              .home_vpn_connect_btn_connecting_time_default,
                          style: TextStyle(
                              letterSpacing: 2,
                              fontSize: 30,
                              color: R.color
                                  .home_vpn_connect_btn_connecting_time_text()),
                        ),
                      ),
                      Align(
                        alignment: FractionalOffset(0.5, 0.9),
                        child: Image(image: R.image.ico_power()),
                      )
                    ],
                  ),
                )
              ],
            ));
      case BtnState.CONNECTED:
        return Container(
            key: ValueKey<int>(2),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 10),
                      blurRadius: 15,
                      spreadRadius: 1)
                ],
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [
                  R.color.home_vpn_connect_btn_bg_start(),
                  R.color.home_vpn_connect_btn_bg_end()
                ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: Stack(children: [
              /** bg **/
              Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    gradient: RadialGradient(colors: [
                      R.color.home_vpn_connect_btn_inner_bg_start(),
                      R.color.home_vpn_connect_btn_inner_bg_end()
                    ], radius: 1.5, center: FractionalOffset(0.2, 0.2)),
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: R.color.home_vpn_connect_btn_inner_bg_border(),
                        width: 2)),
              ),
              /** content **/
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Align(
                        alignment: FractionalOffset(0.5, 0.25),
                        child: Text(
                          S.of(context).home_vpn_connect_btn_connected_hint,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: R.color
                                  .home_vpn_connect_btn_connected_hint_text()),
                        )),
                    Align(
                      alignment: FractionalOffset(0.5, 0.5),
                      child: Text(
                        buildConnectedTime(),
                        style: TextStyle(
                            letterSpacing: 2,
                            fontSize: 30,
                            color: R.color
                                .home_vpn_connect_btn_connected_time_text()),
                      ),
                    ),
                    Align(
                      alignment: FractionalOffset(0.5, 0.9),
                      child: Image(image: R.image.ico_power()),
                    )
                  ],
                ),
              ),
              /** progress anim **/
              Container(
                alignment: Alignment.center,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return AnimatedBuilder(
                      animation: _progressAnim,
                      builder: (_, child) {
                        return Transform.rotate(
                          angle: _progressAnim.value.toDouble(),
                          child: child,
                        );
                      },
                      child: CustomPaint(
                          painter: ProgressPainter(
                              radius: constraints.maxWidth / 2 - 14)),
                    );
                  },
                ),
              ),
              /** top dot anim **/
              Container(
                padding: EdgeInsets.zero,
                alignment: Alignment.topCenter,
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return FadeTransition(
                    opacity: _blueDotAnim,
                    child: Container(
                        height: constraints.maxWidth / 2.5,
                        width: constraints.maxWidth / 2.5,
                        decoration: BoxDecoration(
                            gradient: RadialGradient(colors: [
                              R.color.home_vpn_connect_btn_anim_top_dot_1(),
                              R.color.home_vpn_connect_btn_anim_top_dot_2()
                            ]),
                            shape: BoxShape.circle)),
                  );
                }),
              ),
              /** bottom dot anim **/
              Container(
                alignment: Alignment.bottomCenter,
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return FadeTransition(
                    opacity: _redDotAnim,
                    child: Container(
                        height: constraints.maxWidth / 2.5,
                        width: constraints.maxWidth / 2.5,
                        decoration: BoxDecoration(
                            gradient: RadialGradient(colors: [
                              R.color.home_vpn_connect_btn_anim_bottom_dot_1(),
                              R.color.home_vpn_connect_btn_anim_bottom_dot_2()
                            ]),
                            shape: BoxShape.circle)),
                  );
                }),
              )
            ]));
    }
  }

  String buildConnectedTime() {
    var hours = _connectedSeconds ~/ 3600;
    var minutes = _connectedSeconds % 3600 ~/ 60;
    var seconds = (_connectedSeconds % 60).toInt();
    return sprintf('%02i:%02i:%02i', [hours, minutes, seconds]);
  }
}
