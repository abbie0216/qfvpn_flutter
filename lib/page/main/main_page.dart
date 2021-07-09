import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:qfvpn/model/pref.dart';
import 'package:qfvpn/page/home/home_page.dart';
import 'package:qfvpn/page/me/me_page.dart';
import 'package:qfvpn/page/vip/vip_page.dart';
import 'package:qfvpn/r.dart';

import '../../s.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (pages.isEmpty) {
      pages = [HomePage(), VipPage(goToMainPage), MePage(goToMainPage)];
    }

    return Scaffold(
      backgroundColor: R.color.home_bg_2(),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: SizedBox(
        height: 56,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: R.color.home_bottom_nav_bar_bg_border(),
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(22))),
            ),
            Padding(
                padding: EdgeInsets.only(top: 1, left: 0.5, right: 0.5),
                child: Container(
                  decoration: BoxDecoration(
                      color: R.color.home_bottom_nav_bar_bg(),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(22))),
                )),
            BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                    icon: Image(image: R.image.ico_home_n()),
                    activeIcon: Image(image: R.image.ico_home_p()),
                    label: S.of(context).home_bottom_nav_bar_home),
                BottomNavigationBarItem(
                    icon: Image(image: R.image.ico_vip_n()),
                    activeIcon: Image(image: R.image.ico_vip_p()),
                    label: S.of(context).home_bottom_nav_bar_vip),
                BottomNavigationBarItem(
                    icon: Image(image: R.image.ico_my_n()),
                    activeIcon: Image(image: R.image.ico_my_p()),
                    label: S.of(context).home_bottom_nav_bar_me)
              ],
              fixedColor: R.color.home_bottom_nav_bar_selected_text(),
              unselectedItemColor:
                  R.color.home_bottom_nav_bar_unselected_text(),
              unselectedLabelStyle: TextStyle(fontSize: 12),
              selectedLabelStyle:
                  TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  void goToMainPage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

}
