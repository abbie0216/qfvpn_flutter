import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/home/home_bloc.dart';
import 'package:qfvpn/bloc/home/home_state.dart';
import 'package:qfvpn/r.dart';
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
                    colors: [Color(0xffe2ecf5), Color(0xffe8f1fa)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
                ),
                /** bg half **/
                Column(
                  children: [
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                        flex: 5,
                        child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                            child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                              colors: [Color(0xfff4f6f9), Color(0xfff6faff)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )))))
                  ],
                ),
                /** contents **/
                Column(
                  children: [
                    /** logo and share **/
                    Padding(
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: [
                            Expanded(
                                child: ListTile(
                              leading: Image(image: R.image.ico_eye_1()),
                              title: Text(
                                'XXX VPN',
                                style: TextStyle(
                                    color: R.color.home_logo_text(), fontSize: 14),
                              ),
                            )), //
                            StatefulImage(
                              image: Image(image: R.image.btn_share_n()),
                              pressedImage: Image(image: R.image.btn_share_p()),
                              onPressed: () {},
                            )
                          ],
                        )),
                    /** announcement **/
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Card(
                        elevation: 3,
                        shadowColor: R.color.home_announce_bg_shadow(),
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
                                VerticalMarquee(values: ['公告内容公告内容公告内容公告内容1', '公告内容公告内容公告内容公告内容2', '公告内容公告内容公告内容公告内容3'])
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: Container())
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
