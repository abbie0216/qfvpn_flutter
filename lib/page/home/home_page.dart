import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:qfvpn/bloc/home/home_bloc.dart';
import 'package:qfvpn/bloc/home/home_state.dart';
import 'package:qfvpn/r.dart';
import 'package:qfvpn/s.dart';
import 'package:qfvpn/widget/ink_wrapper.dart';
import 'package:qfvpn/widget/stateful_image.dart';
import 'package:qfvpn/widget/vertical_marquee.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeLoadedState) {}
      },
      child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                /** bg full **/
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      R.color.home_bg_1_start(),
                      R.color.home_bg_1_end()
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
                ),
                /** bg half **/
                Container(
                    height: MediaQuery.of(context).size.height * 0.48,
                    decoration: BoxDecoration(
                      color: R.color.home_bg_2(),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(22)),
                    )),
                /** contents **/
                Column(
                  children: [
                    /** logo and share **/
                    Row(
                      children: [
                        Expanded(
                            child: ListTile(
                          leading: Image(image: R.image.ico_eye_1()),
                          title: Text(
                            'XXX VPN',
                            style: TextStyle(
                                color: R.color.home_primary_text(),
                                fontSize: 14),
                          ),
                        )), //
                        StatefulImage(
                          image: Image(image: R.image.btn_share_n()),
                          pressedImage: Image(image: R.image.btn_share_p()),
                          onPressed: () {},
                        )
                      ],
                    ),
                    /** announcement **/
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Card(
                        elevation: 3,
                        shadowColor: R.color.home_card_shadow(),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: SizedBox(
                          height: 40,
                          child: Padding(
                            padding: EdgeInsets.only(left: 12, right: 12),
                            child: Row(
                              children: [
                                Image(image: R.image.ico_broadcast()),
                                VerticalMarquee(values: [
                                  '公告内容公告内容公告内容公告内容1',
                                  '公告内容公告内容公告内容公告内容2',
                                  '公告内容公告内容公告内容公告内容3'
                                ])
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(flex: 3, child: Container()),
                    /** connect btn **/
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Align(
                          alignment: FractionalOffset(0.5, 0.42),
                          child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: ClipOval(
                                child: Container(
                              color: R.color.home_primary_text(),
                            )),
                          )),
                    ),
                    Expanded(flex: 3, child: Container()),
                    /** option btn **/
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Card(
                        elevation: 3,
                        shadowColor: R.color.home_card_shadow(),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Column(
                          children: [
                            InkWrapper(
                              onTap: () => showMaterialModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                  expand: false,
                                  context: context,
                                  builder: (context) => Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(22))))),
                              radius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 20, top: 22, bottom: 17, right: 11),
                                child: Row(children: [
                                  Text(
                                    S.of(context).home_option_title_mode,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: R.color
                                            .home_vpn_option_title_text()),
                                  ),
                                  Expanded(
                                      child: Text('智能加速',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: R.color
                                                  .home_vpn_option_value_text()))),
                                  Padding(
                                      padding: EdgeInsets.only(left: 4),
                                      child: Image(image: R.image.btn_next_n()))
                                ]),
                              ),
                            ),
                            Container(
                                color: R.color.home_vpn_option_divider(),
                                height: 1,
                                width: double.infinity),
                            InkWrapper(
                              onTap: () => showMaterialModalBottomSheet(
                                  expand: false,
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.9,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(22))),
                                      )),
                              radius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12)),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 20, top: 17, bottom: 22, right: 11),
                                child: Row(children: [
                                  Text(
                                    S.of(context).home_option_title_line,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: R.color
                                            .home_vpn_option_title_text()),
                                  ),
                                  Expanded(
                                      child: Text('日本-东京-2',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: R.color
                                                  .home_vpn_option_value_text()))),
                                  Padding(
                                      padding: EdgeInsets.only(left: 4),
                                      child: Image(image: R.image.btn_next_n()))
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(flex: 2, child: Container())
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
