import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qfvpn/r.dart';

class ProgressPainter extends CustomPainter{

  double radius = 0;

  ProgressPainter({required this.radius}) : super();

  double degToRad(num deg) => deg * (pi / 180.0);
  double radToDeg(num rad) => rad * (180.0 / pi);

  @override
  void paint(Canvas canvas, Size size) {
    final angle = 360.0 * 0.95;
    final progressWidth = 12.0;
    final radians = degToRad(angle);
    final arcRect = Rect.fromCircle(center: Offset(0,0), radius: radius);
    final Gradient gradient = SweepGradient(
      endAngle: radians,
      colors: [
        Colors.transparent,
        R.color.home_vpn_connect_btn_anim_progress_end(),
        R.color.home_vpn_connect_btn_anim_progress_start(),
      ],
    );
    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = progressWidth
      ..shader = gradient.createShader(arcRect);
    final offset = asin(progressWidth * 0.5 / radius);
    canvas.drawArc(arcRect, offset, degToRad(angle)-offset, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}