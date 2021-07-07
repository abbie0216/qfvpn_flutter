import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/home/home_bloc.dart';
import 'package:qfvpn/bloc/home/home_state.dart';
import 'package:qfvpn/page/home/option_btn.dart';
import 'package:qfvpn/page/home/vpn_btn.dart';
import 'package:qfvpn/page/share/share_page.dart';
import 'package:qfvpn/r.dart';
import 'package:qfvpn/widget/selector_widget_button.dart';
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
      listener: (context, state) {},
      child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        return Theme(
          data: ThemeData(primaryColor: R.color.home_app_bar_bg()),
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Row(children: [
                Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Image(image: R.image.ico_eye_1())),
                Expanded(
                    child: Text(
                  'XXX VPN',
                  style: TextStyle(
                      color: R.color.home_primary_text(),
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ))
              ]),
              actions: [
                SelectorWidgetButton(
                  widgetN: Image(image: R.image.btn_share_n()),
                  widgetP: Image(image: R.image.btn_share_p()),
                  onPressed: () {
                    Navigator.of(context).pushNamed((SharePage).toString());
                  },
                )
              ],
            ),
            body: SafeArea(
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  _buildBgFull(),
                  _buildBgHalf(),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _buildAnnouncement(),
                      Spacer(flex: 4),
                      _buildVpnBtn(),
                      Spacer(flex: 4),
                      _buildOptionBtn(),
                      Spacer(flex: 2)
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildBgFull() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [R.color.home_bg_1_start(), R.color.home_bg_1_end()],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
    );
  }

  Widget _buildBgHalf() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.48,
        decoration: BoxDecoration(
          color: R.color.home_bg_2(),
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ));
  }

  Widget _buildAnnouncement() {
    return Expanded(
        flex: 2,
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Card(
            elevation: 3,
            shadowColor: R.color.home_card_shadow(),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
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
        ));
  }

  Widget _buildVpnBtn() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Align(
          alignment: FractionalOffset(0.5, 0.42),
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: VpnBtn(),
          )),
    );
  }

  Widget _buildOptionBtn() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: OptionBtn(),
    );
  }
}
