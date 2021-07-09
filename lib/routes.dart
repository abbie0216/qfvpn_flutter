import 'package:flutter/widgets.dart';
import 'package:qfvpn/page/feedback/add_feedback_page.dart';
import 'package:qfvpn/page/feedback/feedback_detail_page.dart';
import 'package:qfvpn/page/feedback/feedback_list_page.dart';
import 'package:qfvpn/page/login/forgot_pw_page.dart';
import 'package:qfvpn/page/login/login_page.dart';
import 'package:qfvpn/page/login/register_page.dart';
import 'package:qfvpn/page/main/main_page.dart';
import 'package:qfvpn/page/me/about_page.dart';
import 'package:qfvpn/page/me/coupon_page.dart';
import 'package:qfvpn/page/me/news_detail_page.dart';
import 'package:qfvpn/page/me/news_page.dart';
import 'package:qfvpn/page/me/points_detail_page.dart';
import 'package:qfvpn/page/me/points_page.dart';
import 'package:qfvpn/page/pay/pay_page.dart';
import 'package:qfvpn/page/setting/binding_page.dart';
import 'package:qfvpn/page/setting/pw_change_page.dart';
import 'package:qfvpn/page/setting/setting_page.dart';
import 'package:qfvpn/page/share/share_page.dart';
import 'package:qfvpn/page/sharedetail/share_detail_page.dart';
import 'package:qfvpn/page/splash/splash_page.dart';
import 'package:qfvpn/page/vip/order_history_page.dart';

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
  (PointsDetailPage).toString(): (context) => PointsDetailPage(),
  (SharePage).toString(): (context) => SharePage(),
  (ShareDetailPage).toString(): (context) => ShareDetailPage(),
  (FeedbackListPage).toString(): (context) => FeedbackListPage(),
  (OrderHistoryPage).toString(): (context) => OrderHistoryPage(),
  (AddFeedbackPage).toString(): (context) => AddFeedbackPage(),
  (FeedbackDetailPage).toString(): (context) => FeedbackDetailPage(),
  (AboutPage).toString(): (context) => AboutPage(),
};
