import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qfvpn/bloc/vip/order_history_bloc.dart';

import '../../r.dart';

class OrderHistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderHistoryBloc, OrderHistoryState>(
      listener: (context, state){},
      child: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: R.color.login_bg_color(),
            body: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image(
                    image: R.image.img_login_bg(),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
                Align(
                  alignment: FractionalOffset(0.5, 0.3),
                  child: Container(
                    width: 105,
                    height: 105,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFFCFD1FF)),
                    child: Center(
                        child: FlutterLogo(
                          size: 60,
                        )),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}