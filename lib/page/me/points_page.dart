import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/me/points/points_bloc.dart';
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
    return BlocListener<PointsBloc, PointsState>(
        listener: (context, state) {},
        child: BlocBuilder<PointsBloc, PointsState>(builder: (context, state) {
          return ListView.separated(
            itemCount: 12, //for test
            padding: const EdgeInsets.fromLTRB(28, 10, 28, 10),
            itemBuilder: (BuildContext context, int index) {
              return Container();
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

}
