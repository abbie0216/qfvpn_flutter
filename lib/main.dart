import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qfvpn/bloc/feedback/add_feedback_bloc.dart';
import 'package:qfvpn/bloc/feedback/feedback_detail_bloc.dart';
import 'package:qfvpn/bloc/feedback/feedback_list_bloc.dart';
import 'package:qfvpn/bloc/home/option_btn_bloc.dart';
import 'package:qfvpn/bloc/home/vpn_bloc.dart';
import 'package:qfvpn/bloc/login/register_bloc.dart';
import 'package:qfvpn/bloc/share/share_bloc.dart';
import 'package:qfvpn/bloc/vip/order_history_bloc.dart';
import 'package:qfvpn/bloc/vip/product_selector_bloc.dart';
import 'package:qfvpn/routes.dart';

import 'bloc/home/home_bloc.dart';
import 'bloc/home/line_selector_bloc.dart';
import 'bloc/login/forgot_pw_bloc.dart';
import 'bloc/login/login_bloc.dart';
import 'bloc/me/about/about_bloc.dart';
import 'bloc/me/coupon/coupon_bloc.dart';
import 'bloc/me/me_bloc.dart';
import 'bloc/me/news/news_bloc.dart';
import 'bloc/me/news/news_detail_bloc.dart';
import 'bloc/me/points/points_bloc.dart';
import 'bloc/me/points/points_detail_bloc.dart';
import 'bloc/pay/pay_bloc.dart';
import 'bloc/setting/binding_bloc.dart';
import 'bloc/setting/pw_change_bloc.dart';
import 'bloc/setting/setting_bloc.dart';
import 'bloc/sharedetail/share_detail_bloc.dart';
import 'bloc/splash/splash_bloc.dart';
import 'bloc/vip/order_history_detail_bloc.dart';
import 'bloc/vip/vip_bloc.dart';
import 'model/api/api_repository.dart';
import 'model/config/config_data.dart';
import 'model/config/config_provider.dart';
import 'page/splash/splash_page.dart';


Future<void> main() async {
  Fimber.plantTree(DebugTree());

  var configProvider = ConfigProvider(
    data: ConfigData(flavor: 'dev', apiBaseUrl: 'https://qfvpn1.com'),
    child: App(),
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(configProvider);
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _configData = ConfigProvider.of(context)?.data;

    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
              create: (context) => ApiRepository(_configData?.apiBaseUrl ?? '')),
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => SplashBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => LoginBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => RegisterBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => ForgotPwBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => HomeBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => MeBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => SettingBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => BindingBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => PwChangeBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => CouponBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => NewsBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => NewsDetailBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => PointsBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => PointsDetailBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => ShareBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => ShareDetailBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => VipBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => VpnBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => LineSelectorBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => FeedbackListBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => FeedbackDetailBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => AddFeedbackBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => OrderHistoryBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => OrderHistoryDetailBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => AboutBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => PayBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => OptionBtnBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
              BlocProvider(
                  create: (context) => ProductSelectorBloc(
                      apiRepository:
                      RepositoryProvider.of<ApiRepository>(context))),
            ],
            child: MaterialApp(
              theme: ThemeData(
                primaryColor: Colors.black,
              ),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              debugShowCheckedModeBanner: false,
              initialRoute: (SplashPage).toString(),
              routes: routes,

            )));
  }
}