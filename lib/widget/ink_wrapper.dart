import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qfvpn/r.dart';

class InkWrapper extends StatelessWidget {
  final Widget child;
  final GestureTapCallback onTap;
  final BorderRadius radius;

  InkWrapper({Key? key, required this.child, required this.onTap, required this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          color: R.color.home_card_shadow(), borderRadius: radius),
      child: InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: child,
      ),
    );
  }
}
