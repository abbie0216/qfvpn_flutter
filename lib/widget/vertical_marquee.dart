import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:qfvpn/r.dart';

class VerticalMarquee extends StatelessWidget {
  final List<String> values;

  VerticalMarquee({Key? key, required this.values}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      height: 40,
      child: Padding(
        padding: EdgeInsets.only(left: 8),
        child: CarouselSlider(
          options: CarouselOptions(
              autoPlay: true,
              autoPlayAnimationDuration: Duration(seconds: 1),
              scrollDirection: Axis.vertical),
          items: values.map((info) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  child: _carouselItemView(info),
                );
              },
            );
          }).toList(),
        ),
      ),
    ));
  }

  Widget _carouselItemView(String info) {
    return Container(
      child: Text(
        info,
        style: TextStyle(
            fontSize: 14,
            decorationColor: Colors.white,
            color: R.color.home_announce_text()),
      ),
    );
  }
}
