import 'package:flutter/widgets.dart';
import 'package:qfvpn/page/login/forgot_pw_page.dart';
import 'package:qfvpn/page/login/login_page.dart';
import 'package:qfvpn/page/login/register_page.dart';
import 'package:qfvpn/page/main/main_page.dart';
import 'package:qfvpn/page/share/share_page.dart';
import 'package:qfvpn/page/sharedetail/share_detail_page.dart';
import 'package:qfvpn/page/splash/splash_page.dart';

final Map<String, WidgetBuilder> routes = {
  (SplashPage).toString(): (context) => SplashPage(),
  (LoginPage).toString(): (context) => LoginPage(),
  (RegisterPage).toString(): (context) => RegisterPage(),
  (ForgotPwPage).toString(): (context) => ForgotPwPage(),
  (MainPage).toString(): (context) => MainPage(),
  (SharePage).toString(): (context) => SharePage(),
  (ShareDetailPage).toString(): (context) => ShareDetailPage(),
};
