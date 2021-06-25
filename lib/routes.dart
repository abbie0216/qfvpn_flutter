import 'package:flutter/widgets.dart';
import 'package:qfvpn/page/login/forgot_pw_page.dart';
import 'package:qfvpn/page/login/login_page.dart';
import 'package:qfvpn/page/login/register_page.dart';
import 'package:qfvpn/page/main/main_page.dart';
import 'package:qfvpn/page/me/coupon_page.dart';
import 'package:qfvpn/page/me/news_detail_page.dart';
import 'package:qfvpn/page/me/news_page.dart';
import 'package:qfvpn/page/me/points_page.dart';
import 'package:qfvpn/page/setting/binding_page.dart';
import 'package:qfvpn/page/setting/pw_change_page.dart';
import 'package:qfvpn/page/setting/setting_page.dart';
import 'package:qfvpn/page/share/share_page.dart';
import 'package:qfvpn/page/sharedetail/share_detail_page.dart';
import 'package:qfvpn/page/splash/splash_page.dart';

final Map<String, WidgetBuilder> routes = {
  (SplashPage).toString(): (context) => SplashPage(),
  (LoginPage).toString(): (context) => LoginPage(),
  (RegisterPage).toString(): (context) => RegisterPage(),
  (ForgotPwPage).toString(): (context) => ForgotPwPage(),
  (MainPage).toString(): (context) => MainPage(),
  (SettingPage).toString(): (context) => SettingPage(),
  (BindingPage).toString(): (context) => BindingPage(),
  (PwChangePage).toString(): (context) => PwChangePage(),
  (CouponPage).toString(): (context) => CouponPage(),
  (NewsPage).toString(): (context) => NewsPage(),
  (NewsDetailPage).toString(): (context) => NewsDetailPage(),
  (PointsPage).toString(): (context) => PointsPage(),
  (SharePage).toString(): (context) => SharePage(),
  (ShareDetailPage).toString(): (context) => ShareDetailPage(),
};
