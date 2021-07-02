import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/me/points/points_detail_bloc.dart';

import '../../r.dart';
import '../../s.dart';

class PointsDetailPage extends StatefulWidget {
  PointsDetailPage({Key? key}) : super(key: key);

  @override
  _PointsDetailPageState createState() => _PointsDetailPageState();
}

class _PointsDetailPageState extends State<PointsDetailPage> {
  late PointsDetailBloc _pointsDetailBloc;

  @override
  void initState() {
    super.initState();
    _pointsDetailBloc = BlocProvider.of<PointsDetailBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PointsDetailBloc, PointsDetailState>(
      listener: (context, state) {},
      child: BlocBuilder<PointsDetailBloc, PointsDetailState>(
          builder: (context, state) {
        return Scaffold(
            backgroundColor: R.color.background_color(),
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(S.of(context).points_detail_title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              leading: IconButton(
                icon: Icon(Icons.close, color: R.color.text_blue_color()),
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
    return BlocListener<PointsDetailBloc, PointsDetailState>(
        listener: (context, state) {},
        child: BlocBuilder<PointsDetailBloc, PointsDetailState>(
            builder: (context, state) {
          return ListView.separated(
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
    return BlocListener<PointsDetailBloc, PointsDetailState>(
        listener: (context, state) {},
        child: BlocBuilder<PointsDetailBloc, PointsDetailState>(
            builder: (context, state) {
          return Container(
              height: 64,
              padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Row(
                children: [
                  Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '2018-03-20 20:20',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: R.color.text_gray_color(), fontSize: 12),
                          ),
                          Text(
                            '新人注册',
                            textAlign: TextAlign.end,
                            style:
                                TextStyle(color: R.color.text_color_alpha80()),
                          )
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Text(
                        '+10',
                        textAlign: TextAlign.end,
                        style: TextStyle(color: R.color.text_blue_color()),
                      )),
                ],
              ));
        }));
  }
}
