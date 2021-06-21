import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../r.dart';

class VipPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: R.color.home_bg_2(),
        child: Center(child: Text('vip page')),
      ),
    );
  }
}
